class OhMyZsh < FPM::Cookery::Recipe
  description 'A framework for managing your Zsh configuration.'

  name     'oh-my-zsh'
  version  '20161227'
  revision 'sbx'
  homepage 'http://ohmyz.sh/'

  # Pull from git:
  source   'https://github.com/robbyrussell/oh-my-zsh',
    :with => :git, :ref => '97c03841691021f916c46b2fd2d089d7970400aa'

  section 'shell'

  provides  name
  conflicts name
  replaces  name

  arch 'noarch'

  # Dependency RPM names for RHEL like OSs
  platforms [:fedora, :redhat, :centos] do
    build_depends 'git'
    depends       'zsh'
  end

  def build
    # No building required, just provides configuration
  end

  def install
    sourcedir = builddir('oh-my-zsh-HEAD')
    installdir = builddir('oh-my-zsh')
    system "ln -s #{sourcedir} #{installdir}"

    share.install installdir

    # Include my custom 'sling' theme
    share('oh-my-zsh/custom/').install workdir('sling.zsh-theme')
  end
end
