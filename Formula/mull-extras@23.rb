class MullExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1"
  license "Apache-2.0"

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-extras-23/versions/0.39.1/Mull-Extras-23-0.39.1-LLVM-23.1.4-macOS-aarch64-26.7.2.zip"
      sha256 "912df1bf2476ae1e28d35429a3dc64190ee91b48493df936d86c9268f39b41fb"
    end
  end

  conflicts_with "mull-nightly-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-testing-extras@23", because: "both install mull-rewriter-23"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-23"
    bin.install "mull-rewriter-23"
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
