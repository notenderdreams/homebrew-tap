class Dryve < Formula
  desc "Pull, selectively download, and sync shared Google Drive folders from the terminal"
  homepage "https://github.com/notenderdreams/dryve"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.2.1/dryve-aarch64-apple-darwin.tar.xz"
      sha256 "c0ae1b54077b470aef1aeda353fb0c287d30b84645b2ea1ddb3c4de1cb8cda28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.2.1/dryve-x86_64-apple-darwin.tar.xz"
      sha256 "0f4f947a7642546c0e72c550bc3384d66cb597091d3b4302a862738e068bc294"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.2.1/dryve-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3bf83a66ed4fd28d225748db1abab2ff04761cfd64ab17cbe1e98baf0c6b7824"
    end
    if Hardware::CPU.intel?
      url "https://github.com/notenderdreams/dryve/releases/download/v0.2.1/dryve-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef4042a1ce9fdcb488b652d32240f2acae0d9210af8ef2ecd229256860b1d7ee"
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
