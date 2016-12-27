# Based off <https://github.com/bernd/fpm-recipes/blob/master/nginx/recipe.rb>
class Nginx < FPM::Cookery::Recipe
  description 'A high performance web server and reverse proxy server'

  name     'nginx'
  version  '1.11.7'
  revision 'sbx'
  sha256   '0d55beb52b2126a3e6c7ae40f092986afb89d77b8062ca0974512b8c76d9300e'

  homepage 'http://nginx.org/'
  source   "http://nginx.org/download/nginx-#{version}.tar.gz"

  section 'web'

  provides  'nginx'
  conflicts 'nginx'
  replaces  'nginx'

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:redhat, :fedora, :centos] do
    build_depends 'openssl-devel', 'pcre-devel'
  end

  post_install   'post-install'
  post_uninstall 'post-uninstall'

  def build
    # HttpHeadersMore Module patches - Needed to "remove" headers while proxying
    # http://wiki.nginx.org/HttpHeadersMoreModule
    system 'wget https://github.com/openresty/headers-more-nginx-module/archive/v0.25.tar.gz'
    system 'tar zxfv v0.25.tar.gz -C ..'

    configure \
      '--with-http_ssl_module',
      '--with-http_gzip_static_module',
      '--with-pcre',
      '--with-http_realip_module',
      "--add-module=#{builddir}/headers-more-nginx-module-0.25/",

      :prefix => prefix,

      :user =>  'nginx',
      :group => 'nginx',

      :pid_path => '/var/run/nginx.pid',
      :lock_path => '/var/lock/subsys/nginx',
      :conf_path => '/etc/nginx/nginx.conf',
      :http_log_path => '/var/log/nginx/access.log',
      :error_log_path => '/var/log/nginx/error.log',
      :http_proxy_temp_path => '/var/lib/nginx/proxy',
      :http_fastcgi_temp_path => '/var/lib/nginx/fastcgi',
      :http_client_body_temp_path => '/var/lib/nginx/body',
      :http_uwsgi_temp_path => '/var/lib/nginx/uwsgi',
      :http_scgi_temp_path => '/var/lib/nginx/scgi'

    make
  end

  def install
    # Include basic startup script
    (etc/'init.d').install_p(workdir/'nginx.init.d', 'nginx')

    # Include basic config
    (etc/'nginx').install Dir['conf/*']

    # Include a default site definition
    (share/'nginx/html').install Dir['html/*']

    # Nginx server binary
    sbin.install Dir['objs/nginx']

    # Install man page
    man8.install Dir['objs/nginx.8']
    system 'gzip', man8/'nginx.8'

    # Create required support dirs
    %w(log/nginx lib/nginx).map do |dir|
      (var/dir).mkpath
    end

    # Example config files
    (etc/'nginx/conf.d').mkpath
    (etc/'nginx').install_p(workdir/'nginx.conf')
    (etc/'nginx/conf.d').install_p(workdir/'virtual.conf')
    (etc/'nginx/conf.d').install_p(workdir/'ssl.conf')
  end
end
