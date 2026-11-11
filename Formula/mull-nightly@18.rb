class MullNightlyAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794438332"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-18/versions/0.37.0.trunk1794438332/Mull-18-0.37.0.trunk1794438332-LLVM-18.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "69b299f3d439c7fe2508531626e0a4664bbf9a05bcfae2fdacfa1f554eb2ba07"
    end
  end

  conflicts_with "mull@18", because: "both install mull-ir-frontend-18"
  conflicts_with "mull-testing@18", because: "both install mull-ir-frontend-18"
  def install
    lib.install "lib/mull-ir-frontend-18"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-18"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-18"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 18 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@18.

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
