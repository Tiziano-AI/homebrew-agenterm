class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/2f/4e/657c41734ee85683551beb68b18c9b9b44689a8101a6c8e26fb3e9772b70/agenterm-0.1.4.tar.gz"
  sha256   "5adb021a4d2563bb2274facbe1dedb04d1500f866ea1c23198d00db43c3a16e8"
  license  "MIT"

  depends_on "python@3.12"

  # Rust CLI tools used by agenterm's function tools
  depends_on "ripgrep"
  depends_on "fd"
  depends_on "bat"
  depends_on "difftastic"
  depends_on "sd"
  depends_on "ast-grep"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
