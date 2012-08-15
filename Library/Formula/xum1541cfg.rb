require 'formula'

class Xum1541cfg < Formula
  homepage 'http://www.root.org/~nate/c64/xum1541/'
  url 'http://www.root.org/~nate/c64/xum1541cfg.tar.gz'
  sha1 'b41e718f9b79662b27ec4b02443a4bb65b9dcc02'
  version '1.0'
  
  # xum1541cfg comes with its own version von dfu-programmer. not sure if this is a good idea
  # depends_on 'dfu-programmer'

  def install
    system "make", "-f", "LINUX/Makefile"
    bin.install 'xum1541cfg'
  end

  def test
    system "xum1541cfg"
  end
  
  def caveats; <<-EOS.undent
    This is just the program to update the firmware of your XUM1541 device
    
    You'll still need to download the actual firmware (*.hex file) from
    http://opencbm.git.sourceforge.net/git/gitweb.cgi?p=opencbm/opencbm;a=tree;f=xum1541
    EOS
  end
end
