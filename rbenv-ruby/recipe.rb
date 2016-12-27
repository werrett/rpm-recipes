# Build and install Ruby with the Rbenv tool
# https://github.com/sstephenson/rbenv
class RbenvRuby < FPM::Cookery::Recipe
  description 'The Ruby virtual machine installed via Rbenv'

  name     'rbenv-ruby'
  version  '1.9.3-p551'
  revision 'sbx'
  homepage 'http://www.ruby-lang.org/'

  # Use Rbenv to pull down the correct Ruby source
  source "", :with => :noop

  section 'interpreters'

  provides  "rbenv-ruby-#{version}"
  conflicts "rbenv-ruby-#{version}"
  replaces  "rbenv-ruby-#{version}"

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:fedora, :redhat, :centos] do
    build_depends 'rbenv', 'ruby-build'
    depends       'rbenv', 'ruby-build'
  end

  def build
    system("rbenv install --force #{version}")
  end

  def install
    sourcedir = "/usr/share/rbenv/versions/#{version}"
    installdir = builddir(version)
    system "ln -s #{sourcedir} #{installdir}"

    share('rbenv/versions').install installdir
  end
end
