class VimNerdCommenter < FPM::Cookery::Recipe
  description 'VIM plugin that makes commenting / uncommenting easy'

  name     'vim-nerdcommenter'
  version  '20161227'
  revision 'sbx'
  homepage 'https://github.com/scrooloose/nerdcommenter'

  source   'https://github.com/scrooloose/nerdcommenter',
    :with => :git, :ref => '18cfe815501c8264844223a944eb388285b48caa'

  section 'editor'

  provides  name
  conflicts name
  replaces  name

  arch 'noarch'

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
