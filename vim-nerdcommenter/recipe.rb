class VimNerdCommenter < FPM::Cookery::Recipe
  description 'VIM plugin that makes commenting / uncommenting easy'

  name     'vim-nerdcommenter'
  version  '20150217'
  revision '0.werrett'
  homepage 'https://github.com/scrooloose/nerdcommenter.git'

  source   'https://github.com/scrooloose/nerdcommenter.git',
    :with => :git, :ref => '6549cfde45339bd4f711504196ff3e8b766ef5e6'

  section 'editor'

  provides  name
  conflicts name
  replaces  name

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:redhat, :fedora, :centos] do
    depends       'vim-enhanced'
    build_depends 'git'
  end

  def build
  end

  def install
    sourcedir = builddir("#{name}-HEAD")
    installdir = builddir(name)
    system "ln -s #{sourcedir} #{installdir}"

    share('vim/global/bundle').install installdir
  end
end
