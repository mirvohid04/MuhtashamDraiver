import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
   YandexMapController? controller;
  int _selectedIndex = 0;
  Future<void> _moveToCurrentLocation() async {
    // Xarita kontrolleri tayyor bo'lishini kutamiz
    final c = await mapControllerCompleter.future;

    // Ruxsatnomani tekshirish (Geolocator)
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();

      await c.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(latitude: position.latitude, longitude: position.longitude),
            zoom: 15,
          ),
        ),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── 1. YANDEX MAP (to'liq ekran) ──
          YandexMap(
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              // Lokatsiyani yoqish
              await controller?.toggleUserLayer(visible: true, headingEnabled: true);
            },

            // Foydalanuvchi belgisi qo'shilayotganda uni o'zgartirish:
            onUserLocationAdded: (UserLocationView view) async {
              // 1. Asosiy "pin" (to'xtab turgandagi belgi)
              final pinPlacemark = view.pin.copyWith(
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      'assets/images/user_marker.png',
                    ),
                  ),
                ),
              );

              // 2. "arrow" (harakatlanayotgan vaqtdagi strelka)
              final arrowPlacemark = view.arrow.copyWith(
                icon: PlacemarkIcon.single(

                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      'assets/icons/nav.png',
                    ),
                    scale: 0.3,           // ✅ Kichraytirish (1.0 = standart, 0.5 = yarmi)
                    anchor: const Offset(0.5, 0.5),
                    isFlat: false,
                    zIndex: 1.0,
                    rotationType: RotationType.noRotation,
                    //opacity: 0.5,         // ✅ Shaffoflik (0.0 = to'liq shaffof, 1.0 = to'liq ko'rinadi)
                  ),                ),

              );

              final accuracyCircle = view.accuracyCircle.copyWith(
                fillColor: Colors.transparent,
                strokeColor: Colors.transparent,
              );

              return view.copyWith(
                pin: pinPlacemark,
                arrow: arrowPlacemark,
                accuracyCircle: accuracyCircle,
              );
            },



          ),

          Positioned(
            left: 12,
            bottom:  260,
            child: _mapButton(Icons.manage_search),
          ),

          // ── 3. O'NG TUGMALAR ──
          Positioned(
            right: 12,
            bottom: _bottomPanelHeight(size) + 12,
            child: Column(
              children: [
                _mapButton(Icons.add),
                const SizedBox(height: 10),
                _mapButton(Icons.remove),
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: (){setState(() {
                      _moveToCurrentLocation();
                    });},
                    child: _mapButton(Icons.navigation)),
              ],
            ),
          ),

          // ── 4. PASTKI PANEL ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomPanel(size),
          ),
        ],
      ),

      // ── 5. BOTTOM NAVIGATION BAR ──
    );
  }

  // Pastki panel balandligi (map tugmalari joylashuvi uchun)
  double _bottomPanelHeight(Size size) => size.height * 0.42;

  // ─── Map round button ───────────────────────────────────────────────────────
  Widget _mapButton(IconData icon,) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }

  // ─── Pastki oq panel ────────────────────────────────────────────────────────
  Widget _buildBottomPanel(Size size) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Ustuvorlik & Buyurtma qatori ──
          IntrinsicHeight(
            child: Row(
              children: [
                // Ustuvorlik
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.workspaces,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Ustuvorlik',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            '+13',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Separator
                VerticalDivider(
                  color: Colors.grey[200],
                  thickness: 1,
                  width: 1,
                ),

                // 0 ta buyurtma
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '0 ta buyurtma',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "0 so'm",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Brending zarur kartasi ──
          _infoCard(
            left: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Brending zarur',
                  style: TextStyle(
                    color: Color(0xFFE8830A),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Maqsad mavjud emas',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            right: const Text(
              "340 000 so'm gacha",
              style: TextStyle(
                color: Color(0xFFE8830A),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),




          const SizedBox(height: 14),


          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:  [const Color(0xFF1BC261), const Color(0xFF4CD97B)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1BC261).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color:  const Color(0xFF1BC261),
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Oflayn',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Liniyaga chiqish',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),

        ],
      ),
    );
  }

  // ─── Info card (Brending / Bonuslar) ─────────────────────────────────────────
  Widget _infoCard({required Widget left, required Widget right}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [left, right],
      ),
    );
  }


  Widget _buildOnlineButton() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:  [const Color(0xFF1BC261), const Color(0xFF4CD97B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1BC261).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
               Icons.arrow_forward,
                color:  const Color(0xFF1BC261),
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oflayn',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                     'Liniyaga chiqish',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }


// ─── Bottom Navigation Bar ───────────────────────────────────────────────────
}