class MullTestingExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.pr1224"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-23/versions/0.38.0.pr1224/Mull-Extras-23-0.38.0.pr1224-LLVM-23.1.4-macOS-aarch64-26.7.2.zip"
      sha256 "208757b2a29e2a02fc6ecbd3162d7bd214937e9b684486bc38205617177c61eb"
    end
  end

  conflicts_with "mull-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-nightly-extras@23", because: "both install mull-rewriter-23"
  def install
    bin.install "bin/mull-instrument-23"
    bin.install "bin/mull-rewriter-23"
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
