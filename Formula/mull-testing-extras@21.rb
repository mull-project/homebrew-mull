class MullTestingExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.pr1224"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-21/versions/0.38.0.pr1224/Mull-Extras-21-0.38.0.pr1224-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "398f5b036f86d8c56df7714ad09afff29dc769effa7350650be7f36501fa668c"
    end
  end

  conflicts_with "mull-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-nightly-extras@21", because: "both install mull-rewriter-21"
  def install
    bin.install "bin/mull-instrument-21"
    bin.install "bin/mull-rewriter-21"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 21 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-21
        mull-rewriter-21

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-21", shell_output("#{bin}/mull-instrument-21 --help")
    assert_match "mull-rewriter-21", shell_output("#{bin}/mull-rewriter-21 --help")
  end
end
