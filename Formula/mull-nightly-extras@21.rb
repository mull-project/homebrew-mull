class MullNightlyExtrasAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795158975"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-21/versions/0.39.1.trunk1795158975/Mull-Extras-21-0.39.1.trunk1795158975-LLVM-21.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "97645289d9514b7ac51b1a9da61ebe229622c946b0c97d79fa476158a6bb7f57"
    end
  end

  conflicts_with "mull-extras@21", because: "both install mull-rewriter-21"
  conflicts_with "mull-testing-extras@21", because: "both install mull-rewriter-21"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-21"
    bin.install "mull-rewriter-21"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 21 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-21
        mull-rewriter-21

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-21", shell_output("#{bin}/mull-instrument-21 --help")
    assert_match "mull-rewriter-21", shell_output("#{bin}/mull-rewriter-21 --help")
  end
end
