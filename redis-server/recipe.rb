class RedisServer < FPM::Cookery::Recipe
  description 'An advanced key-value store'

  name     'redis-server'
  version  '3.2.6'
  revision 'sbx'
  homepage 'http://redis.io'

  source   "http://download.redis.io/releases/redis-#{version}.tar.gz"
  sha1     '0c7bc5c751bdbc6fabed178db9cdbdd948915d1b'

  section      'database'

  conflicts    'redis-server'
  config_files '/etc/redis/redis.conf'

  post_install 'post-install'

  def build
    make

    # Modify default config file.
    inline_replace 'redis.conf' do |s|
      s.gsub! 'daemonize no', 'daemonize yes'
      s.gsub! 'dir ./', 'dir /var/lib/redis'
      s.gsub! 'logfile ""', 'logfile "/var/log/redis/redis-server.log"'
    end
  end

  def install

    # Create redis directories
    %w( lib/redis log/redis ).each do |p|
      var(p).mkpath
    end

    # Install key binaries into /usr/bin
    bin.install ['src/redis-server', 'src/redis-cli']

    # Install config
    etc('redis').install 'redis.conf'

    # Install init file to /etc/init.d/redis-server
    etc('init.d').install_p(workdir('redis-server.init'), 'redis-server')
  end
end
