cask "pastedeck" do
  version "2.1"
  sha256 :no_check

  url "https://github.com/EmirOzzturk/PasteDeck/releases/download/v#{version}/PasteDeck-v#{version}.zip"
  name "PasteDeck"
  desc "Lightweight, fast clipboard manager for macOS"
  homepage "https://github.com/EmirOzzturk/PasteDeck"

  depends_on macos: ">= :sonoma"

  app "PasteDeck.app"

  def postflight
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/PasteDeck.app"]
    system_command "/usr/bin/codesign", args: ["--force", "--deep", "-s", "-", "#{appdir}/PasteDeck.app"]
  end

  zap trash: [
    "~/Library/Application Support/PasteDeck",
  ]

  caveats <<~EOS
    On first launch, grant Accessibility permission in:
    System Settings → Privacy & Security → Accessibility
  EOS
end
