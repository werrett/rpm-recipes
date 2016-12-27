class Massren < FPM::Cookery::Recipe
  description 'Easily rename multiple files using your text editor'

  name     'massren'
  version  '20161227'
  revision 'sbx'
  homepage 'https://github.com/laurent22/massren'

  source 'https://github.com/laurent22/massren',
    :with => :git, :ref => '4de39fa7117e4a8a40805ec17d8d584aa5253452'

  section 'utilities'

  provides  name
  conflicts name
  replaces  name

  # Define the build and install dependancies for RedHat-a-likes (RPM names)
  platforms [:redhat, :fedora, :centos] do
    build_depends 'golang'
  end

  def build
    ENV['GOPATH'] = builddir
    ENV['GOBIN'] = builddir('bin')
    system "go get"
    system "go build"
  end

  def install
    bin.install builddir("bin/#{name}-HEAD"), name
  end
end
