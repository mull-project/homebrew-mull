class MullTestingAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.36.0.pr1209"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-21/versions/0.36.0.pr1209/Mull-21-0.36.0.pr1209-LLVM-21.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "56755036f115b4340082bc61eb6ccd7611e2af370c7920e4afcf4694940ea907"
    end
  end

  conflicts_with "mull@21", because: "both install mull-instrument-21"
  conflicts_with "mull-nightly@21", because: "both install mull-instrument-21"
  def install
    bin.install "bin/mull-instrument-21"
    lib.install "lib/mull-ir-frontend-21"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-21"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-21"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 21 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-21

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-21

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-21 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-21", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
