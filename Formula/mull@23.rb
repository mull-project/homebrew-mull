class MullAT23 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 23 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0"
  license "Apache-2.0"

  depends_on "llvm@23"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-23/versions/0.35.0/Mull-23-0.35.0-LLVM-23.1.3-macOS-aarch64-26.6.2.zip"
      sha256 "e02ddecb0a6989b63f428bc1fd7fcb40462c0f1162a83df33e5483c98d38d5ad"
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
        #{lib}/mull-ir-frontend-23

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-23 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-23", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
