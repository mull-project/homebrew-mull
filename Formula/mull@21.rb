class MullAT21 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 21 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0"
  license "Apache-2.0"

  depends_on "llvm@21"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-21/versions/0.35.0/Mull-21-0.35.0-LLVM-21.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "b033481f30660ccbfb177beeca507f85eb484b76cbcdb49d147de835d06aef01"
    end
  end

  conflicts_with "mull-nightly@21", because: "both install mull-instrument-21"
  conflicts_with "mull-testing@21", because: "both install mull-instrument-21"
  def install
    bin.install "bin/mull-instrument-21"
    lib.install "lib/mull-ir-frontend-21"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-21"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-21"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 21 support.

      Binaries installed:
        mull-instrument-21

      mull-runner and mull-reporter come from mull-project/mull/mull.

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-21

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-21 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-21", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
