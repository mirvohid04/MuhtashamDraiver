import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PulPage extends StatelessWidget {
  const PulPage({super.key});
  String formatNumber(String s) {
    return s.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]} '
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 10,),
          // Custom Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pul',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Tooltip(
                message: 'Texnik yordam',
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.headset_mic_outlined),
                        onPressed: () {
                        },
                        color: const Color(0xFF1BC261),
                        iconSize: 20,
                      ),
                    ),
                    // Badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          const SizedBox(height: 20),

          // O so'm va Bugun
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: AutoSizeText(
                      formatNumber("30000 so'm"),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                      minFontSize: 16,
                      maxLines: 1,
                      stepGranularity: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Bugun',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: 60,
                    maxHeight: 60
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    List<String> days = ['15', '16', '17', '18', '19', '20', '21'];
                    List<double> hight = [15, 8, 17, 43, 19, 4, 21];

                    bool isSelected = days[index] == '21';
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 17,
                            height: hight[index],
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: isSelected ? const Color(0xFF1BC261) : Colors.grey[300],
                            ),
                          ),
                          Text(days[index], style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 30),

          // Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1BC261),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1BC261).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text(
                    'Hisob balansi',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                    Text(
                    '30 000',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "so'm",
                    style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white70,
            size: 16,
          ),
        ),
        ],
      ),
    ),
    ],
    ),
    ),
    ),
    );
  }
}




