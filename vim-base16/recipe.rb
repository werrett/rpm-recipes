class VimBase16 < FPM::Cookery::Recipe
  description 'VIM plugin that provides color schemes for hackers'

  name     'vim-base16'
  version  '20150217'
  revision 'sbx'
  homepage 'https://github.com/chriskempson/base16'

  source   'https://github.com/chriskempson/base16-vim.git',
    :with => :git, :ref => '851a73721737409bef2d076c7547fefa1fa93684'

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
