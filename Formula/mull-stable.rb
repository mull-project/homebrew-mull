class MullStable < Formula
  version "0.8.0"
  desc "LLVM-based mutation testing for C and C++"
  homepage "https://github.com/mull-project/mull"
  url "https://dl.bintray.com/mull-project/macos/Mull-0.8.0-LLVM-10.0-macOS-10.14.6.zip"
  sha256 "a86050fb98e9ecd7e8421e7cc1a225ce59b77d6264947cb8cdbc7699c142ace0"

  def install
    bin.install "bin/mull-cxx"
  end

  test do
    system bin/"mull-cxx", "--version"
  end
end

