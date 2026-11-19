class MullAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.39.0"
  license "Apache-2.0"

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-17/versions/0.39.0/Mull-17-0.39.0-LLVM-17.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "b6a15e3677777550aa6445a90e79c050c0fb830984f85b353ea6811510e53e3d"
    end
  end

  conflicts_with "mull-nightly@17", because: "both install mull-ir-frontend-17"
  conflicts_with "mull-testing@17", because: "both install mull-ir-frontend-17"
  def install
    # Homebrew stages into the archive's sole top-level dir (lib/)
    lib.install "mull-ir-frontend-17"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-17"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-17"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 17 support.

      mull-runner and mull-reporter come from mull-project/mull/mull.
      mull-instrument and mull-rewriter come from mull-extras@17.

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
