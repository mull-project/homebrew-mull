class MullExtrasAT20 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 20 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@20"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-20/versions/0.38.0/Mull-Extras-20-0.38.0-LLVM-20.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "5ba07b3413f0d90e0190b116e97361df81e5f5240ccc38cb11a960e4b500eefc"
    end
  end

  conflicts_with "mull-nightly-extras@20", because: "both install mull-rewriter-20"
  conflicts_with "mull-testing-extras@20", because: "both install mull-rewriter-20"
  def install
    bin.install "bin/mull-instrument-20"
    bin.install "bin/mull-rewriter-20"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 20 support.

      Binaries installed:
        mull-instrument-20
        mull-rewriter-20

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-20", shell_output("#{bin}/mull-instrument-20 --help")
    assert_match "mull-rewriter-20", shell_output("#{bin}/mull-rewriter-20 --help")
  end
end
