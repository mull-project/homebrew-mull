class MullNightlyAT19 < Formula
  desc "Practical mutation testing for C and C++ - Nightly (LLVM 19)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.1.trunk1789313640"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on "llvm@19"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull-19/versions/0.34.1.trunk1789313640/Mull-19-0.34.1.trunk1789313640-LLVM-19.1.7-macOS-aarch64-26.6.2.zip"
      sha256 "bf0694ccd07287e5df042ab1fe6e9a0f2a04fcc45d4b5c4f155963663e483278"
    end
  end

  conflicts_with "mull@19", because: "both install mull-runner-19"
  conflicts_with "mull-testing@19", because: "both install mull-runner-19"
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
      Mull NIGHTLY has been installed with LLVM 19 support.

      This is a development build and may be unstable.

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
