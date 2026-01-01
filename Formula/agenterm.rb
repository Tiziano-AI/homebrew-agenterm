class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/3e/c9/33de1fe8e1751b3f0b80afa992c8a39d307bdfd8c6f9f3586060aa1be0fc/agenterm-0.1.1.tar.gz"
  sha256   "8e5b38a867da6dac96523ea50611ed747f894b0bf1833a2d1af846e30e4d6701"
  license  "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
