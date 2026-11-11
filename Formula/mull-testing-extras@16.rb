class MullTestingExtrasAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-16/versions/0.37.0.pr1223/Mull-Extras-16-0.37.0.pr1223-LLVM-16.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "9539d0115c5945d0932615738fd2b4e089ea36cecfd62b387de0fa7ffd721788"
    end
  end

  conflicts_with "mull-extras@16", because: "both install mull-rewriter-16"
  conflicts_with "mull-nightly-extras@16", because: "both install mull-rewriter-16"
  def install
    bin.install "bin/mull-instrument-16"
    bin.install "bin/mull-rewriter-16"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 16 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-16
        mull-rewriter-16

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-16", shell_output("#{bin}/mull-instrument-16 --help")
    assert_match "mull-rewriter-16", shell_output("#{bin}/mull-rewriter-16 --help")
  end
end
