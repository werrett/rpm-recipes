class VimEditorConfig < FPM::Cookery::Recipe
  description 'VIM plugin that maintains consistent coding styles'

  name     'vim-editorconfig'
  version  '20161227'
  revision 'sbx'
  homepage 'http://editorconfig.org/'

  source   'https://github.com/editorconfig/editorconfig-vim',
    :with => :git, :ref => 'a459b8cfef00100da40fd69c8ae92c4d1e63e1d2'

  section 'editor'

  provides  name
  conflicts name
  replaces  name
  
  arch 'noarch'

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
