class VimEditorConfig < FPM::Cookery::Recipe
  description 'VIM plugin that maintains consistent coding styles'

  name     'vim-editorconfig'
  version  '20150217'
  revision '0.werrett'
  homepage 'http://editorconfig.org/'

  source   'https://github.com/editorconfig/editorconfig-vim.git',
    :with => :git, :ref => '77875eff51d87eb9c9986ff75f2361f4ac629cd3'

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
