class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/82/2b/dfb54bb48cf7f0ac784c6587c5d37cb9929258f51b95f3663dc0efb41ef1/agenterm-0.2.0.tar.gz"
  sha256   "10e7756bb7a242a9d43ac032e7731dbec4b8f3b89fa5b4a6d3382474ff900e35"
  license  "MIT"

  depends_on "python@3.12"

  # Rust CLI tools used by agenterm's function tools
  depends_on "ripgrep"
  depends_on "fd"
  depends_on "bat"
  depends_on "tree"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
