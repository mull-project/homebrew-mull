class MullTestingExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.39.0.pr1229"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-18/versions/0.39.0.pr1229/Mull-Extras-18-0.39.0.pr1229-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "30a64f23aff743430b7fa6772bf51b528899b5516853d1668e36044ef3857e15"
    end
  end

  conflicts_with "mull-extras@18", because: "both install mull-rewriter-18"
  conflicts_with "mull-nightly-extras@18", because: "both install mull-rewriter-18"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-18"
    bin.install "mull-rewriter-18"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 18 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-18
        mull-rewriter-18

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-18", shell_output("#{bin}/mull-instrument-18 --help")
    assert_match "mull-rewriter-18", shell_output("#{bin}/mull-rewriter-18 --help")
  end
end
