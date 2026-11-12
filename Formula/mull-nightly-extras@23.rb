class MullNightlyExtrasAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1794440116"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-23/versions/0.38.0.trunk1794440116/Mull-Extras-23-0.38.0.trunk1794440116-LLVM-23.1.4-macOS-aarch64-26.7.2.zip"
      sha256 "b9b6c6ba26d47268d2eed03ce3e7338a6de7877e930f9dbadb7f71f3d0b73ae7"
    end
  end

  conflicts_with "mull-extras@23", because: "both install mull-rewriter-23"
  conflicts_with "mull-testing-extras@23", because: "both install mull-rewriter-23"
  def install
    bin.install "bin/mull-instrument-23"
    bin.install "bin/mull-rewriter-23"
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
