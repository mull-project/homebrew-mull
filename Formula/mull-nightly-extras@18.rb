class MullNightlyExtrasAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1795042606"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-18/versions/0.38.0.trunk1795042606/Mull-Extras-18-0.38.0.trunk1795042606-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "80081d2631c16368bd3d0bff729334420ba1d537260d8d5cb7bdae40ae9c75c5"
    end
  end

  conflicts_with "mull-extras@18", because: "both install mull-rewriter-18"
  conflicts_with "mull-testing-extras@18", because: "both install mull-rewriter-18"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-18"
    bin.install "mull-rewriter-18"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 18 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-18
        mull-rewriter-18

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-18", shell_output("#{bin}/mull-instrument-18 --help")
    assert_match "mull-rewriter-18", shell_output("#{bin}/mull-rewriter-18 --help")
  end
end
