class MullAT17 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 17 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.36.0"
  license "Apache-2.0"

  depends_on "llvm@17"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-17/versions/0.36.0/Mull-17-0.36.0-LLVM-17.0.6-macOS-aarch64-26.6.2.zip"
      sha256 "5ef528aba85e8fdf2346009739f15241a3e9e2642d7266f73b575aa2c8efbc34"
    end
  end

  conflicts_with "mull-nightly@17", because: "both install mull-instrument-17"
  conflicts_with "mull-testing@17", because: "both install mull-instrument-17"
  def install
    bin.install "bin/mull-instrument-17"
    lib.install "lib/mull-ir-frontend-17"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-17"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-17"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 17 support.

      Binaries installed:
        mull-instrument-17

      mull-runner and mull-reporter come from mull-project/mull/mull.

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
