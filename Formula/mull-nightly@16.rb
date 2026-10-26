class MullNightlyAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.trunk1793045077"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-16/versions/0.35.0.trunk1793045077/Mull-16-0.35.0.trunk1793045077-LLVM-16.0.6-macOS-aarch64-26.6.2.zip"
      sha256 "84200075d60f79a3f6491cefc4bcfa9be3ec435b9fada1f95797bcaf7d2b3d50"
    end
  end

  conflicts_with "mull@16", because: "both install mull-instrument-16"
  conflicts_with "mull-testing@16", because: "both install mull-instrument-16"
  def install
    bin.install "bin/mull-instrument-16"
    lib.install "lib/mull-ir-frontend-16"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-16"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-16"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 16 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-16

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.

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
