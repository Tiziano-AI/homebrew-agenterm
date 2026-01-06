class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/44/50/58d0f8601380dbfe66e4bd96bf602513ee9773021dc03b5f7489545f5855/agenterm-0.1.8.tar.gz"
  sha256   "4ea1402ee899a8b68fb1643b53fd15af968999318b6766cac434bda8f79a0b6d"
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
