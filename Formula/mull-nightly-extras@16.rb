class MullNightlyExtrasAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795295400"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-16/versions/0.39.1.trunk1795295400/Mull-Extras-16-0.39.1.trunk1795295400-LLVM-16.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "d4eefe8850d445aa9fb2c8b2022676c43c8ea08a6cdaa9273e18cb006b168e42"
    end
  end

  conflicts_with "mull-extras@16", because: "both install mull-rewriter-16"
  conflicts_with "mull-testing-extras@16", because: "both install mull-rewriter-16"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-16"
    bin.install "mull-rewriter-16"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 16 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-16
        mull-rewriter-16

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-16", shell_output("#{bin}/mull-instrument-16 --help")
    assert_match "mull-rewriter-16", shell_output("#{bin}/mull-rewriter-16 --help")
  end
end
