class Agentbell < Formula
  desc "Local macOS notifications for Claude Code and Codex CLI"
  homepage "https://github.com/Han1enG/agent-bell"
  url on_arch_conditional(
    arm:   "https://github.com/Han1enG/agent-bell/releases/download/v0.2.0/agentbell_0.2.0_darwin_arm64.tar.gz",
    intel: "https://github.com/Han1enG/agent-bell/releases/download/v0.2.0/agentbell_0.2.0_darwin_amd64.tar.gz",
  )
  version "0.2.0"
  sha256 on_arch_conditional(
    arm:   "7e75998268b05240f7139df6331cca845954433ab66e0d22083bb7f36a5fb8a6",
    intel: "4631782dc0dea2760d27bb59b2b85bf95f625b8fdd34e0175987303e3c00da21",
  )
  license "MIT"

  depends_on macos: :ventura

  def install
    app = Pathname.pwd
    app /= "AgentBell.app" if (app/"AgentBell.app").directory?
    installed_app = libexec/"AgentBell.app"
    installed_app.mkpath
    # Preserve the CLI, helper, bundle metadata and resource seal together.
    cp_r app/"Contents", installed_app
    bin.install_symlink installed_app/"Contents/MacOS/agentbell"
  end

  def caveats
    <<~EOS
      First installation: agentbell install
      After upgrading: agentbell doctor --fix
      macOS may ask for notification and terminal automation permissions.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentbell version").strip
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", libexec/"AgentBell.app"
  end
end
