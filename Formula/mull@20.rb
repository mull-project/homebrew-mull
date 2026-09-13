class MullAT20 < Formula
  desc "Practical mutation testing for C and C++ (LLVM 20)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.1"
  license "Apache-2.0"

  depends_on "llvm@20"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-20/versions/0.34.1/Mull-20-0.34.1-LLVM-20.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "93f533cf395d48796d9d41020a17d5afd27f243fdfcbcf723b8ad25a98e6d537"
    end
  end

  conflicts_with "mull-nightly@20", because: "both install mull-runner-20"
  conflicts_with "mull-testing@20", because: "both install mull-runner-20"
  def install
    bin.install "bin/mull-runner-20"
    bin.install "bin/mull-reporter-20"
    lib.install "lib/mull-ir-frontend-20"
    man1.install "share/man/man1/mull-runner-20.1"
    man1.install "share/man/man1/mull-reporter-20.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-20"
    bash_completion.install "share/bash-completion/completions/mull-reporter-20"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-20"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-20"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-20.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-20.fish"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 20 support.

      Binaries installed:
        mull-runner-20
        mull-reporter-20

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-20

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-20 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-20 --version")
  end
end
