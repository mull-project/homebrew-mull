class MullExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.39.0"
  license "Apache-2.0"

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-21/versions/0.39.0/Mull-Extras-21-0.39.0-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "0270e40f28b7f4d7932cf5e4d8d46796c6bf321433ff8627e1cff25d0b29d0dd"
    end
  end

  conflicts_with "mull-nightly-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-testing-extras@21", because: "both install mull-rewriter-21"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-21"
    bin.install "mull-rewriter-21"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 21 support.

      Binaries installed:
        mull-instrument-21
        mull-rewriter-21

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-21", shell_output("#{bin}/mull-instrument-21 --help")
    assert_match "mull-rewriter-21", shell_output("#{bin}/mull-rewriter-21 --help")
  end
end
