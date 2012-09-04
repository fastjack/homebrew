require 'formula'

class AcmeLib < Formula
  url 'http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/acme/ACME_Lib2.zip'
  version '2.0'
  sha1 '699f85edec7e28feb7f50abbf4fc2380757bb4f1'
end

class Acme < Formula
  homepage 'http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/acme/'
  url 'http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/acme/current/acme091src.tar.gz'
  sha1 '7104ea01a2ca2962294aaac4974e10c6486534a8'
  version '0.91'
  
  option "with-full-acmelib", "Install the full ACME library"
  option "without-acmelib", "Do not install the ACME library at all"

  def install
    system "make", "-C", "src", "all"
    system "make", "-C", "src", "BINDIR=#{prefix}", "install"
    (share+'acme').mkpath
    if build.include? "with-full-acmelib"
      # install the full (additional) ACME library
      AcmeLib.new.brew { mv Dir['ACME_Lib/*'], "#{share}/acme" }
    else
      # just install the default ACME library (unless explicitly told not to)
      (share+'acme').install Dir['ACME_Lib/*'] unless build.include? "without-acmelib"
    end
  end

  def test
    system "#{bin}/acme", "--version"
  end
  
  def caveats
    s = <<-EOS
# Install notes

Along with the ACME assembler the ACME library was installed into 
#{share+'acme'}. If you want to make use of 
that library you will need to set the ACME environment variable 
to point to that path. You can do this by adding the following
line to your ~/.profile, ~/.bash_profile or ~/.zshrc:

ACME=#{share+'acme'} && export ACME

EOS
  end
end
