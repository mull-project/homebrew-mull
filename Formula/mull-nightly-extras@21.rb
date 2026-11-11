class MullNightlyExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794438332"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-21/versions/0.37.0.trunk1794438332/Mull-Extras-21-0.37.0.trunk1794438332-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "6df6e7843bc1a7f6482974e94e604b84b8e22974d2c8af8ca92d4ff1991c47ec"
    end
  end

  conflicts_with "mull-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-testing-extras@21", because: "both install mull-rewriter-21"
  def install
    bin.install "bin/mull-instrument-21"
    bin.install "bin/mull-rewriter-21"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 21 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-21
        mull-rewriter-21

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-21", shell_output("#{bin}/mull-instrument-21 --help")
    assert_match "mull-rewriter-21", shell_output("#{bin}/mull-rewriter-21 --help")
  end
end
