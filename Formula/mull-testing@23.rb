class MullTestingAT23 < Formula
  desc "Practical mutation testing for C and C++ - Testing (LLVM 23)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.2.pr1200"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on "llvm@23"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull-23/versions/0.34.2.pr1200/Mull-23-0.34.2.pr1200-LLVM-23.1.3-macOS-aarch64-26.6.2.zip"
      sha256 "3ee03a0162590df86173733fb69a13101212187865d5551dcc708a99ca9c6e22"
    end
  end

  conflicts_with "mull@23", because: "both install mull-runner-23"
  conflicts_with "mull-nightly@23", because: "both install mull-runner-23"
  def install
    bin.install "bin/mull-instrument-23"
    bin.install "bin/mull-runner-23"
    bin.install "bin/mull-reporter-23"
    lib.install "lib/mull-ir-frontend-23"
    man1.install "share/man/man1/mull-runner-23.1"
    man1.install "share/man/man1/mull-reporter-23.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-23"
    bash_completion.install "share/bash-completion/completions/mull-reporter-23"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-23"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-23"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-23.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-23.fish"
  end

  def caveats
    <<~EOS
      Mull TESTING has been installed with LLVM 23 support.

      This is a PR/testing build and may be unstable.

      Binaries installed:
        mull-instrument-23
        mull-runner-23
        mull-reporter-23

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-23

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-23 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-23 --version")
  end
end
