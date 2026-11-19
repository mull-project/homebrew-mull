class MullNightlyExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795124032"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-23/versions/0.39.1.trunk1795124032/Mull-Extras-23-0.39.1.trunk1795124032-LLVM-23.1.5-macOS-aarch64-26.7.2.zip"
      sha256 "1f23b8dd7dadcd18773a12d593ebfbff253814742a5a9a7770f37ddc259ea0d1"
    end
  end

  conflicts_with "mull-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-testing-extras@23", because: "both install mull-rewriter-23"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-23"
    bin.install "mull-rewriter-23"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 23 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-23
        mull-rewriter-23

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-23", shell_output("#{bin}/mull-instrument-23 --help")
    assert_match "mull-rewriter-23", shell_output("#{bin}/mull-rewriter-23 --help")
  end
end
