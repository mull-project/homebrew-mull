class MullExtrasAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-16/versions/0.38.0/Mull-Extras-16-0.38.0-LLVM-16.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "776117a7bdae3af532915e7bc3609888ecfe843fac4c522ab5330676ed41824f"
    end
  end

  conflicts_with "mull-nightly-extras@16", because: "both install mull-rewriter-16"
  conflicts_with "mull-testing-extras@16", because: "both install mull-rewriter-16"
  def install
    bin.install "bin/mull-instrument-16"
    bin.install "bin/mull-rewriter-16"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 16 support.

      Binaries installed:
        mull-instrument-16
        mull-rewriter-16

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-16", shell_output("#{bin}/mull-instrument-16 --help")
    assert_match "mull-rewriter-16", shell_output("#{bin}/mull-rewriter-16 --help")
  end
end
