class Agenterm < Formula
  desc     "Terminal-native agent runtime with persistent sessions, branching, and MCP"
  homepage "https://pypi.org/project/agenterm/"
  url      "https://files.pythonhosted.org/packages/ad/cf/ad8861074600a4b385182315cac285cbea1ae003ea7492faf89aca4f46ce/agenterm-0.6.0.tar.gz"
  sha256   "0f13ed5b4812abd17908c7ade9574bc6b0450c7827e25c1b36a5336a3cf709f9"
  license  "MIT"
  revision 1

  depends_on "python@3.12"

  # Rust CLI tools used by agenterm's function tools
  depends_on "ripgrep"
  depends_on "fd"
  depends_on "bat"
  depends_on "tree"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"
    python_version = Utils.safe_popen_read(python, "-c", "import platform; print(platform.python_version())").strip
    if Version.new(python_version) < Version.new("3.12.16")
      odie "Python >=3.12.16 is required for safe TLS; upgrade Homebrew python@3.12 and retry."
    end

    # Create virtualenv WITH pip (not Homebrew's --without-pip default)
    system python, "-m", "venv", libexec

    # Older pip bundles still trust compromised emSign certificates.
    pip_version = Utils.safe_popen_read(
      libexec/"bin/python", "-c", "import importlib.metadata; print(importlib.metadata.version('pip'))"
    ).strip
    if Version.new(pip_version) < Version.new("26.2.2")
      odie "pip >=26.2.2 is required for safe downloads; upgrade Homebrew python@3.12 and retry."
    end

    # Install verified source with patched dependencies and Agenterm's MCP 1.x API.
    system libexec/"bin/python", "-m", "pip", "install", "--prefer-binary", buildpath,
           "litellm>=1.96.2", "filelock>=4.2.1", "mcp<2"

    # Symlink the CLI entrypoint
    bin.install_symlink libexec/"bin/agenterm"
  end

  test do
    assert_match "agenterm", shell_output("#{bin}/agenterm --help")
  end
end
