class MullExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-18/versions/0.38.0/Mull-Extras-18-0.38.0-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "a311da1c554251f2fe2941b39112fb24467f3803467228cd0a55cb91501114f8"
    end
  end

  conflicts_with "mull-nightly-extras@18", because: "both install mull-rewriter-18"
  conflicts_with "mull-testing-extras@18", because: "both install mull-rewriter-18"
  def install
    bin.install "bin/mull-instrument-18"
    bin.install "bin/mull-rewriter-18"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 18 support.

      Binaries installed:
        mull-instrument-18
        mull-rewriter-18

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-18", shell_output("#{bin}/mull-instrument-18 --help")
    assert_match "mull-rewriter-18", shell_output("#{bin}/mull-rewriter-18 --help")
  end
end
