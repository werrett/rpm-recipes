class VimEunuch < FPM::Cookery::Recipe
  description 'VIM plugin helpers for the UNIX commands (eg. SudoWrite)'

  name     'vim-eunuch'
  version  '20161227'
  revision 'sbx'
  homepage 'https://github.com/tpope/vim-eunuch'

  source   'https://github.com/tpope/vim-eunuch',
    :with => :git, :ref => '7eeb681ff3caedc1c01e50966bc293951f7b3e21'

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
