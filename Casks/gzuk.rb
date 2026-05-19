cask "gzuk" do
  version "1.0.3"
  sha256 "4afb8c6c41f8b0f5fc6017fe69e3f6340d42666eaed5578c58d7ba69121b1c00"

  url "https://github.com/leevigong/gzuk/releases/download/v#{version}/gzuk-#{version}.zip"
  name "그려적어"
  desc "Draw and write directly on your macOS screen"
  homepage "https://gzuk-app.vercel.app"

  # The app ships Sparkle and self-updates from gzuk-app.vercel.app/appcast.xml.
  # Telling Homebrew "auto_updates true" stops it from forcing a downgrade
  # back to the Cask-pinned version when the user has already silently
  # upgraded via Sparkle.
  auto_updates true

  livecheck do
    url :url
    strategy :github_latest
  end

  app "그려적어.app"

  # The app is ad-hoc signed (no Apple Developer ID). Strip the download
  # quarantine attribute so macOS Gatekeeper doesn't block first launch —
  # users trust the cask maintainer rather than an Apple-issued certificate.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{appdir}/그려적어.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.leevigong.GZUK.plist",
    "~/Library/Saved Application State/com.leevigong.GZUK.savedState",
  ]
end
