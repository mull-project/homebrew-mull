class MullTestingAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1222"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-17/versions/0.37.0.pr1222/Mull-17-0.37.0.pr1222-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "85a5fecb8b3baab3b1ddf7bea9e0a3392f9d0c356ee203a3eb3436a2ccaafebd"
    end
  end

  conflicts_with "mull@17", because: "both install mull-ir-frontend-17"
  conflicts_with "mull-nightly@17", because: "both install mull-ir-frontend-17"
  def install
    lib.install "lib/mull-ir-frontend-17"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-17"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-17"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 17 support.

      This is a PR/testing build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.
      mull-instrument and mull-rewriter come from mull-testing-extras@17.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-17

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-17 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-17", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
