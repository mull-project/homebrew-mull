class MullTestingAT16 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 16)"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.pr1204"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-16/versions/0.35.0.pr1204/Mull-16-0.35.0.pr1204-LLVM-16.0.6-macOS-aarch64-26.6.2.zip"
      sha256 "928ebe28954c85c6eb6e5761ea9b8f5f20ac6252c2672f2ceba75e212cab2eef"
    end
  end

  conflicts_with "mull@16", because: "both install mull-instrument-16"
  conflicts_with "mull-nightly@16", because: "both install mull-instrument-16"
  def install
    bin.install "bin/mull-instrument-16"
    lib.install "lib/mull-ir-frontend-16"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-16"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-16"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 16 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-16

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-16

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-16 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-16", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
