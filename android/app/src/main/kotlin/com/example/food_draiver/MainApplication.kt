import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("9be8df21-ecb6-4207-82d4-b165b0e0e8eb") // Your generated API key
    }
}