# homebrew-tap

Homebrew tap for Joelazar apps, including [AltAltTab](https://github.com/joelazar/alt-alt-tab).

## Install

```bash
brew tap joelazar/tap
brew install --cask alt-alt-tab
```

## Uninstall

```bash
brew uninstall --cask alt-alt-tab
```

## Maintainer release flow (AltAltTab)

When you publish a new AltAltTab release:

1. Build and package app in `alt-alt-tab` repo:
   ```bash
   mise run app_bundle_release
   ditto -c -k --sequesterRsrc --keepParent AltAltTab.app AltAltTab.app.zip
   ```
2. Create GitHub release tag `vX.Y.Z` in `joelazar/alt-alt-tab` and upload `AltAltTab.app.zip`.
3. In this tap repo, bump the cask with:
   ```bash
   ./scripts/bump-cask.sh X.Y.Z
   ```
4. Commit and push this repo.

## Notes

- Cask file: `Casks/alt-alt-tab.rb`
- Tap name is `joelazar/tap` (repo name is `homebrew-tap`)
