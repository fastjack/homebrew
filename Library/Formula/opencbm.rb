require 'formula'

class Opencbm < Formula
  homepage 'http://www.trikaliotis.net/opencbm'
  # The newest sources at SourceForge are from 2007 and won't compile. For now I'll go with HEAD
  # url 'http://sourceforge.net/projects/opencbm/files/opencbm/opencbm-0.4.2a/opencbm-0.4.2a-src.zip/download'
  # sha1 '4eb3653609e4bc0725c0f2a8f4447e6928616e9f'
  head 'git://opencbm.git.sourceforge.net/gitroot/opencbm/opencbm', :using => :git

  depends_on 'cc65'
  depends_on 'libusb-compat'
  
  def patches
    DATA
  end

  def install
    ENV.deparallelize
    ENV.no_optimization
    system "make", "-C", "opencbm", "-f", "LINUX/Makefile", "PREFIX=#{prefix}", "MANDIR=#{man1}", "all"
    system "mkdir", "-p", "#{include}"
    system "make", "-C", "opencbm", "-f", "LINUX/Makefile", "PREFIX=#{prefix}", "MANDIR=#{man1}", "install-all"
  end

  def test
    system "#{bin}/cbmctrl", "--version"
  end
end

__END__
diff --git a/opencbm/LINUX/config.make b/opencbm/LINUX/config.make
index 5e4f773..d685c61 100644
--- a/opencbm/LINUX/config.make
+++ b/opencbm/LINUX/config.make
@@ -123,7 +123,7 @@ ifeq "$(OS)" "Darwin"
 ETCDIR=$(PREFIX)/etc
 
 # Use MacPort's libusb-legacy for now
-LIBUSB_CONFIG  = /opt/local/bin/libusb-legacy-config
+LIBUSB_CONFIG  = /usr/local/bin/libusb-config
 LIBUSB_CFLAGS  = $(shell $(LIBUSB_CONFIG) --cflags)
 LIBUSB_LDFLAGS =
 LIBUSB_LIBS    = $(shell $(LIBUSB_CONFIG) --libs)
