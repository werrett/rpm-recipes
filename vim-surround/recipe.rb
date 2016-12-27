class VimSurround < FPM::Cookery::Recipe
  description 'VIM plugin that makes quoting and parenthesizing simple'

  name     'vim-surround'
  version  '20150217'
  revision '0.werrett'
  homepage 'https://github.com/tpope/vim-surround'

  source   'https://github.com/tpope/vim-surround',
    :with => :git, :ref => 'fd75eb2cb2ffe85a457445cb152d5a6c7acda140'

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
