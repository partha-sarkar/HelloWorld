# GitHub Actions Setup for Automatic APK Building

## Two Workflows Created

| Workflow | File | Purpose |
|----------|------|---------|
| **Simple Build** | `.github/workflows/build-simple.yml` | Builds debug + unsigned release APK on every push |
| **Full Release** | `.github/workflows/build-and-release.yml` | Builds, signs, and creates GitHub Release on version tags |

---

## Quick Start: Simple Build (No Setup Required)

1. **Push to GitHub** - workflow runs automatically
2. **Go to Actions tab** in your GitHub repo
3. **Click latest run** → Scroll down to **Artifacts**
4. **Download** `app-debug-apk` or `app-release-apk-unsigned`

> ⚠️ Unsigned release APK cannot be installed on devices (Android blocks it). Use debug APK for testing.

---

## Full Release Setup (Signed APK + Auto GitHub Release)

### 1. Generate Keystore (one-time)

```bash
# Run locally - keep this file SAFE!
keytool -genkeypair \
  -alias release-key \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -keystore release.keystore \
  -storepass YOUR_STORE_PASSWORD \
  -keypass YOUR_KEY_PASSWORD \
  -dname "CN=Your Name, OU=Your Unit, O=Your Org, L=City, S=State, C=US"
```

### 2. Convert to Base64

```bash
# macOS/Linux:
base64 -i release.keystore -o release.keystore.base64

# Windows PowerShell:
[Convert]::ToBase64String([IO.File]::ReadAllBytes("release.keystore")) > release.keystore.base64
```

### 3. Add GitHub Secrets

Go to: **Settings → Secrets and variables → Actions → New repository secret**

| Secret Name | Value |
|-------------|-------|
| `SIGNING_KEY_BASE64` | Content of `release.keystore.base64` |
| `KEY_ALIAS` | `release-key` |
| `KEY_STORE_PASSWORD` | Your keystore password |
| `KEY_PASSWORD` | Your key password |

### 4. Trigger a Release

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

This will:
1. ✅ Build debug & release APKs
2. ✅ Sign the release APK with your keystore
3. ✅ Create a **GitHub Release** at `github.com/USER/REPO/releases/tag/v1.0.0`
4. ✅ Attach the **signed APK** to the release
5. ✅ Users can download directly from the Releases page!

---

## How to Download APKs

### From Actions (every build):
1. Go to **Actions** tab
2. Click a workflow run
3. Scroll to **Artifacts** section
4. Click `app-debug-apk` or `app-release-apk-unsigned`

### From Releases (signed, versioned):
1. Go to **Releases** page
2. Click latest version
3. Download `app-release-signed.apk`

---

## Workflow Triggers

| Event | Simple Build | Full Release |
|-------|--------------|--------------|
| Push to main | ✅ | ❌ |
| Pull Request | ✅ | ❌ |
| Version tag (v*) | ✅ | ✅ |
| Manual dispatch | ✅ | ✅ |

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `gradlew: Permission denied` | `chmod +x gradlew` is in workflow |
| `JAVA_HOME not set` | `setup-java@v4` handles this |
| `SDK not found` | `setup-android@v3` handles this |
| Signing fails | Check all 4 secrets are set correctly |
| Release not created | Only triggers on `v*` tags |

---

## Customize Build Version

Edit `app/build.gradle`:
```gradle
defaultConfig {
    versionCode 1
    versionName "1.0.0"
}
```

Or auto-increment in workflow:
```yaml
- name: Auto-increment versionCode
  run: |
    VERSION_CODE=$(date +%s)
    sed -i "s/versionCode.*/versionCode $VERSION_CODE/" app/build.gradle
```