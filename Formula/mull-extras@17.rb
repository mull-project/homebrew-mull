class MullExtrasAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-17/versions/0.38.0/Mull-Extras-17-0.38.0-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "7ac498184033e7cd83f5b10eb14d4a78aa074e15afd743bdeb5eb37730651bfa"
    end
  end

  conflicts_with "mull-nightly-extras@17", because: "both install mull-rewriter-17"
  conflicts_with "mull-testing-extras@17", because: "both install mull-rewriter-17"
  def install
    bin.install "bin/mull-instrument-17"
    bin.install "bin/mull-rewriter-17"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 17 support.

      Binaries installed:
        mull-instrument-17
        mull-rewriter-17

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-17", shell_output("#{bin}/mull-instrument-17 --help")
    assert_match "mull-rewriter-17", shell_output("#{bin}/mull-rewriter-17 --help")
  end
end
