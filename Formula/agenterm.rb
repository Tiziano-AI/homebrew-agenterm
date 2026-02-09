class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/45/3c/d483833f3951f285f71438d1b5a1f5f73cec7885b874d9150a78a32d5ccf/agenterm-0.5.0.tar.gz"
  sha256   "3d52918f62e3e03b972a77326e756cee2b26bcbe73d00dcd779723e0d06d7000"
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
