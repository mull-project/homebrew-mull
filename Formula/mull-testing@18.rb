class MullTestingAT18 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 18)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.2.pr1200"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@18"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-18/versions/0.34.2.pr1200/Mull-18-0.34.2.pr1200-LLVM-18.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "744c102ea3e9ed9c01a37a04c31285d2363585d6d71e8501cbeb249f86088f64"
    end
  end

  conflicts_with "mull@18", because: "both install mull-runner-18"
  conflicts_with "mull-nightly@18", because: "both install mull-runner-18"
  def install
    bin.install "bin/mull-instrument-18"
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
        mull-instrument-18
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
