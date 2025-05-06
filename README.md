# eitri-ios

## Installation with Swift Package Manager (SPM)

The `eitri-ios` library is available via Swift Package Manager.

### Step-by-step

1. In **Xcode**, open your project and go to  
   `File > Add Packages...`

2. In the **Search or Enter Package URL** field, paste the repository URL:

   ```
   https://github.com/Calindra/eitri-ios
   ```

3. Choose the latest available version or select a specific version/range.

4. Click **Add Package** to confirm.

5. In the next dialog, make sure the package is added to the correct target(s) of your project.

### Alternative: Using `Package.swift`

If you are managing dependencies manually with a `Package.swift` file, add the following to your dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/Calindra/eitri-ios", from: "X.Y.Z") // Replace X.Y.Z with the desired version
]
```

And don't forget to add `"Eitri"` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "Eitri"
    ]
)
```

---

### Minimum Requirements

- iOS 13.0+
- Swift 5.5+





