class Agentbell < Formula
  desc "Local macOS notifications for Claude Code and Codex CLI"
  homepage "https://github.com/Han1enG/agent-bell"
  url on_arch_conditional(
    arm:   "https://github.com/Han1enG/agent-bell/releases/download/v0.2.1/agentbell_0.2.1_darwin_arm64.tar.gz",
    intel: "https://github.com/Han1enG/agent-bell/releases/download/v0.2.1/agentbell_0.2.1_darwin_amd64.tar.gz",
  )
  version "0.2.1"
  sha256 on_arch_conditional(
    arm:   "2bbbb07c5fad169711fe5c3f9d679771c423d68fdbce240e603858aa09d81edd",
    intel: "ad551c696da388fd93c2b8c5c6f2e30b7b56bfb1825d87a5085b2b745b3cf9ff",
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
