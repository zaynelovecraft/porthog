class Porthog < Formula
  desc "Zero-dependency macOS CLI around lsof, ps, and launchctl for port & service management"
  homepage "https://github.com/zaynelovecraft/porthog"
  url "https://github.com/zaynelovecraft/porthog/archive/refs/heads/main.tar.gz"
  version "0.2.0"
  license "MIT"

  def install
    bin.install "bin/porthog"
  end

  test do
    assert_match "porthog v0.2.0", shell_output("#{bin}/porthog --version")
  end
end
