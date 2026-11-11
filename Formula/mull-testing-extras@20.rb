class MullTestingExtrasAT20 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 20 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@20"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-20/versions/0.37.0.pr1223/Mull-Extras-20-0.37.0.pr1223-LLVM-20.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "1520837e1ea649452e58b2a49bcc81b18c921a1978bdbcfd64067391469dde80"
    end
  end

  conflicts_with "mull-extras@20", because: "both install mull-rewriter-20"
  conflicts_with "mull-nightly-extras@20", because: "both install mull-rewriter-20"
  def install
    bin.install "bin/mull-instrument-20"
    bin.install "bin/mull-rewriter-20"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 20 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-20
        mull-rewriter-20

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-20", shell_output("#{bin}/mull-instrument-20 --help")
    assert_match "mull-rewriter-20", shell_output("#{bin}/mull-rewriter-20 --help")
  end
end
