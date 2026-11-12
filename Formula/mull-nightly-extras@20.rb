class MullNightlyExtrasAT20 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 20 extra tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1794440116"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@20"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-extras-20/versions/0.38.0.trunk1794440116/Mull-Extras-20-0.38.0.trunk1794440116-LLVM-20.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "77815dfc79103500321645200598c875435f388b137b3d7acc4755283910accf"
    end
  end

  conflicts_with "mull-extras@20", because: "both install mull-rewriter-20"
  conflicts_with "mull-testing-extras@20", because: "both install mull-rewriter-20"
  def install
    bin.install "bin/mull-instrument-20"
    bin.install "bin/mull-rewriter-20"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY extra tools have been installed with LLVM 20 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-20
        mull-rewriter-20

      Their mutants run with mull-runner from mull-project/mull/mull-nightly.
    EOS
  end

  test do
    assert_match "mull-instrument-20", shell_output("#{bin}/mull-instrument-20 --help")
    assert_match "mull-rewriter-20", shell_output("#{bin}/mull-rewriter-20 --help")
  end
end
