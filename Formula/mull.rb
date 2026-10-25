class Mull < Formula
  desc "Practical mutation testing for C and C++"
  homepage "https://github.com/mull-project/mull"
  version "0.35.0"
  license "Apache-2.0"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-stable/raw/names/mull/versions/0.35.0/PACKAGE_FILENAME_PLACEHOLDER"
      sha256 "PLACEHOLDER_SHA256"
    end
  end

  conflicts_with "mull-nightly", because: "both install mull-runner"
  conflicts_with "mull-testing", because: "both install mull-runner"
  def install
    bin.install "bin/mull-runner"
    bin.install "bin/mull-reporter"
    man1.install "share/man/man1/mull-runner.1"
    man1.install "share/man/man1/mull-reporter.1"
    bash_completion.install "share/bash-completion/completions/mull-runner"
    bash_completion.install "share/bash-completion/completions/mull-reporter"
    zsh_completion.install "share/zsh/site-functions/_mull-runner"
    zsh_completion.install "share/zsh/site-functions/_mull-reporter"
    fish_completion.install "share/fish/vendor_completions.d/mull-runner.fish"
    fish_completion.install "share/fish/vendor_completions.d/mull-reporter.fish"
  end

  def caveats
    <<~EOS
      Mull tools have been installed.

      Install a plugin for your LLVM version as well, e.g.:
        brew install mull@23
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner --version")
  end
end
