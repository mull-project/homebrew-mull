class MullAT17 < Formula
  desc "Practical mutation testing for C and C++ (LLVM 17)"
  homepage "https://github.com/mull-project/mull"
  version "0.31.1"
  license "Apache-2.0"

  depends_on "llvm@17"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-17/versions/0.31.1/Mull-17-0.31.1-LLVM-17.0.6-macOS-aarch64-15.7.4.zip"
      sha256 "0b3efb5d9f732b0861c536d318b15ae5777b5b0a5858fa36103330bd674bf814"
    end
  end

  conflicts_with "mull-nightly@17", because: "both install mull-runner-17"
  conflicts_with "mull-testing@17", because: "both install mull-runner-17"
  def install
    bin.install "bin/mull-runner-17"
    bin.install "bin/mull-reporter-17"
    lib.install "lib/mull-ir-frontend-17"
    man1.install "share/man/man1/mull-runner-17.1"
    man1.install "share/man/man1/mull-reporter-17.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-17"
    bash_completion.install "share/bash-completion/completions/mull-reporter-17"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-17"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-17"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-17.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-17.fish"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 17 support.

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
