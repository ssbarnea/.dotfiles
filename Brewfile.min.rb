# That contains only the minimal set of brew tools as we cannot really
# recompile all the tools we need on our CI/CD pipelines.
# cspell:ignore domt4
tap "domt4/autoupdate"
tap "github/bootstrap"
tap "github/gh"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "homebrew/services"

# Add only critical tools that are needed for bootstrapping or for essential
# features, like stuff that runs at login.
brew "stow"
brew "python"
