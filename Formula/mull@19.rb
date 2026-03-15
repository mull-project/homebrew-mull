class MullAT19 < Formula
  desc "Practical mutation testing for C and C++ (LLVM 19)"
  homepage "https://github.com/mull-project/mull"
  version "0.29.0"
  license "Apache-2.0"

  depends_on "llvm@19"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-19/versions/0.29.0/PACKAGE_FILENAME_PLACEHOLDER"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  conflicts_with "mull-nightly@19", because: "both install mull-runner-19"
  conflicts_with "mull-testing@19", because: "both install mull-runner-19"
  def install
    bin.install "usr/local/bin/mull-runner-19"
    bin.install "usr/local/bin/mull-reporter-19"
    lib.install "usr/local/lib/mull-ir-frontend-19"
    man1.install "usr/local/share/man/man1/mull-runner-19.1"
    man1.install "usr/local/share/man/man1/mull-reporter-19.1"
    bash_completion.install "usr/local/share/bash-completion/completions/mull-runner-19"
    bash_completion.install "usr/local/share/bash-completion/completions/mull-reporter-19"
    zsh_completion.install "usr/local/share/zsh/site-functions/_mull-runner-19"
    zsh_completion.install "usr/local/share/zsh/site-functions/_mull-reporter-19"
    fish_completion.install "usr/local/share/fish/vendor_completions.d/mull-runner-19.fish"
    fish_completion.install "usr/local/share/fish/vendor_completions.d/mull-reporter-19.fish"
  end

  def caveats
    <<~EOS
      Mull has been installed with LLVM 19 support.

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
