class MullNightlyAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0.trunk1794436407"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-17/versions/0.37.0.trunk1794436407/Mull-17-0.37.0.trunk1794436407-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "d70ab327d2af23b9f4e6624be07e67ccd00a175ff8a7e30f8038ff19324b5694"
    end
  end

  conflicts_with "mull@17", because: "both install mull-ir-frontend-17"
  conflicts_with "mull-testing@17", because: "both install mull-ir-frontend-17"
  def install
    lib.install "lib/mull-ir-frontend-17"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-17"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-17"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 17 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@17.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-17

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-17 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-17", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
