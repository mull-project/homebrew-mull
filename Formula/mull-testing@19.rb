class MullTestingAT19 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 19)"
  homepage "https://github.com/mull-project/mull"
  version "0.31.0.pr1174"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-19/versions/0.31.0.pr1174/Mull-19-0.31.0.pr1174-LLVM-19.1.7-macOS-aarch64-15.7.4.zip"
      sha256 "ddce850a2fc2555802a4a62fc17093bbb1c80bf513119a4cf0a54f4188df1d6b"
    end
  end

  conflicts_with "mull@19", because: "both install mull-runner-19"
  conflicts_with "mull-nightly@19", because: "both install mull-runner-19"
  def install
    bin.install "bin/mull-runner-19"
    bin.install "bin/mull-reporter-19"
    lib.install "lib/mull-ir-frontend-19"
    man1.install "share/man/man1/mull-runner-19.1"
    man1.install "share/man/man1/mull-reporter-19.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-19"
    bash_completion.install "share/bash-completion/completions/mull-reporter-19"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-19"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-19"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-19.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-19.fish"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 19 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-runner-19
        mull-reporter-19

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-19

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-19 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-19 --version")
  end
end
