class MullTestingExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.pr1227"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-extras-18/versions/0.38.0.pr1227/Mull-Extras-18-0.38.0.pr1227-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "fb8292b6e4f3e621ccc93eb28a9fc7af2d1aed8c19fe4c66ead3fe69de3a3881"
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
