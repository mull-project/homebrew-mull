class MullTestingAT17 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 17)"
  homepage "https://github.com/mull-project/mull"
  version "0.29.0.pr1159"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-17/versions/0.29.0.pr1159/Mull-17-0.29.0.pr1159-LLVM-17.0.6-macOS-aarch64-15.7.4.zip"
      sha256 "5f392f1f01433ff596426f0c1916f144d3b24000dde00c549e711075395c58fd"
    end
  end

  conflicts_with "mull@17", because: "both install mull-runner-17"
  conflicts_with "mull-nightly@17", because: "both install mull-runner-17"
  def install
    bin.install "usr/local/bin/mull-runner-17"
    bin.install "usr/local/bin/mull-reporter-17"
    lib.install "usr/local/lib/mull-ir-frontend-17"
    man1.install "usr/local/share/man/man1/mull-runner-17.1"
    man1.install "usr/local/share/man/man1/mull-reporter-17.1"
    bash_completion.install "usr/local/share/bash-completion/completions/mull-runner-17"
    bash_completion.install "usr/local/share/bash-completion/completions/mull-reporter-17"
    zsh_completion.install "usr/local/share/zsh/site-functions/_mull-runner-17"
    zsh_completion.install "usr/local/share/zsh/site-functions/_mull-reporter-17"
    fish_completion.install "usr/local/share/fish/vendor_completions.d/mull-runner-17.fish"
    fish_completion.install "usr/local/share/fish/vendor_completions.d/mull-reporter-17.fish"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 17 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-runner-17
        mull-reporter-17

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-17

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-17 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-17 --version")
  end
end
