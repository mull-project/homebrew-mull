class MullExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-21/versions/0.38.0/Mull-Extras-21-0.38.0-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "7421a9c9c4f5c3fee9a3cfe0adaddd688ece96e75783a5915e6003f2767a4d9c"
    end
  end

  conflicts_with "mull-nightly-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-testing-extras@21", because: "both install mull-rewriter-21"
  def install
    bin.install "bin/mull-instrument-21"
    bin.install "bin/mull-rewriter-21"
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
