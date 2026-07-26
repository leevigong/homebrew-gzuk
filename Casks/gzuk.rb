cask "gzuk" do
  version "1.0.5"
  sha256 "df20cd4e187ee3690e769dc04f93612e6ac7704974b8d566aca4d33b359a2411"

  url "https://github.com/leevigong/gzuk/releases/download/v#{version}/gzuk-#{version}.zip"
  name "그려적어"
  desc "Draw and write directly on your screen"
  homepage "https://gzuk-app.vercel.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app ships Sparkle and self-updates from gzuk-app.vercel.app/appcast.xml.
  # Telling Homebrew "auto_updates true" stops it from forcing a downgrade
  # back to the Cask-pinned version when the user has already silently
  # upgraded via Sparkle.
  auto_updates true
  depends_on :macos

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
