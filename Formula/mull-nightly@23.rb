class MullNightlyAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.trunk1793258407"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-23/versions/0.35.0.trunk1793258407/Mull-23-0.35.0.trunk1793258407-LLVM-23.1.4-macOS-aarch64-26.6.2.zip"
      sha256 "2ecb35652479171a5a443a6cd8b07e5376c364a2827cdfd6e0202ce5f3bb9613"
    end
  end

  conflicts_with "mull@23", because: "both install mull-instrument-23"
  conflicts_with "mull-testing@23", because: "both install mull-instrument-23"
  def install
    bin.install "bin/mull-instrument-23"
    lib.install "lib/mull-ir-frontend-23"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-23"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-23"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 23 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-23

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.

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
