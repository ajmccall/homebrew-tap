cask "talkie" do
  version "0.3.0"
  sha256 "981bbc4015078ea9efa3b02c6424341f585af5b623d017db791c63e6565e4b4d"

  url "https://github.com/ajmccall/talkie/releases/download/v#{version}/Talkie-#{version}.zip"
  name "Talkie"
  desc "Local push-to-talk dictation: hold Fn, speak, text is pasted"
  homepage "https://github.com/ajmccall/talkie"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Talkie.app"

  uninstall quit: "com.alasdairmccall.talkie"

  zap trash: [
    "~/Library/Application Support/com.alasdairmccall.talkie",
    "~/Library/Caches/com.alasdairmccall.talkie",
    "~/Library/HTTPStorages/com.alasdairmccall.talkie",
    "~/Library/Preferences/com.alasdairmccall.talkie.plist",
  ]

  caveats <<~EOS
    Talkie is not yet notarised, so macOS will say the app is damaged until you run
      xattr -dr com.apple.quarantine /Applications/Talkie.app
    First launch downloads about 2.6 GB of speech models (Parakeet, Qwen3).
    Speech model caches are left in place on uninstall; see the README.
  EOS
end
