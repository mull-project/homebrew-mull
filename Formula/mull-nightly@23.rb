class MullNightlyAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795295400"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-23/versions/0.39.1.trunk1795295400/Mull-23-0.39.1.trunk1795295400-LLVM-23.1.5-macOS-aarch64-26.7.2.zip"
      sha256 "d70e09cf5e7386e5e3e2126ee2e57600094ccad02ae1f5c4be7551ea321da5dc"
    end
  end

  conflicts_with "mull@23", because: "both install mull-ir-frontend-23"
  conflicts_with "mull-testing@23", because: "both install mull-ir-frontend-23"
  def install
    # Homebrew stages into the archive's sole top-level dir (lib/)
    lib.install "mull-ir-frontend-23"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-23"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-23"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 23 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@23.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-23

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-23 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-23", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
