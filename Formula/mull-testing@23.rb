class MullTestingAT23 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 23)"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.pr1204"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-23/versions/0.35.0.pr1204/Mull-23-0.35.0.pr1204-LLVM-23.1.4-macOS-aarch64-26.6.2.zip"
      sha256 "c64c1af0ed65212efa207bd454c1eebab2822164e2bca1b5a205d01f27fa7539"
    end
  end

  conflicts_with "mull@23", because: "both install mull-instrument-23"
  conflicts_with "mull-nightly@23", because: "both install mull-instrument-23"
  def install
    bin.install "bin/mull-instrument-23"
    lib.install "lib/mull-ir-frontend-23"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-23"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-23"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 23 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-23

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-23

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-23 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-23", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
