class MullNightlyAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.trunk1793258407"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-22/versions/0.35.0.trunk1793258407/Mull-22-0.35.0.trunk1793258407-LLVM-22.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "746c3171b0e38177c4997cf0a400a4f5b6f9184fcc2ed056e03ea560f15ca4d9"
    end
  end

  conflicts_with "mull@22", because: "both install mull-instrument-22"
  conflicts_with "mull-testing@22", because: "both install mull-instrument-22"
  def install
    bin.install "bin/mull-instrument-22"
    lib.install "lib/mull-ir-frontend-22"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-22"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-22"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 22 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-22

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-22

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-22 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-22", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
