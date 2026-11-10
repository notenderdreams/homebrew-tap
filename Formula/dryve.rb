class Dryve < Formula
  desc "Pull, selectively download, and sync shared Google Drive folders from the terminal"
  homepage "https://github.com/notenderdreams/dryve"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.3.0/dryve-aarch64-apple-darwin.tar.xz"
      sha256 "dfd056d94790524d1bf6a3e3410e75fe1453140b0439d75e16bf75c3aaed1eb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.3.0/dryve-x86_64-apple-darwin.tar.xz"
      sha256 "d3576be077cbdcb92e87e3abcf436a66642508ea127577ae6addf133ebd78772"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.3.0/dryve-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f15541c123e244f3ff1b3a336f27771d11042904ccb62a0df267031d2855fe9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.3.0/dryve-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4fc92c092aba67b59873b88a4919a5f9d602670d6c04d37d3df16a4413f6f84d"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dryve"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dryve"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dryve"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dryve"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
