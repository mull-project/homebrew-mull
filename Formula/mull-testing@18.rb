class MullTestingAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.pr1228"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-18/versions/0.38.0.pr1228/Mull-18-0.38.0.pr1228-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "b0938da0d4f869ca19d33fe2cf0342c55c9e332a85582b7f6f5f46f17414696a"
    end
  end

  conflicts_with "mull@18", because: "both install mull-ir-frontend-18"
  conflicts_with "mull-nightly@18", because: "both install mull-ir-frontend-18"
  def install
    # Homebrew stages into the archive's sole top-level dir (lib/)
    lib.install "mull-ir-frontend-18"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-18"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-18"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 18 support.

      This is a PR/testing build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.
      mull-instrument and mull-rewriter come from mull-testing-extras@18.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-18

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-18 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-18", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
