class MullTestingAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.pr1206"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-18/versions/0.35.0.pr1206/Mull-18-0.35.0.pr1206-LLVM-18.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "0e3ec82a3f28b19a6f9190dbd08563609302ec754bf8299d4e9e708e0b448182"
    end
  end

  conflicts_with "mull@18", because: "both install mull-instrument-18"
  conflicts_with "mull-nightly@18", because: "both install mull-instrument-18"
  def install
    bin.install "bin/mull-instrument-18"
    lib.install "lib/mull-ir-frontend-18"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-18"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-18"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 18 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-18

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-18

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-18 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-18", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
