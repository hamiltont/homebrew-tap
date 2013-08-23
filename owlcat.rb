require 'formula'

class Owlcat < Formula
  homepage 'http://www.astron.nl/meqwiki-data/users/oms/Owlcat-plotms-tutorial.purrlog/'
# Waiting for next release after 1.2.0 to be supported on Mac
#  url 'https://svn.astron.nl/Owlcat/release/Owlcat/release-1.2.0'
  # Repository after 8761 contains both Pyxis dir and pyxis script which clash on HFS+
  head 'https://svn.astron.nl/Owlcat/trunk/Owlcat', :revision => '8761'

  depends_on :python => ['pyfits', 'numpy', 'matplotlib']
  depends_on 'pyrap'
  depends_on 'cattery'

  def install
    inreplace 'owlcat.sh', 'dir=`dirname $(readlink -f $0)`', "dir='#{libexec}'"
    bin.install 'owlcat.sh'
    mv "#{bin}/owlcat.sh", "#{bin}/owlcat"
    mkdir_p "#{python.site_packages}"
    # Since Cattery while be installed in the usual path, we don't need to look for it
    inreplace 'Owlcat/__init__.py', '"Cattery"', ''
    cp_r 'Owlcat', "#{python.site_packages}/"
    libexec.install Dir['*.py'], Dir['*.sh'], 'commands.list'
    doc.install 'tutorial/Owlcat-plotms-tutorial.purrlog'
    doc.install 'README', 'imager.conf.example', 'owlcat-logo.jpg'
  end

  def caveats
    python.standard_caveats if python
  end
end
