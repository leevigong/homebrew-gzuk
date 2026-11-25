cask "gzuk" do
  version "1.0.7"
  sha256 "1caed8a346b1b1d1944db25e4d1bd745a35e2b221f2e01c98e3872b6a4baa1e2"

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
  # Matches LSMinimumSystemVersion (14.0) in the app bundle — without the
  # bound, Homebrew installs happily on older macOS and the app only fails
  # once the user tries to launch it.
  depends_on macos: :sonoma

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
