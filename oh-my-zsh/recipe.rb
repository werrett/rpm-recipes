class OhMyZsh < FPM::Cookery::Recipe
  description 'A framework for managing your Zsh configuration.'

  name     'oh-my-zsh'
  version  '20150218'
  revision '0.werrett'
  homepage 'http://ohmyz.sh/'

  # Pull from git:
  source   'https://github.com/robbyrussell/oh-my-zsh',
    :with => :git, :ref => "5ee54032da9e5f9c5bd96dae877fbf6e08ad7af6"

  section 'shell'

  provides  name
  conflicts name
  replaces  name

  # Dependency RPM names for RHEL like OSs
  platforms [:fedora, :redhat, :centos] do
    build_depends 'git'
    depends       'zsh'
  end

  def build
    # No building required, just provides configuration
  end

  def install
    sourcedir = builddir("oh-my-zsh-HEAD")
    installdir = builddir('oh-my-zsh')
    system "ln -s #{sourcedir} #{installdir}"

    share.install installdir
    # Include my custom 'sling' theme 
    share('oh-my-zsh/custom/').install workdir('sling.zsh-theme')
  end
end
