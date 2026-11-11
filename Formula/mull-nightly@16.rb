class MullNightlyAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794436407"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-16/versions/0.37.0.trunk1794436407/Mull-16-0.37.0.trunk1794436407-LLVM-16.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "7118b95dcb72077380b44386cbbdeb6329519886ed1f3aa61e3d6c503bd5e688"
    end
  end

  conflicts_with "mull@16", because: "both install mull-ir-frontend-16"
  conflicts_with "mull-testing@16", because: "both install mull-ir-frontend-16"
  def install
    lib.install "lib/mull-ir-frontend-16"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-16"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-16"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 16 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@16.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-16

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-16 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-16", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
