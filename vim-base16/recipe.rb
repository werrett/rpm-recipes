class VimBase16 < FPM::Cookery::Recipe
  description 'VIM plugin that provides Syntax highlighting for hackers'

  name     'vim-base16'
  version  '20161227'
  revision 'sbx'
  homepage 'http://chriskempson.com/projects/base16'

  source   'https://github.com/chriskempson/base16-vim',
    :with => :git, :ref => '9bc705129abec076c3336ec806b6defad0c246f0'

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
