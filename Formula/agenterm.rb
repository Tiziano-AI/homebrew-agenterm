class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/ad/cf/ad8861074600a4b385182315cac285cbea1ae003ea7492faf89aca4f46ce/agenterm-0.6.0.tar.gz"
  sha256   "0f13ed5b4812abd17908c7ade9574bc6b0450c7827e25c1b36a5336a3cf709f9"
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
