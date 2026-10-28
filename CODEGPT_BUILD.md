# Building Code GPT Editor (step by step)

GitHub builds the installers for you, for free, on its own computers. You only press buttons on github.com.
The first build takes about **1.5 to 2.5 hours**. Later builds take the same time.

## 1. Put this folder on GitHub (once)

1. Create a GitHub account if you do not have one, and log in.
2. Create a new repository named **codegpt-editor**. Choose **Public** (public repositories get unlimited free build minutes;
   a private one would use up the free 2,000 minutes a month quickly). Do not add a README.
3. On your Windows PC, install Git (once), in PowerShell:

       winget install --id Git.Git -e

   Close PowerShell and open it again.
4. Unzip `codegpt-editor.zip`, then in PowerShell go into the folder and upload it (replace YOUR-NAME):

       cd $HOME\Downloads\codegpt-editor
       git init
       git add .
       git commit -m "Code GPT Editor"
       git branch -M master
       git remote add origin https://github.com/YOUR-NAME/codegpt-editor.git
       git push -u origin master

   The first time, a GitHub sign-in window opens. Sign in and allow it.

> The branch must be called **master** (the build scripts expect it).

## 2. Allow the build to publish releases (once)

On GitHub, open your repository › **Settings** › **Actions** › **General**:
- under *Actions permissions*, choose **Allow all actions and reusable workflows**;
- under *Workflow permissions*, choose **Read and write permissions** and press **Save**.

## 3. Build

1. Open the **Actions** tab. If GitHub asks, press **I understand my workflows, go ahead and enable them**.
2. Click **Build Code GPT Editor** on the left, then **Run workflow** › **Run workflow**.
3. Wait. Each system is built in its own box; green ticks mean it worked.
4. When it finishes, open **Releases** (right side of the repository page). You will see:
   - `CodeGPTUserSetup-x64-<version>.exe`: the Windows installer (recommended)
   - `CodeGPTSetup-x64-<version>.exe`: Windows installer for all users of the PC
   - `CodeGPT.arm64.<version>.dmg`: Mac with Apple silicon (M1, M2, M3, M4); `CodeGPT.x64.<version>.dmg`: older Intel Macs
   - `.deb` (Ubuntu, Debian), `.rpm` (Fedora) and `.tar.gz` for Linux

## 4. Show the downloads on your website (once)

In **Admin › Settings › Code GPT Editor**, type `YOUR-NAME/codegpt-editor` and save. Then:
- the **/editor** and **/download** pages show download buttons for the newest release, and
- people who use the editor get a message when you publish a newer version.

## 5. New versions

Run the workflow again whenever you want (for example after you update the Code GPT agent, or when a new VS Code version is out).
To update the VS Code version it is built on, change `upstream/stable.json` to the new tag and commit, as VSCodium does.

To update the built-in Code GPT agent: copy the newest `extensions/vscode` folder from the Code GPT server pack into
`src/stable/extensions/codegpt-agent`, commit, push, and run the workflow.

## Optional: signing (removes the "unknown app" warnings)

Without signing, Windows SmartScreen and macOS show a warning the first time (people press *More info › Run anyway*
on Windows, or *right-click › Open* on Mac). To remove the warnings later:
- **macOS**: an Apple Developer account (99 USD a year). Add these repository secrets: `CERTIFICATE_OSX_P12_DATA`,
  `CERTIFICATE_OSX_P12_PASSWORD`, `CERTIFICATE_OSX_APPLE_ID`, `CERTIFICATE_OSX_APP_PASSWORD`, `CERTIFICATE_OSX_TEAM_ID`.
  The workflow then signs and notarizes the Mac app automatically.
- **Windows**: a code-signing certificate (for example from SignPath, which is free for open-source projects). Ask us to add the signing step.

## If a build fails

Open the red step, copy the last 30 lines of the log and send them to us. Most failures are temporary (a download timed out):
press **Re-run failed jobs**.
