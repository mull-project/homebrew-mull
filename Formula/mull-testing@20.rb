class MullTestingAT20 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 20 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1215"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@20"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-20/versions/0.37.0.pr1215/Mull-20-0.37.0.pr1215-LLVM-20.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "6288d32dfb047214a627c5e97e7a70e08305cd2cc2472fb71dfbc929949328b3"
    end
  end

  conflicts_with "mull@20", because: "both install mull-instrument-20"
  conflicts_with "mull-nightly@20", because: "both install mull-instrument-20"
  def install
    bin.install "bin/mull-instrument-20"
    lib.install "lib/mull-ir-frontend-20"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-20"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-20"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 20 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-20

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-20

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-20 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-20", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
