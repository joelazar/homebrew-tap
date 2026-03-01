cask "alt-alt-tab" do
  version "1.0.0"
  sha256 "REPLACE_WITH_SHA256"

  url "https://github.com/joelazar/alt-alt-tab/releases/download/v#{version}/AltAltTab.app.zip",
      verified: "github.com/joelazar/alt-alt-tab/"
  name "AltAltTab"
  desc "Minimal Cmd+Tab replacement for macOS"
  homepage "https://github.com/joelazar/alt-alt-tab"

  depends_on macos: ">= :monterey"

  app "AltAltTab.app"
  binary "#{appdir}/AltAltTab.app/Contents/MacOS/AltAltTab"

  uninstall quit: "com.joelazar.altalttab"

  zap trash: [
    "~/.config/altalttab",
  ]
end
