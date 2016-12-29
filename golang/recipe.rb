# Based off <https://github.com/bernd/fpm-recipes/blob/master/golang/recipe.rb>
class Golang < FPM::Cookery::Recipe
  description 'A language to build simple, reliable, and efficient software'

  name     'golang'
  version  '1.7.4'
  revision 'sbx'
  homepage 'http://golang.org/'

  source "https://storage.googleapis.com/golang/go#{version}.linux-amd64.tar.gz"
  sha256 '47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b'

  section 'development'

  config_files '/etc/profile.d/go.sh'

  provides 'golang'
  conflicts 'golang', 'golang-go', 'golang-src', 'golang-doc'
  replaces 'golang', 'golang-go', 'golang-src', 'golang-doc'

  def build
    # Null build function. It's go, so the Linux binary
    # works on all Linux platforms. No building required!
  end

  def install
    mkdir_p share
    cp_r builddir('go'), share('go')
    # Use a system-wide bash profile to set the GOROOT
    etc('profile.d').install workdir('go.profile'), 'go.sh'
  end
end
