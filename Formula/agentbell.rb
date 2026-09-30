class Agentbell < Formula
  desc "Local macOS notifications for Claude Code and Codex CLI"
  homepage "https://github.com/Han1enG/agent-bell"
  url "https://github.com/Han1enG/agent-bell/releases/download/v0.1.1/AgentBell-v0.1.1-macOS.zip"
  sha256 "6ea457c42913af4cd8fd1b1b62fd2e3bc7bfabd51713543973fbd672e02c56c7"
  version "0.1.1"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    app = buildpath/"AgentBell.app"
    odie "AgentBell.app was not found in the release archive" unless app.directory?
    libexec.install app
    bin.install libexec/"AgentBell.app/Contents/MacOS/agentbell"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/agentbell version")
  end
end
