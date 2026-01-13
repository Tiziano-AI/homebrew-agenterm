class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/44/cb/f33ee3c418720e701f8563cb6d12735366b64cdcb0b23458e0a34f59b7d1/agenterm-0.3.2.tar.gz"
  sha256   "5b9bbb5228cd82b468a48886d7b449a96b2a68704062b7d087db1f94bd62c441"
  license  "MIT"

  depends_on "python@3.12"

  # Rust CLI tools used by agenterm's function tools
  depends_on "ripgrep"
  depends_on "fd"
  depends_on "bat"
  depends_on "tree"

  def install
    # Create virtualenv WITH pip (not Homebrew's --without-pip default)
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Install from PyPI using pre-built wheels (fast, no compilation)
    system libexec/"bin/pip", "install", "--prefer-binary", "agenterm==#{version}"

    # Symlink the CLI entrypoint
    bin.install_symlink libexec/"bin/agenterm"
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
