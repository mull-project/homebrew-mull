class MullTestingAT20 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 20 plugin - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.pr1223"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@20"
  depends_on "mull-project/mull/mull-testing"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-20/versions/0.37.0.pr1223/Mull-20-0.37.0.pr1223-LLVM-20.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "6c3a5a65d2514951766d442f1bfbfeefe9329bd85d271473a2eaf6e6490aea8e"
    end
  end

  conflicts_with "mull@20", because: "both install mull-ir-frontend-20"
  conflicts_with "mull-nightly@20", because: "both install mull-ir-frontend-20"
  def install
    lib.install "lib/mull-ir-frontend-20"
    # Deprecated versioned names of the tools from mull-project/mull/mull-testing
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-runner" => "mull-runner-20"
    bin.install_symlink Formula["mull-project/mull/mull-testing"].opt_bin/"mull-reporter" => "mull-reporter-20"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 20 support.

      This is a PR/testing build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-testing.
      mull-instrument and mull-rewriter come from mull-testing-extras@20.

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
