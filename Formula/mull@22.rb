class MullAT22 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 22 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0"
  license "Apache-2.0"

  depends_on "llvm@22"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-22/versions/0.38.0/Mull-22-0.38.0-LLVM-22.1.8-macOS-aarch64-26.7.2.zip"
      sha256 "4000b7d6e98c7a9f6216fb2cc8cc16fdc260f522a4f6c3e9392ed234ceb53c49"
    end
  end

  conflicts_with "mull-nightly@22", because: "both install mull-ir-frontend-22"
  conflicts_with "mull-testing@22", because: "both install mull-ir-frontend-22"
  def install
    lib.install "lib/mull-ir-frontend-22"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-22"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-22"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 22 support.

      mull-runner and mull-reporter come from mull-project/mull/mull.
      mull-instrument and mull-rewriter come from mull-extras@22.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-22

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-22 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-22", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
