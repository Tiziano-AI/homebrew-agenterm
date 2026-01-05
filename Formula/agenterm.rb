class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/37/7f/82023b0aef2cd78e1a150eae0b82e4f879197a236db7c43358239c9a4c9f/agenterm-0.1.6.tar.gz"
  sha256   "5b9886c61c7b65880f9a9a4159c44e1ab63f574cd7599358d50fc9d09d36c2cb"
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
