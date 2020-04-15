class MullStable < Formula
  version "0.7.0"
  desc "LLVM-based mutation testing for C and C++"
  homepage "https://github.com/mull-project/mull"
  url "https://dl.bintray.com/mull-project/macos/pool/main/m/Mull-0.7.0-LLVM-9.0-macOS-10.15.3.zip"
  sha256 "ead397a4c57f60337a2cf02394b65e500a60691892ecadd2ae36cba8317b10c6"

  def install
    bin.install "bin/mull-cxx"
  end

  test do
    system bin/"mull-cxx", "--version"
  end
end

