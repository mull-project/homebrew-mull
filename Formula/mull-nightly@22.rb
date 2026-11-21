class MullNightlyAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795295400"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-22/versions/0.39.1.trunk1795295400/Mull-22-0.39.1.trunk1795295400-LLVM-22.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "36ca781b0b44e31affe63fa3414f319fbf00d4f2a694e707a3339c25fcd7320f"
    end
  end

  conflicts_with "mull@22", because: "both install mull-ir-frontend-22"
  conflicts_with "mull-testing@22", because: "both install mull-ir-frontend-22"
  def install
    # Homebrew stages into the archive's sole top-level dir (lib/)
    lib.install "mull-ir-frontend-22"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-22"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-22"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 22 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@22.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-22

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-22 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-22", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
