# Rendered by scripts/cask.sh into kedrzu/homebrew-tap's Casks/leukocyte.rb; edit the template, not
# the tap.
cask "leukocyte" do
  version "0.2.1"
  sha256 "aa320d6799d92c43a532bc0c4d26fd38d73c399cca34b2dd18095ac6b28d8495"

  url "https://github.com/kedrzu/leukocyte/releases/download/v#{version}/Leukocyte-#{version}.zip"
  name "leukocyte"
  desc "Kills stale dev processes left behind by AI coding agents"
  homepage "https://github.com/kedrzu/leukocyte"

  depends_on macos: :ventura

  app "Leukocyte.app"
  binary "#{appdir}/Leukocyte.app/Contents/MacOS/leukocyte"

  zap trash: [
    "~/.config/leukocyte",
    "~/Library/Application Support/leukocyte",
    "~/Library/Logs/leukocyte",
  ]

  # No flight blocks and no `uninstall launchctl:`: an upgrade runs the old cask's uninstall too, so
  # they would stop the agent on every upgrade. The daemon follows its own executable instead: it
  # restarts when the app is replaced and removes its LaunchAgent when the app is gone.
  caveats <<~EOS
    Run `leukocyte install` once to start the background agent.

    After `brew uninstall --cask leukocyte` the agent removes itself within about two minutes;
    run `leukocyte uninstall` first to stop it at once.
  EOS
end
