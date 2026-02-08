class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/91/a8/88adc25a19e318453c1a0acfafee119653baa701466a58e1d278c2517d7f/agenterm-0.4.0.tar.gz"
  sha256   "c4887cd9924fbcd547a89548748bd7e1463a95aacb40f958d38cdca000810533"
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
