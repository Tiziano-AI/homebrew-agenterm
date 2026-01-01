class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/03/2b/ac2db795e9fbdceaa894f0503d9ff56af236ae3dc0f52e11e299e1c69047/agenterm-0.1.0.tar.gz"
  sha256   "cb339b0c76f14ff102f0656091752c2fa6030b17da20a021c9437bacadb6b72a"
  license  "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
