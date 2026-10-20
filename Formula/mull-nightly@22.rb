class MullNightlyAT22 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 22)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.2.trunk1792471677"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@22"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-22/versions/0.34.2.trunk1792471677/Mull-22-0.34.2.trunk1792471677-LLVM-22.1.8-macOS-aarch64-26.6.2.zip"
      sha256 "fbe484333fc0d6c4869b86bceb34ac62d00c67e31b471450f2f1ce533b0afa06"
    end
  end

  conflicts_with "mull@22", because: "both install mull-runner-22"
  conflicts_with "mull-testing@22", because: "both install mull-runner-22"
  def install
    bin.install "bin/mull-instrument-22"
    bin.install "bin/mull-runner-22"
    bin.install "bin/mull-reporter-22"
    lib.install "lib/mull-ir-frontend-22"
    man1.install "share/man/man1/mull-runner-22.1"
    man1.install "share/man/man1/mull-reporter-22.1"
    bash_completion.install "share/bash-completion/completions/mull-runner-22"
    bash_completion.install "share/bash-completion/completions/mull-reporter-22"
    zsh_completion.install "share/zsh/site-functions/_mull-runner-22"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter-22"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner-22.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter-22.fish"
  end

  def caveats
    <<~EOS
      Mull NIGHTLY has been installed with LLVM 22 support.

      This is a development build and may be unstable.

      Binaries installed:
        mull-instrument-22
        mull-runner-22
        mull-reporter-22

      The Clang plugin is installed at:
        #{lib}/mull-ir-frontend-22

      Usage with clang:
        clang -fpass-plugin=#{lib}/mull-ir-frontend-22 ...
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner-22 --version")
  end
end
