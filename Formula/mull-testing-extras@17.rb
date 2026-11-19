class MullTestingExtrasAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.39.0.pr1232"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-17/versions/0.39.0.pr1232/Mull-Extras-17-0.39.0.pr1232-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "d8e7cdf848ffb1c5725064a4061ff32372028b6c993e20a2c5fdfa0a96ca6f43"
    end
  end

  conflicts_with "mull-extras@17", because: "both install mull-rewriter-17"
  conflicts_with "mull-nightly-extras@17", because: "both install mull-rewriter-17"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-17"
    bin.install "mull-rewriter-17"
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
