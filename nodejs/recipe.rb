# Originally from <https://github.com/bernd/fpm-recipes/>
class NodeJS < FPM::Cookery::Recipe
  description 'An event-driven, non-blocking I/O server-side language.'

  name     'nodejs'
  version  '6.9.2'
  revision 'sbx'
  homepage 'http://nodejs.org/'

  source   "http://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"
  sha256    '997121460f3b4757907c2d7ff68ebdbf87af92b85bf2d07db5a7cb7aa5dae7d9'

  section 'interpreters'

  # Dependency RPM names for RHEL like OSs
  platforms [:fedora, :redhat, :centos] do
    build_depends 'openssl-devel', 'clang', 'python'
    depends       'openssl'
  end

  def build
    # Compile with clang to avoid <https://github.com/nodejs/node/issues/1173>
    env['XX']='clang++'
    env['CC']='clang'
    configure :prefix => prefix, :debug => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir

    # Fixes issue described in https://github.com/joyent/node/issues/2192
    prefix('lib/node_modules/npm/man/man1').mkpath
  end
end
