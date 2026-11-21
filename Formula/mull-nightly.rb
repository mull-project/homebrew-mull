class MullNightly < Formula
  desc "Practical mutation testing for C and C++: core tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.39.1.trunk1795269661"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull/versions/0.39.1.trunk1795269661/Mull-0.39.1.trunk1795269661-macOS-aarch64-26.7.2.zip"
      sha256 "ee81130ee99715ddefd8fbef0ada7458c8624bb865693237d602db40cc12cde4"
    end
  end

  conflicts_with "mull", because: "both install mull-runner"
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
      Mull NIGHTLY tools have been installed.

      This is a development build and may be unstable.

      Install a plugin for your LLVM version as well, e.g.:
        brew install mull-nightly@23
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner --version")
  end
end
