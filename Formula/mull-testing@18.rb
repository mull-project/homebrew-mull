class MullTestingAT18 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 18)"
  homepage "https://github.com/mull-project/mull"
  version "0.32.0.pr1182"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-18/versions/0.32.0.pr1182/Mull-18-0.32.0.pr1182-LLVM-18.1.8-macOS-aarch64-15.7.4.zip"
      sha256 "244f2fa89580933d63f9ed4fd6d3e59b7e320e4371af282a1dc04ef6937d2788"
    end
  end

  conflicts_with "mull@18", because: "both install mull-runner-18"
  conflicts_with "mull-nightly@18", because: "both install mull-runner-18"
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
      Mull TESTING has been installed with LLVM 18 support.

      This is a PR/testing build and may be unstable.

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
