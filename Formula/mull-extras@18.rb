class MullExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.39.0"
  license "Apache-2.0"

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-18/versions/0.39.0/Mull-Extras-18-0.39.0-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "3ed0d26779ac7282bc30310c481219c45d42bea4c8eb035ffae03f7218e08aa3"
    end
  end

  conflicts_with "mull-nightly-extras@18", because: "both install mull-rewriter-18"
  conflicts_with "mull-testing-extras@18", because: "both install mull-rewriter-18"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-18"
    bin.install "mull-rewriter-18"
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
