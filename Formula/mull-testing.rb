class MullTesting < Formula
  desc "Practical mutation testing for C and C++: core tools - Testing"
  homepage "https://github.com/mull-project/mull"
  version "0.36.0.pr1207"
  license "Apache-2.0"

  livecheck do
    skip "Testing builds are updated automatically"
  end

  depends_on :macos

  on_macos do
    on_arm do
      url "https://dl.cloudsmith.io/public/mull-project/mull-testing/raw/names/mull/versions/0.36.0.pr1207/Mull-0.36.0.pr1207-macOS-aarch64-26.6.2.zip"
      sha256 "f10db8f33fc002421105233f5588491b2f09b5850a94991a7c1197b65f7fd9a8"
    end
  end

  conflicts_with "mull", because: "both install mull-runner"
  conflicts_with "mull-nightly", because: "both install mull-runner"
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
      Mull TESTING tools have been installed.

      This is a PR/testing build and may be unstable.

      Install a plugin for your LLVM version as well, e.g.:
        brew install mull-testing@23
    EOS
  end

  test do
    assert_match "mull-runner", shell_output("#{bin}/mull-runner --version")
  end
end
