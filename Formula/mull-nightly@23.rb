class MullNightlyAT23 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 23)"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.trunk1792952286"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-23/versions/0.35.0.trunk1792952286/Mull-23-0.35.0.trunk1792952286-LLVM-23.1.4-macOS-aarch64-26.6.2.zip"
      sha256 "801ec4aa57e8827fa82491ae07970dc0cf52ecfc4292108f68ac08d42177326a"
    end
  end

  conflicts_with "mull@23", because: "both install mull-runner-23"
  conflicts_with "mull-testing@23", because: "both install mull-runner-23"
  def install
    bin.install "bin/mull-instrument-23"
    bin.install "bin/mull-runner-23"
    bin.install "bin/mull-reporter-23"
    lib.install "lib/mull-ir-frontend-23"
    man1.install "share/man/man1/mull-runner-23.1"
    man1.install "share/man/man1/mull-reporter-23.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-23"
    bash_completion.install "share/bash-completion/completions/mull-reporter-23"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-23"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-23"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-23.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-23.fish"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 23 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-23
        mull-runner-23
        mull-reporter-23

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-23

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-23 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-23 --version")
  end
end
