class MullNightlyExtrasAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794438332"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-17/versions/0.37.0.trunk1794438332/Mull-Extras-17-0.37.0.trunk1794438332-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "bcace490268b506343e68aa9a4279868c62b8007d8c46dc3ec8546acd2fb04fc"
    end
  end

  conflicts_with "mull-extras@17", because: "both install mull-rewriter-17"
  conflicts_with "mull-testing-extras@17", because: "both install mull-rewriter-17"
  def install
    bin.install "bin/mull-instrument-17"
    bin.install "bin/mull-rewriter-17"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 17 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-17
        mull-rewriter-17

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-17", shell_output("#{bin}/mull-instrument-17 --help")
    assert_match "mull-rewriter-17", shell_output("#{bin}/mull-rewriter-17 --help")
  end
end
