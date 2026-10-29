class MullAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.36.0"
  license "Apache-2.0"

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-23/versions/0.36.0/Mull-23-0.36.0-LLVM-23.1.4-macOS-aarch64-26.6.2.zip"
      sha256 "7238c2be1c0e223bf49341b3891e2c4edfc3cb4155c3901a613ca7f5b0563553"
    end
  end

  conflicts_with "mull-nightly@23", because: "both install mull-instrument-23"
  conflicts_with "mull-testing@23", because: "both install mull-instrument-23"
  def install
    bin.install "bin/mull-instrument-23"
    lib.install "lib/mull-ir-frontend-23"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-23"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-23"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 23 support.

      Binaries installed:
        mull-instrument-23

      mull-runner and mull-reporter come from mull-project/mull/mull.

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
