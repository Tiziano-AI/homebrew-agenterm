class Agenterm < Formula
  desc     "Terminal cockpit for multi-agent AI workflows (placeholder)"
  homepage "https://github.com/Tiziano-AI/agenterm"
  url      "https://files.pythonhosted.org/packages/source/a/agenterm/agenterm-0.0.0a0.tar.gz"
  sha256   "<SHA256 of that tar.gz>"
  license  "MIT"

  depends_on "python@3.12"

  def install
    # until real code ships, install a tiny stub executable
    (bin/"agenterm").write <<~EOS
      #!/bin/sh
      echo "Agenterm placeholder – real release coming soon"
    EOS
    bin.install "agenterm"
  end

  def caveats
    <<~EOS
      Agenterm is not yet released; this formula simply reserves the name.
    EOS
  end
end

