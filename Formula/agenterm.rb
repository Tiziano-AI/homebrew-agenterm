class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/1b/dc/3efc95223aee1ccc53de77570d24304cec2ea19ba906adb80a2449d9ab9d/agenterm-0.3.1.tar.gz"
  sha256   "9a5e1a3b46bd7d30a75493411175ba990c964303765298cde1226e4f44661df2"
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
