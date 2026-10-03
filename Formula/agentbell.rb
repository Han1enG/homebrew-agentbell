class Agentbell < Formula
  desc "Local macOS notifications for Claude Code and Codex CLI"
  homepage "https://github.com/Han1enG/agent-bell"
  url on_arch_conditional(
    arm:   "https://github.com/Han1enG/agent-bell/releases/download/v0.3.0/agentbell_0.3.0_darwin_arm64.tar.gz",
    intel: "https://github.com/Han1enG/agent-bell/releases/download/v0.3.0/agentbell_0.3.0_darwin_amd64.tar.gz",
  )
  version "0.3.0"
  sha256 on_arch_conditional(
    arm:   "2adc899ce71e2bd8abb30ddc0c3acd49c930cb1c43021a6e5e24996fd7a08089",
    intel: "8c14de6730f8e820c6b0cfe5d82981721799900f134998fd5524f55aa1e9f99d",
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
      After upgrading: agentbell install, then agentbell doctor --fix
      Restart Tabby/GoLand after integration updates and use a new local terminal tab.
      macOS may ask for notification and terminal automation permissions.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentbell version").strip
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", libexec/"AgentBell.app"
  end
end
