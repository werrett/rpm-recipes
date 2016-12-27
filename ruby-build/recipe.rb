# Compile and install Ruby
class RubyBuild < FPM::Cookery::Recipe
  description 'A rbenv plugin to compile and install different versions of Ruby'

  name     'ruby-build'
  version  '20150519'
  revision '0.werrett'
  homepage 'https://github.com/sstephenson/ruby-build'

  # Pull from git:
  source   'https://github.com/sstephenson/ruby-build',
    :with => :git, :tag => "v#{version}"

  section 'languages'

  provides  'ruby-build'
  conflicts 'ruby-build'
  replaces  'ruby-build'

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:redhat, :fedora, :centos] do
    depends        'rbenv'
    build_depends  'gcc', 'zlib', 'autoconf', 'readline', 'ruby-devel',
                   'zlib-devel', 'openssl', 'openssl-devel'
  end

  def build
  end

  def install
    sourcedir = builddir("#{name}-tag-v#{version}")
    installdir = builddir("#{name}")
    system "ln -s #{sourcedir} #{installdir}"

    share('rbenv/plugins').install installdir
  end
end
