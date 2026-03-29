class MullNightlyAT18 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 18)"
  homepage "https://github.com/mull-project/mull"
  version "0.31.1.trunk1774779882"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-18/versions/0.31.1.trunk1774779882/Mull-18-0.31.1.trunk1774779882-LLVM-18.1.8-macOS-aarch64-15.7.4.zip"
      sha256 "f64c26de4a7e423adc873e5487acb468cf0aea655bd17fb4cb8109802b4a5100"
    end
  end

  conflicts_with "mull@18", because: "both install mull-runner-18"
  conflicts_with "mull-testing@18", because: "both install mull-runner-18"
  def install
    bin.install "bin/mull-runner-18"
    bin.install "bin/mull-reporter-18"
    lib.install "lib/mull-ir-frontend-18"
    man1.install "share/man/man1/mull-runner-18.1"
    man1.install "share/man/man1/mull-reporter-18.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-18"
    bash_completion.install "share/bash-completion/completions/mull-reporter-18"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-18"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-18"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-18.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-18.fish"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 18 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-runner-18
        mull-reporter-18

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-18

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-18 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-18 --version")
  end
end
