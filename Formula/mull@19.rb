class MullAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.37.0"
  license "Apache-2.0"

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-19/versions/0.37.0/Mull-19-0.37.0-LLVM-19.1.7-macOS-aarch64-26.6.2.zip"
      sha256 "71307c4c377d370d2026fea0773804c6ea93902e9424099e3c196f75ac15b565"
    end
  end

  conflicts_with "mull-nightly@19", because: "both install mull-ir-frontend-19"
  conflicts_with "mull-testing@19", because: "both install mull-ir-frontend-19"
  def install
    lib.install "lib/mull-ir-frontend-19"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-19"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-19"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 19 support.

      mull-runner and mull-reporter come from mull-project/mull/mull.
      mull-instrument and mull-rewriter come from mull-extras@19.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-19

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-19 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-19", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
