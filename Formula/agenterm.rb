class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/3c/44/d030e08f643cf97d8005addef834d156f02bff4c07b6046594d8b88186e0/agenterm-0.1.5.tar.gz"
  sha256   "08f2bf719f986ef01287a08d78dad3ce6fabf8c05d9c747e85a82e7c4ca289c5"
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
