class MullTestingExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.pr1235"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-23/versions/0.39.1.pr1235/Mull-Extras-23-0.39.1.pr1235-LLVM-23.1.5-macOS-aarch64-26.7.2.zip"
      sha256 "643d61849c53434f7a6a21fe6568eefee2856fcde7c1b54bd20c1fd3db4ec15c"
    end
  end

  conflicts_with "mull-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-nightly-extras@23", because: "both install mull-rewriter-23"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-23"
    bin.install "mull-rewriter-23"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 23 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-23
        mull-rewriter-23

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-23", shell_output("#{bin}/mull-instrument-23 --help")
    assert_match "mull-rewriter-23", shell_output("#{bin}/mull-rewriter-23 --help")
  end
end
