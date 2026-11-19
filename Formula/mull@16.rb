class MullAT16 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 16 plugin"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1"
  license "Apache-2.0"

  depends_on "llvm@16"
  depends_on "mull-project/mull/mull"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-16/versions/0.39.1/Mull-16-0.39.1-LLVM-16.0.6-macOS-aarch64-26.7.2.zip"
      sha256 "963a2b03d538ee2ccdb3dd7a84ca4005dba8f7372ae4ee769c3cfc1c16534a5a"
    end
  end

  conflicts_with "mull-nightly@16", because: "both install mull-ir-frontend-16"
  conflicts_with "mull-testing@16", because: "both install mull-ir-frontend-16"
  def install
    # Homebrew stages into the archive's sole top-level dir (lib/)
    lib.install "mull-ir-frontend-16"
    # Deprecated versioned names of the tools from mull-project/mull/mull
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-runner" => "mull-runner-16"
    bin.install_symlink Formula["mull-project/mull/mull"].opt_bin/"mull-reporter" => "mull-reporter-16"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 16 support.

      mull-runner and mull-reporter come from mull-project/mull/mull.
      mull-instrument and mull-rewriter come from mull-extras@16.

      The Clang plugin is installed at:
        #{HOMEBREW_PREFIX}/lib/mull-ir-frontend-16

      Usage with clang:
        clang -fpass-plugin=#{HOMEBREW_PREFIX}/lib/mull-ir-frontend-16 ...
    EOS
  end

  test do
    # The linked mull-runner finds plugins in HOMEBREW_PREFIX/lib
    assert_match "mull-ir-frontend-16", shell_output("#{HOMEBREW_PREFIX}/bin/mull-runner --version")
  end
end
