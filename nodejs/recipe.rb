# Originally from <https://github.com/bernd/fpm-recipes/>
class NodeJS < FPM::Cookery::Recipe
  description 'An event-driven, non-blocking I/O server-side language.'

  name     'nodejs'
  version  '6.9.1'
  revision 'sbx'
  homepage 'http://nodejs.org/'

  source   "http://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"
  sha256   'a98997ca3a4d10751f0ebe97839b2308a31ae884b4203cda0c99cf36bc7fe3bf'

  section 'interpreters'

  # Dependency RPM names for RHEL like OSs
  platforms [:fedora, :redhat, :centos] do
    build_depends 'openssl-devel', 'clang', 'python'
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
