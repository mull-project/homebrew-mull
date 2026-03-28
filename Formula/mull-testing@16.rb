class MullTestingAT16 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 16)"
  homepage "https://github.com/mull-project/mull"
  version "0.31.1.pr1175"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@16"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-16/versions/0.31.1.pr1175/Mull-16-0.31.1.pr1175-LLVM-16.0.6-macOS-aarch64-15.7.4.zip"
      sha256 "87ad1b2f8036a786f3c57d6ee2f154042c29a25dad9a29aa9ea8c131341f3e62"
    end
  end

  conflicts_with "mull@16", because: "both install mull-runner-16"
  conflicts_with "mull-nightly@16", because: "both install mull-runner-16"
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
      Mull TESTING has been installed with LLVM 16 support.

      This is a PR/testing build and may be unstable.

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
