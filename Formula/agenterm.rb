class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/37/25/0bcfda2bb306e59e9f62ef6bae60aec813e1d49e9e7000655c755c19635a/agenterm-0.1.7.tar.gz"
  sha256   "e4d6733168067f31f497173436d1373b2628e276a149f263c3e0d7f3c881c2b0"
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
