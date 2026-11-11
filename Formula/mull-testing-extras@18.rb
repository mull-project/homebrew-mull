class MullTestingExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-18/versions/0.37.0.pr1223/Mull-Extras-18-0.37.0.pr1223-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "eb78e55fa8c04f9d50e08653ce99af2ad40a25da12adcae45548185eea6fe17d"
    end
  end

  conflicts_with "mull-extras@18", because: "both install mull-rewriter-18"
  conflicts_with "mull-nightly-extras@18", because: "both install mull-rewriter-18"
  def install
    bin.install "bin/mull-instrument-18"
    bin.install "bin/mull-rewriter-18"
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
