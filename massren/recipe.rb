class Massren < FPM::Cookery::Recipe
  description 'Easily rename multiple files using your text edit'

  name     'massren'
  version  '20150325'
  revision '0.werrett'
  homepage 'https://github.com/laurent22/massren'

  source 'https://github.com/laurent22/massren',
    :with => :git, :ref => 'd77c4da85c'

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
