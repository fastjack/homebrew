require 'formula'

class Nibtools < Formula
  homepage 'http://c64preservation.com/'
  # No downloadable source archives (that I could find). Resorting to SVN
  # url 'http://c64preservation.com/files/nibtools/nibtools-amd64-r567.zip'
  # sha1 'd6bfa55190faa2d4e9846d3b4fa8b603d55c0240'
  version '0.5.0'
  head 'https://c64preservation.com/svn/nibtools/trunk/', :using => :svn

  depends_on 'opencbm'
  
  def install
    system "make", "-f", "GNU/Makefile", "CBM_LNX_PATH=/usr/local/Cellar/opencbm/HEAD", "linux"
    bin.install 'nibconv', 'nibread', 'nibrepair', 'nibscan', 'nibwrite'
    doc.install 'readme.txt'
  end

  def test
    system "nibconv"
  end
end
