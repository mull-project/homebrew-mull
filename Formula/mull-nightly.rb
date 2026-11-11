class MullNightly < Formula
  desc "Practical mutation testing for C and C++: core tools - Nightly"
  homepage "https://github.com/mull-project/mull"
  version "0.38.0.trunk1794440116"
  license "Apache-2.0"

  livecheck do
    skip "Nightly builds are updated automatically"
  end

  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-nightly/raw/names/mull/versions/0.38.0.trunk1794440116/Mull-0.38.0.trunk1794440116-macOS-aarch64-26.7.2.zip"
      sha256 "93ac22ae3582848bb6249599eca5b9fd7a023cac6e224c743de0a25ed28a5261"
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
