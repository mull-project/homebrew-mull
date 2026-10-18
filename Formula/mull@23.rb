class MullAT23 < Formula
  desc "Practical mutation testing for C and C++ (LLVM 23)"
  homepage "https://github.com/mull-project/mull"
  version "0.34.2"
  license "Apache-2.0"

  depends_on "llvm@23"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull-23/versions/0.34.2/PACKAGE_FILENAME_PLACEHOLDER"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  conflicts_with "mull-nightly@23", because: "both install mull-runner-23"
  conflicts_with "mull-testing@23", because: "both install mull-runner-23"
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
      Mull has been installed with LLVM 23 support.

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
