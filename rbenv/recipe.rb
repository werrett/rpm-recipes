class Rbenv < FPM::Cookery::Recipe
  description 'Groom your apps Ruby environment'

  name     'rbenv'
  version  '0.4.0'
  revision '0.werrett'
  homepage 'https://github.com/sstephenson/rbenv'

  source   'https://github.com/sstephenson/rbenv',
    :with => :git, :tag => "v#{version}"

  section 'languages'

  provides  'rbenv'
  conflicts 'rbenv'
  replaces  'rbenv'

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:redhat, :fedora, :centos] do
    build_depends  'gcc', 'zlib', 'autoconf', 'readline', 'ruby-devel',
                   'zlib-devel', 'openssl', 'openssl-devel'
  end

  def build
  end

  def install
    sourcedir = builddir("#{name}-tag-v#{version}")
    installdir = builddir("#{name}")
    system "ln -s #{sourcedir} #{installdir}"
    system "mkdir #{installdir}/shims"

    share.install installdir
    
    # Set RBENV system-wide via a bash profile
    etc('profile.d').install workdir('rbenv.profile'), 'rbenv.sh'
  end
end
