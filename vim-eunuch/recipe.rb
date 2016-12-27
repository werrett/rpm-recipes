class VimEunuch < FPM::Cookery::Recipe
  description 'VIM plugin helpers for the UNIX commands (eg. SudoWrite)'

  name     'vim-eunuch'
  version  '20150217'
  revision '0.werrett'
  homepage 'https://github.com/tpope/vim-eunuch.git'

  source   'https://github.com/tpope/vim-eunuch.git',
    :with => :git, :ref => 'e36b9a701dd3d8054e6b8a77b14710276a1d93c8'

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
