plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin
}

android {
    namespace = "com.example.precheck_hire"
    compileSdk = 35  // Updated to latest stable SDK
    ndkVersion = "27.0.12077973" // Ensure correct NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

   defaultConfig {
    applicationId = "com.example.precheck_hire"
    minSdk = 23  // Corrected
    targetSdk = 34  // Updated to latest stable SDK
    versionCode = 1
    versionName = "1.0"
}


    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
