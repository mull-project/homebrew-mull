class MullExtrasAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-19/versions/0.38.0/Mull-Extras-19-0.38.0-LLVM-19.1.7-macOS-aarch64-26.7.2.zip"
      sha256 "6607c12b64b7fe0ae1787f87ee57841c3dd5bb68088042d07383ce8599be1c13"
    end
  end

  conflicts_with "mull-nightly-extras@19", because: "both install mull-rewriter-19"
  conflicts_with "mull-testing-extras@19", because: "both install mull-rewriter-19"
  def install
    bin.install "bin/mull-instrument-19"
    bin.install "bin/mull-rewriter-19"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 19 support.

      Binaries installed:
        mull-instrument-19
        mull-rewriter-19

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-19", shell_output("#{bin}/mull-instrument-19 --help")
    assert_match "mull-rewriter-19", shell_output("#{bin}/mull-rewriter-19 --help")
  end
end
