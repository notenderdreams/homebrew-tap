class Spade < Formula
  desc "Save, manage, and run reusable command shortcuts"
  homepage "https://github.com/notenderdreams/spade"
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://github.com/notenderdreams/spade/releases/download/v0.1.1/spade_0.1.1_darwin_arm64.tar.gz"
      sha256 "e73b8b4d3790cfaeb5c5aa55534fe0253eca0001f2443c82742f08de74feceb4"
    end
    on_intel do
      url "https://github.com/notenderdreams/spade/releases/download/v0.1.1/spade_0.1.1_darwin_amd64.tar.gz"
      sha256 "22d52943ccda059d6dd1dde1b4f08aa6c0979c7780bc01ee433027c136cd17e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/notenderdreams/spade/releases/download/v0.1.1/spade_0.1.1_linux_arm64.tar.gz"
      sha256 "d46bf75f20db522759d95a9135f32ce01d487e122e7c9310ef3c70b6c30f23fb"
    end
    on_intel do
      url "https://github.com/notenderdreams/spade/releases/download/v0.1.1/spade_0.1.1_linux_amd64.tar.gz"
      sha256 "66d60d520c04e578f2ab170d20e07d93b6a462ab42bf877134cd00eaa0911a9b"
    end
  end

  def install
    bin.install "spd"
    generate_completions_from_executable(bin/"spd", "completion")
  end

  test do
    assert_match "spade version #{version}", shell_output("#{bin}/spd --version")
    system bin/"spd", "add", "homebrew-smoke", "echo", "hello"
    assert_match "hello", shell_output("#{bin}/spd homebrew-smoke")
  end
end
