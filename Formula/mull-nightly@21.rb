class MullNightlyAT21 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 21)"
  homepage "https://github.com/mull-project/mull"
  version "0.30.0.trunk1"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@21"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-21/versions/0.30.0.trunk1/PACKAGE_FILENAME_PLACEHOLDER"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  conflicts_with "mull@21", because: "both install mull-runner-21"
  conflicts_with "mull-testing@21", because: "both install mull-runner-21"
  def install
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
      Mull NIGHTLY has been installed with LLVM 21 support.

      This is a development build and may be unstable.

      Binaries installed:
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
