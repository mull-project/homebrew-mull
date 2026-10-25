class MullTestingAT21 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 21)"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0.pr1205"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-21/versions/0.35.0.pr1205/Mull-21-0.35.0.pr1205-LLVM-21.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "8bc527de6963bf50cbd33b1ac28eb43f788009adb3bc2a8e75cebc9ce2006ada"
    end
  end

  conflicts_with "mull@21", because: "both install mull-runner-21"
  conflicts_with "mull-nightly@21", because: "both install mull-runner-21"
  def install
    bin.install "bin/mull-instrument-21"
    bin.install "bin/mull-runner-21"
    bin.install "bin/mull-reporter-21"
    lib.install "lib/mull-ir-frontend-21"
    man1.install "share/man/man1/mull-runner-21.1"
    man1.install "share/man/man1/mull-reporter-21.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-21"
    bash_completion.install "share/bash-completion/completions/mull-reporter-21"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-21"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-21"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-21.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-21.fish"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 21 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-21
        mull-runner-21
        mull-reporter-21

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-21

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-21 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-21 --version")
  end
end
