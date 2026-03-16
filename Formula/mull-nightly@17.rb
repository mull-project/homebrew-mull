class MullNightlyAT17 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 17)"
  homepage "https://github.com/mull-project/mull"
  version "0.29.0.trunk139"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@17"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-17/versions/0.29.0.trunk139/Mull-17-0.29.0.trunk139-LLVM-17.0.6-macOS-aarch64-15.7.4.zip"
      sha256 "2ca5637f8dd5c96e7a252c4fd1fac7e0c27ee08ca245a965f6604947e2efab15"
    end
  end

  conflicts_with "mull@17", because: "both install mull-runner-17"
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
      Mull NIGHTLY has been installed with LLVM 17 support.

      This is a development build and may be unstable.

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
