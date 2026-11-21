class MullTestingExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.pr1236"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-21/versions/0.39.1.pr1236/Mull-Extras-21-0.39.1.pr1236-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "5312e662458f8e1bcbabedb5a0a37ea9994928cba35584f6ff929aa1443f3076"
    end
  end

  conflicts_with "mull-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-nightly-extras@21", because: "both install mull-rewriter-21"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-21"
    bin.install "mull-rewriter-21"
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
