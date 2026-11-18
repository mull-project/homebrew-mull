class MullNightlyExtrasAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1795033210"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-22/versions/0.38.0.trunk1795033210/Mull-Extras-22-0.38.0.trunk1795033210-LLVM-22.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "676312ec3c286e77b98b0efcd806ed868aeb1c5e66d7a22639c8553c78fdc772"
    end
  end

  conflicts_with "mull-extras@22", because: "both install mull-rewriter-22"
  conflicts_with "mull-testing-extras@22", because: "both install mull-rewriter-22"
  def install
    # Homebrew stages into the archive's sole top-level dir (bin/)
    bin.install "mull-instrument-22"
    bin.install "mull-rewriter-22"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 22 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-22
        mull-rewriter-22

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-22", shell_output("#{bin}/mull-instrument-22 --help")
    assert_match "mull-rewriter-22", shell_output("#{bin}/mull-rewriter-22 --help")
  end
end
