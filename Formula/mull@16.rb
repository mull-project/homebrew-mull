class MullAT16 < Formula
  desc "Practical mutation testing for C and C++ (LLVM 16)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.1"
  license "Apache-2.0"

  depends_on "llvm@16"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-16/versions/0.34.1/Mull-16-0.34.1-LLVM-16.0.6-macOS-aarch64-26.6.2.zip"
      sha256 "bbf336276b797e7f8dfac87185294c3c2e9fd8e3638ff033b7053958ca14eb3a"
    end
  end

  conflicts_with "mull-nightly@16", because: "both install mull-runner-16"
  conflicts_with "mull-testing@16", because: "both install mull-runner-16"
  def install
    bin.install "bin/mull-runner-16"
    bin.install "bin/mull-reporter-16"
    lib.install "lib/mull-ir-frontend-16"
    man1.install "share/man/man1/mull-runner-16.1"
    man1.install "share/man/man1/mull-reporter-16.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-16"
    bash_completion.install "share/bash-completion/completions/mull-reporter-16"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-16"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-16"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-16.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-16.fish"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 16 support.

      Binaries installed:
        mull-runner-16
        mull-reporter-16

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-16

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-16 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-16 --version")
  end
end
