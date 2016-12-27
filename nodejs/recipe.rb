# Originally from <https://github.com/bernd/fpm-recipes/>
class NodeJS < FPM::Cookery::Recipe
  description 'Evented I/O for V8 JavaScript'

  name     'nodejs'
  version  '0.12.5'
  revision 'sbx'
  homepage 'http://nodejs.org/'

  source   "http://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"
  sha1     'baecde8c2d297aa001a2a8ba2f2d086d970a13eb'

  section 'interpreters'

  # Dependency RPM names for RHEL like OSs
  platforms [:fedora, :redhat, :centos] do
    build_depends 'openssl-devel', 'gcc-c++', 'python'
    depends       'openssl'
  end

  def build
    configure :prefix => prefix, :debug => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir

    # Fixes issue described in https://github.com/joyent/node/issues/2192
    prefix('lib/node_modules/npm/man/man1').mkpath
  end
end
