class MullExtrasAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-22/versions/0.38.0/Mull-Extras-22-0.38.0-LLVM-22.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "85f1e0c5a2500f366c52982762f18f4c2c8f90e0c65a39563c83f2f2e949afdf"
    end
  end

  conflicts_with "mull-nightly-extras@22", because: "both install mull-rewriter-22"
  conflicts_with "mull-testing-extras@22", because: "both install mull-rewriter-22"
  def install
    bin.install "bin/mull-instrument-22"
    bin.install "bin/mull-rewriter-22"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 22 support.

      Binaries installed:
        mull-instrument-22
        mull-rewriter-22

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-22", shell_output("#{bin}/mull-instrument-22 --help")
    assert_match "mull-rewriter-22", shell_output("#{bin}/mull-rewriter-22 --help")
  end
end
