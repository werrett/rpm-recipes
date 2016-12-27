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
    builddir.mkdir
    builddir('src/github.com/laurent22').mkdir
    sourcedir = builddir("#{name}-HEAD")
    system "ln -s #{sourcedir} #{builddir}/src/github.com/laurent22/massren"
    system "go get"
    system "go install github.com/laurent22"
  end

  def install
    bin.install builddir('massren-HEAD'), 'massren'
  end
end
