class MullAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.36.0"
  license "Apache-2.0"

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-19/versions/0.36.0/Mull-19-0.36.0-LLVM-19.1.7-macOS-aarch64-26.6.2.zip"
      sha256 "29b5f50a354e3acb6da1ae99f39b22243419d404fd18f2a77f28c58a9fbf5f19"
    end
  end

  conflicts_with "mull-nightly@19", because: "both install mull-instrument-19"
  conflicts_with "mull-testing@19", because: "both install mull-instrument-19"
  def install
    bin.install "bin/mull-instrument-19"
    lib.install "lib/mull-ir-frontend-19"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-19"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-19"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 19 support.

      Binaries installed:
        mull-instrument-19

      mull-runner and mull-reporter come from mull-project/mull/mull.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-19

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-19 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-19", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
