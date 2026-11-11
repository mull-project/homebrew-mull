class MullExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-23/versions/0.38.0/Mull-Extras-23-0.38.0-LLVM-23.1.4-macOS-aarch64-26.7.2.zip"
      sha256 "3dc54ec28e8d3ebf92d54d62824ba7bb8045ffa072478217dabbd1969d9fbb74"
    end
  end

  conflicts_with "mull-nightly-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-testing-extras@23", because: "both install mull-rewriter-23"
  def install
    bin.install "bin/mull-instrument-23"
    bin.install "bin/mull-rewriter-23"
  end

  def caveats
    <<~EOS
      Mull extra tools have been installed with LLVM 23 support.

      Binaries installed:
        mull-instrument-23
        mull-rewriter-23

      Their mutants run with mull-runner from mull-project/mull/mull.
    EOS
  end

  test do
    assert_match "mull-instrument-23", shell_output("#{bin}/mull-instrument-23 --help")
    assert_match "mull-rewriter-23", shell_output("#{bin}/mull-rewriter-23 --help")
  end
end
