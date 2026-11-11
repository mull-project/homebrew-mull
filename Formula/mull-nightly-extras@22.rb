class MullNightlyExtrasAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794438332"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-22/versions/0.37.0.trunk1794438332/Mull-Extras-22-0.37.0.trunk1794438332-LLVM-22.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "2f473092453d4e3f93e20ba131527dd92cecdabc00156fe5e7eefca9ecfd6012"
    end
  end

  conflicts_with "mull-extras@22", because: "both install mull-rewriter-22"
  conflicts_with "mull-testing-extras@22", because: "both install mull-rewriter-22"
  def install
    bin.install "bin/mull-instrument-22"
    bin.install "bin/mull-rewriter-22"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 22 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-22
        mull-rewriter-22

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-22", shell_output("#{bin}/mull-instrument-22 --help")
    assert_match "mull-rewriter-22", shell_output("#{bin}/mull-rewriter-22 --help")
  end
end
