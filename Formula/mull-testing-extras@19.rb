class MullTestingExtrasAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-19/versions/0.37.0.pr1223/Mull-Extras-19-0.37.0.pr1223-LLVM-19.1.7-macOS-aarch64-26.7.2.zip"
      sha256 "e2cbbeabbf866fdf74d06143fcc4c3cf651fb66074ab414016e029d072a14c13"
    end
  end

  conflicts_with "mull-extras@19", because: "both install mull-rewriter-19"
  conflicts_with "mull-nightly-extras@19", because: "both install mull-rewriter-19"
  def install
    bin.install "bin/mull-instrument-19"
    bin.install "bin/mull-rewriter-19"
  end

  def caveats
    <<~EOS
      Mull TESTING extra tools have been installed with LLVM 19 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-19
        mull-rewriter-19

      Their mutants run with mull-runner from mull-project/mull/mull-testing.
    EOS
  end

  test do
    assert_match "mull-instrument-19", shell_output("#{bin}/mull-instrument-19 --help")
    assert_match "mull-rewriter-19", shell_output("#{bin}/mull-rewriter-19 --help")
  end
end
