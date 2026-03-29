package com.example.food_draiver

import io.flutter.embedding.android.FlutterActivity




import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        // API Kalitni mana shu yerga qo'ying
        MapKitFactory.setApiKey("9be8df21-ecb6-4207-82d4-b165b0e0e8eb")
        super.configureFlutterEngine(flutterEngine)
    }
}
