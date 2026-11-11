class MullTestingAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-18/versions/0.37.0.pr1223/Mull-18-0.37.0.pr1223-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "040dd4e41428c27808f3c190c21c072dd0f34599f3ac2fef7d9636f29d19a35c"
    end
  end

  conflicts_with "mull@18", because: "both install mull-ir-frontend-18"
  conflicts_with "mull-nightly@18", because: "both install mull-ir-frontend-18"
  def install
    lib.install "lib/mull-ir-frontend-18"
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
