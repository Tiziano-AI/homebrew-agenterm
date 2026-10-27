require "minitest/autorun"
require "pathname"
require "rubygems/version"

Version = Gem::Version

module Utils
  class << self
    attr_accessor :pip_version, :python_version

    def safe_popen_read(*args)
      "#{args.last.include?('platform.python_version') ? python_version : pip_version}\n"
    end
  end
end

class Formula
  class << self
    def test
      nil
    end

    def method_missing(*)
      nil
    end

    def [](_name)
      Struct.new(:opt_bin).new(Pathname("/fixture/python/bin"))
    end
  end

  attr_reader :commands

  def initialize
    @commands = []
  end

  def libexec
    Pathname("/fixture/libexec")
  end

  def buildpath
    Pathname("/fixture/verified-agenterm-0.6.0")
  end

  def bin
    Object.new.tap do |directory|
      def directory.install_symlink(*)
        nil
      end
    end
  end

  def system(*args)
    @commands << args
  end

  def odie(message)
    raise RuntimeError, message
  end
end

require_relative "../Formula/agenterm"

class InstallerTest < Minitest::Test
  def setup
    Utils.python_version = "3.12.16"
    Utils.pip_version = "26.2.2"
  end

  def test_rejects_unpatched_python_before_creating_environment
    Utils.python_version = "3.12.15"
    formula = Agenterm.new
    error = assert_raises(RuntimeError) { formula.install }
    assert_match(/Python >=3.12.16/, error.message)
    assert_empty formula.commands
  end

  def test_accepts_later_python_patch_releases
    Utils.python_version = "3.12.17"
    formula = Agenterm.new
    formula.install
    assert_includes formula.commands.first, "venv"
  end

  def test_rejects_compromised_pip_before_package_downloads
    Utils.pip_version = "26.2.1"
    formula = Agenterm.new
    error = assert_raises(RuntimeError) { formula.install }
    assert_match(/pip >=26.2.2/, error.message)
    assert_equal 1, formula.commands.length
    assert_includes formula.commands.first, "venv"
  end

  def test_installs_verified_source_with_compatible_patched_dependencies_and_fixed_pip
    ["26.2.2", "26.2.3", "27.0"].each do |version|
      Utils.pip_version = version
      formula = Agenterm.new
      formula.install
      assert_equal [
        formula.libexec/"bin/python", "-m", "pip", "install",
        "--prefer-binary", formula.buildpath, "litellm>=1.96.2", "filelock>=4.2.1", "mcp<2"
      ], formula.commands.last
    end
  end
end
