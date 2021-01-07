class MullStable < Formula
  version "0.9.0"
  desc "LLVM-based mutation testing for C and C++"
  homepage "https://github.com/mull-project/mull"
  url "https://dl.bintray.com/mull-project/macos/Mull-0.9.0-LLVM-11.0-macOS-10.15.7.zip"
  sha256 "d56b64e56730d0974859e7a0664a329dfed0f582d38c55457e74e6426954e3c4"

  def install
    bin.install "bin/mull-cxx"
  end

  test do
    system bin/"mull-cxx", "--version"
  end
end

