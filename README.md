# homebrew-agentbell

Homebrew tap for [AgentBell](https://github.com/Han1enG/agent-bell).

Supports Apple Silicon and Intel Macs running macOS 13 or later. The formula preserves the complete signed application bundle for notification delivery and click handling.

```bash
brew tap Han1enG/agentbell
brew trust --formula Han1enG/agentbell/agentbell
brew install agentbell
agentbell install
```

Homebrew 7 默认要求显式信任第三方 Formula；这里只信任 AgentBell 这一项。

升级现有安装：

```bash
brew update
brew upgrade agentbell
agentbell doctor --fix
agentbell doctor
```

升级使用完整的 `AgentBell.app`，不要只替换主程序。点击通知进入项目目录；首次控制终端时需要允许 macOS 自动化权限。
