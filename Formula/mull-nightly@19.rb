class MullNightlyAT19 < Formula
  desc "Practical mutation testing for C and C++: Clang/LLVM 19 plugin - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1794440116"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on "mull-project/mull/mull-nightly"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-19/versions/0.38.0.trunk1794440116/Mull-19-0.38.0.trunk1794440116-LLVM-19.1.7-macOS-aarch64-26.7.2.zip"
      sha256 "3181097a9a9946fee2f94d459d01076ee0eedd8f3679e352c187437dfc4c99cb"
    end
  end

  conflicts_with "mull@19", because: "both install mull-ir-frontend-19"
  conflicts_with "mull-testing@19", because: "both install mull-ir-frontend-19"
  def install
    lib.install "lib/mull-ir-frontend-19"
    # Deprecated versioned names of the tools from mull-project/mull/mull-nightly
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-runner" => "mull-runner-19"
    bin.install_symlink Formula["mull-project/mull/mull-nightly"].opt_bin/"mull-reporter" => "mull-reporter-19"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 19 support.

      This is a development build and may be unstable.

      mull-runner and mull-reporter come from mull-project/mull/mull-nightly.
      mull-instrument and mull-rewriter come from mull-nightly-extras@19.

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
