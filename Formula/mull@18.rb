class MullAT18 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 18 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0"
  license "Apache-2.0"

  depends_on "llvm@18"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-18/versions/0.35.0/Mull-18-0.35.0-LLVM-18.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "75377b41216393ed3a88e3d253b54e528a1e12391b6c6f7166a96aafc9d2e022"
    end
  end

  conflicts_with "mull-nightly@18", because: "both install mull-instrument-18"
  conflicts_with "mull-testing@18", because: "both install mull-instrument-18"
  def install
    bin.install "bin/mull-instrument-18"
    lib.install "lib/mull-ir-frontend-18"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-18"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-18"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 18 support.

      Binaries installed:
        mull-instrument-18

      mull-runner and mull-reporter come from mull-project/mull/mull.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-18

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-18 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-18", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
