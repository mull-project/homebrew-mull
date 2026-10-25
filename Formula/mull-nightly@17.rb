class MullNightlyAT17 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 17)"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.trunk1792956799"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-17/versions/0.35.0.trunk1792956799/Mull-17-0.35.0.trunk1792956799-LLVM-17.0.6-macOS-aarch64-26.6.2.zip"
      sha256 "96560ee1f93f99618ec2a39744ab3e16badbc46610b7fd1f2ef940738500e15c"
    end
  end

  conflicts_with "mull@17", because: "both install mull-instrument-17"
  conflicts_with "mull-testing@17", because: "both install mull-instrument-17"
  def install
    bin.install "bin/mull-instrument-17"
    lib.install "lib/mull-ir-frontend-17"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-17"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-17"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 17 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-17

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-17

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-17 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-17", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
