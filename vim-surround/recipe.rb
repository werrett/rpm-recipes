class VimSurround < FPM::Cookery::Recipe
  description 'VIM plugin that makes quoting and parenthesizing simple'

  name     'vim-surround'
  version  '20161227'
  revision 'sbx'
  homepage 'https://github.com/tpope/vim-surround'

  source   'https://github.com/tpope/vim-surround',
    :with => :git, :ref => 'e49d6c2459e0f5569ff2d533b4df995dd7f98313'

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
