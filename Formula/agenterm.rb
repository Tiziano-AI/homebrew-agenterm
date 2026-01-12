class Agenterm < Formula
  include Language::Python::Virtualenv

  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/04/f6/db2a0597954c8e4bfc5da9101b1d3db5abcec9c498c533cc24bc34362683/agenterm-0.3.0.tar.gz"
  sha256   "2ddf58fffa0119fd1bdd2c5f5b4da223a16b2c7343970fed40c6428ef4c6819c"
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
