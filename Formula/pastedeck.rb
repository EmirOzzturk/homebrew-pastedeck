class Pastedeck < Formula
  desc "Lightweight, fast clipboard manager for macOS"
  homepage "https://github.com/EmirOzzturk/PasteDeck"
  url "https://github.com/EmirOzzturk/PasteDeck.git",
      tag:      "v2.1",
      revision: "20e24e8e591b41302a0ef6c858fd3167e090843f"
  license "MIT"
  head "https://github.com/EmirOzzturk/PasteDeck.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release"
    system "bash", "build_app.sh", "release"

    prefix.install ".build/PasteDeck.app"
  end

  def caveats
    <<~EOS
      PasteDeck.app installed to #{opt_prefix}.

      On first launch, grant Accessibility permission in:
      System Settings → Privacy & Security → Accessibility

      If macOS blocks the app with a quarantine warning:
        xattr -cr #{opt_prefix}/PasteDeck.app
    EOS
  end

  test do
    system "test", "-d", "#{prefix}/PasteDeck.app"
  end
end
