class Agentbell < Formula
  desc "Local coding agent Attention Center for macOS"
  homepage "https://github.com/Han1enG/agent-bell"
  url on_arch_conditional(
    arm:   "https://github.com/Han1enG/agent-bell/releases/download/v0.4.0/agentbell_0.4.0_darwin_arm64.tar.gz",
    intel: "https://github.com/Han1enG/agent-bell/releases/download/v0.4.0/agentbell_0.4.0_darwin_amd64.tar.gz",
  )
  version "0.4.0"
  sha256 on_arch_conditional(
    arm:   "a18845d1e6f43c05d32806e22fe6e2edfe7202b84f0302dc04caca46c7029d06",
    intel: "5ffa177fc716c852fd3a6992d62df2a87f519797380601156d9343517fff2df7",
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
      After upgrading: agentbell install, then agentbell doctor
      Attention Center launches at login by default; configure attention_center.launch_at_login=false to opt out.
      Review/trust AgentBell hooks in Codex Settings -> Hooks; modified hooks are skipped until trusted.
      Restart agents after initial hook installation; restart Tabby/GoLand after integration updates.
      macOS may ask for notification and terminal automation permissions.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentbell version --short").strip
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", libexec/"AgentBell.app"
  end
end
