cask "talkie" do
  version "0.2.0"
  sha256 "1a736e13b36016e6bbda920c32a0a2e36f4fa44b11d7a50a7852b718fe7e9dab"

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
