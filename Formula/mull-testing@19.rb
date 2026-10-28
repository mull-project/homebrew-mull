class MullTestingAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.pr1206"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-19/versions/0.35.0.pr1206/Mull-19-0.35.0.pr1206-LLVM-19.1.7-macOS-aarch64-26.6.2.zip"
      sha256 "af8ba147eac5aaaf61973a3b1ae6945a16deb4ffaa52697e90de580928da1fb1"
    end
  end

  conflicts_with "mull@19", because: "both install mull-instrument-19"
  conflicts_with "mull-nightly@19", because: "both install mull-instrument-19"
  def install
    bin.install "bin/mull-instrument-19"
    lib.install "lib/mull-ir-frontend-19"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-19"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-19"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 19 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-19

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-19

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-19 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-19", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
