# MAC_BUILD_PLAYBOOK

Audience: non-engineer
Goal: run PT-011 (first simulator build check) as soon as you get access to any Mac.
Last updated: 2026-03-04

## Step 0: What this playbook does
This guide lets you do first build verification with almost no technical decisions.
Follow from top to bottom.

## Step 1: Minimum prerequisites
- Apple ID (usable)
- Internet connection
- Access to a Mac (rental/shared/borrowed)
- Project source folder (`Pic-tan`)

Note:
- Apple Developer Program is not required for simulator build.
- It is required later for App Store submission.

## Step 2: Mac environment minimum
- macOS 13+ recommended
- Xcode 15+ recommended
- Free storage: 30 GB minimum (50 GB better)
- RAM: 8 GB minimum (16 GB better)

## Step 3: Install tools
1. Install Xcode from App Store.
2. Launch Xcode once and finish initial components.
3. Open Terminal and check Git:

```bash
git --version
```

If Git is missing:

```bash
xcode-select --install
```

## Step 4: Get project files
If using GitHub:

```bash
cd ~/Desktop
git clone https://github.com/KANNOHI1/Pic-tan.git
cd Pic-tan
```

If not using GitHub:
- Copy the `Pic-tan` folder to Mac by USB/AirDrop/cloud storage.

## Step 5: Open in Xcode

```bash
open apps/ios/PicTan.xcodeproj
```

Or double-click `apps/ios/PicTan.xcodeproj` in Finder.
Wait until package resolution completes.

## Step 6: First build and run
1. In Xcode, select target `PicTan`.
2. Select simulator device (example: iPhone 15 Pro).
3. Build: `Cmd + B`
4. Run: `Cmd + R`

Success means:
- Build succeeds
- App launches in simulator
- Card screen is visible

## Step 7: Runtime verification checklist
- App launches without crash
- Card content appears (animal words)
- Study mode can switch:
  - EN -> JA
  - JA -> EN
  - Pictogram -> EN
  - Pictogram -> JA
- Card flip animation works
- Rating buttons respond (`perfect`, `ok`, `hard`, `unknown`)
- Progress advances after rating
- Mascot state changes
- No blocking runtime error message

## Step 8: If project file cannot be opened
Fallback A (recommended): regenerate project with XcodeGen.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install xcodegen
cd ~/Desktop/Pic-tan/apps/ios
xcodegen generate
open PicTan.xcodeproj
```

Fallback B: verify core package only.

```bash
cd ~/Desktop/Pic-tan/packages/core
swift test
```

## Step 9: If JSON loading fails
Check these:
1. `apps/ios/Resources/animals_ja-JP.json` exists
2. `apps/ios/Resources/animals_en-US.json` exists
3. In Xcode File Inspector, Target Membership includes `PicTan`
4. Clean build folder (`Shift + Cmd + K`) and run again

## Step 10: Common errors and quick fixes
- `No such module 'PicTanCore'`
  - Xcode menu: File -> Packages -> Resolve Package Versions
- `Signing requires a development team`
  - Set your Apple ID in Signing & Capabilities -> Team
- `...json not found`
  - Re-check Resource files and Target Membership
- `Build input file cannot be found`
  - Verify file paths in project navigator
- Xcode unstable behavior
  - Restart Xcode and build again

## PT-011 done criteria
PT-011 can be marked DONE when all are true:
1. Build succeeds on simulator
2. App launches and card flow works
3. Results are logged in `tasks/HANDOFF_LOG.md`

## Handoff report template (copy/paste)

```text
## YYYY-MM-DD - Claude Code (PT-011)
- Build result: success/failure
- macOS / Xcode version:
- Simulator used:
- Checklist passed: X/8
- Issues found:
  - ...
- Next action:
```
