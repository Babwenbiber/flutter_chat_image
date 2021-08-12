# chat_image

A Package for loading an image from the web, saving it locally in the gallery and showing the locally saved image.

## Difference to CachedNetworkImage

[CachedNetworkImage](https://pub.dev/packages/cached_network_image) is a great package, that loads an image from the web and stores it in your apps cache.
The main difference is that ChatImage downloads the image and stores it into the gallery instead of storing int into the cache. 
While the cache can't be reused for every session you might need to download the image once again in some sessions.
However, the main usecase for the ChatImage package is to store images from a chat. You would not want to download images again on reentering the chat. This package will save the image locally once and then reuse the image.

## Installation

First, add chat_image as a dependency in your pubspec.yaml file.

### iOS 

Add the following keys to your Info.plist file, located in `<project root>/ios/Runner/Info.plist`:

NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.

E.g.
```
...
<key>NSPhotoLibraryUsageDescription</key>
<string>Save Images locally and reuse them again</string>
...
```
### Android 

Add: Permissions for storing images (android.permission.WRITE_EXTERNAL_STORAGE - Permission for usage of external storage
):

E.g.
```
<manifest ...>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <application
        ...
       android:requestLegacyExternalStorage="true"
       ...>
        ...
```
   

## Example
```
ChatImage(
    url: "https://raw.githubusercontent.com/Babwenbiber/flutter_chat_image/master/res/TA_Logo.jpg",
    errorBuilder: (BuildContext context, String errorMsg) {
      return Text("some error $errorMsg");
    },
    imageBuilder: (BuildContext context, Image image) {
      return  image;
    })
```

