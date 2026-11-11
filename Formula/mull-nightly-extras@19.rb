class MullNightlyExtrasAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794438332"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-19/versions/0.37.0.trunk1794438332/Mull-Extras-19-0.37.0.trunk1794438332-LLVM-19.1.7-macOS-aarch64-26.7.2.zip"
      sha256 "427cc7efe141f5865148e22d069a3306e3d94c1e3776de2a007100ec93869b02"
    end
  end

  conflicts_with "mull-extras@19", because: "both install mull-rewriter-19"
  conflicts_with "mull-testing-extras@19", because: "both install mull-rewriter-19"
  def install
    bin.install "bin/mull-instrument-19"
    bin.install "bin/mull-rewriter-19"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 19 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-19
        mull-rewriter-19

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-19", shell_output("#{bin}/mull-instrument-19 --help")
    assert_match "mull-rewriter-19", shell_output("#{bin}/mull-rewriter-19 --help")
  end
end
