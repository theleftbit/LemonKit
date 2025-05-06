# LemonKit

Use this package to communicate with Lemon's backend.

## Apple Platforms

Just include this Package in your `Package.swift` as a dependency or in your Xcode project

## Android

This Swift Package is compatible with Android thanks to the Skip.tools's [native toolchain](https://skip.tools/docs/modes/#native$0).

In your `build.gradle.kts`, add this to your `repositories`:

```
maven {
    url = uri("https://maven.pkg.github.com/theleftbit/LemonKit/")
    credentials {
        username = gprUser
        password = gprKey
    }
}
```

And this to your `dependencies`:

```
debugImplementation(libs.bundles.lemonDebug)
releaseImplementation(libs.bundles.lemonRelease)
```

And in your `gradle/libs.versions.toml`

```
lemonkitVersion = "0.1.6"

# debug artifacts
lemonkit-debug            = { group = "com.theleftbit", name = "lemonkit-debug",            version.ref = "lemonkitVersion" }
skipbridge-debug          = { group = "com.theleftbit", name = "skipbridge-debug",          version.ref = "lemonkitVersion" }
skipandroidbridge-debug   = { group = "com.theleftbit", name = "skipandroidbridge-debug",   version.ref = "lemonkitVersion" }
skipfoundation-debug      = { group = "com.theleftbit", name = "skipfoundation-debug",      version.ref = "lemonkitVersion" }
skipkeychain-debug        = { group = "com.theleftbit", name = "skipkeychain-debug",        version.ref = "lemonkitVersion" }
skiplib-debug             = { group = "com.theleftbit", name = "skiplib-debug",             version.ref = "lemonkitVersion" }

# release artifacts
lemonkit-release          = { group = "com.theleftbit", name = "lemonkit-release",          version.ref = "lemonkitVersion" }
skipbridge-release        = { group = "com.theleftbit", name = "skipbridge-release",        version.ref = "lemonkitVersion" }
skipandroidbridge-release = { group = "com.theleftbit", name = "skipandroidbridge-release", version.ref = "lemonkitVersion" }
skipfoundation-release    = { group = "com.theleftbit", name = "skipfoundation-release",    version.ref = "lemonkitVersion" }
skipkeychain-release      = { group = "com.theleftbit", name = "skipkeychain-release",      version.ref = "lemonkitVersion" }
skiplib-release           = { group = "com.theleftbit", name = "skiplib-release",           version.ref = "lemonkitVersion" }

[bundles]
lemonDebug   = [ "lemonkit-debug", "skipbridge-debug", "skipandroidbridge-debug", "skipfoundation-debug", "skipkeychain-debug", "skiplib-debug" ]
lemonRelease = [ "lemonkit-release", "skipbridge-release", "skipandroidbridge-release", "skipfoundation-release", "skipkeychain-release", "skiplib-release"]
```

And in your `proguard-rules.pro`:

```
##---------------Skip----------
-keeppackagenames **
-keep class skip.** { *; }
-keep class tools.skip.** { *; }
-keep class kotlin.jvm.functions.** {*;}
-keep class com.sun.jna.** { *; }
-keep class * implements com.sun.jna.** { *; }
-dontwarn org.commonmark.**
```

**Note:** As you have seen earlier, loading GitHub Packages requires a username and password. We recommend creating a PAT on GitHub with read-only access to your Packages. Then, on your `local.properties`

```
gpr.usr=XXX
gpr.key=ghp_XXX
```

Once that is done, you can load them in your `build.gradle` as:

```
// Load from local.properties the user's GH PAT token to pull dependencies
def localProps = new Properties()
def localPropsFile = rootProject.file('local.properties')
if (localPropsFile.exists()) {
    localPropsFile.withInputStream { localProps.load(it) }
}

def gprUser = localProps.getProperty('gpr.usr') ?: System.getenv('GITHUB_ACTOR')
def gprKey  = localProps.getProperty('gpr.key') ?: System.getenv('GITHUB_TOKEN')
```
