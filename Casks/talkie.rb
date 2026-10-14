cask "talkie" do
  version "0.2.0"
  sha256 "9ce016d050f7e34b095ff442ca30264acd3690b7ddb87107cdfb174c3d02f580"

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
    Talkie is not yet notarised. If macOS says the app is damaged, install with
      brew install --cask --no-quarantine ajmccall/tap/talkie
    or run
      xattr -dr com.apple.quarantine /Applications/Talkie.app
    First launch downloads about 2.6 GB of speech models (Parakeet, Qwen3).
    Speech model caches are left in place on uninstall; see the README.
  EOS
end
