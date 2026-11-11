class MullTestingExtrasAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.pr1224"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-17/versions/0.38.0.pr1224/Mull-Extras-17-0.38.0.pr1224-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "72554c5f716de59c733ee5d83be135b36a57150e1d99465d17443efb4939161a"
    end
  end

  conflicts_with "mull-extras@17", because: "both install mull-rewriter-17"
  conflicts_with "mull-nightly-extras@17", because: "both install mull-rewriter-17"
  def install
    bin.install "bin/mull-instrument-17"
    bin.install "bin/mull-rewriter-17"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 17 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-17
        mull-rewriter-17

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-17", shell_output("#{bin}/mull-instrument-17 --help")
    assert_match "mull-rewriter-17", shell_output("#{bin}/mull-rewriter-17 --help")
  end
end
