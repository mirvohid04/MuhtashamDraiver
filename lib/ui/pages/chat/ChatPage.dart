import 'package:flutter/material.dart';

class XabarlarPage extends StatelessWidget {
  const XabarlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Text(
                  "Xabarlar",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Promo Cards
              SizedBox(
                height: 155,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    _PromoCard(
                      title: "Muhtasham ijtimoiy tarmoqlarda",
                      icon: Icons.telegram,
                      bgColor: Colors.white,
                      iconColor: Color(0xFF1BC261),
                      isNew: true,
                    ),
                    _PromoCard(
                      title: "Safarga oid maxsus xohishlar",
                      icon: Icons.accessible_forward,
                      bgColor: Color(0xFFE6F9EF),
                      iconColor: Color(0xFF1BC261),
                      isNew: true,
                    ),
                    _PromoCard(
                      title: "Nega buyurtmalar yo'q?",
                      icon: Icons.local_taxi,
                      bgColor: Color(0xFFFFF8E1),
                      iconColor: Color(0xFFFFC107),
                      isNew: true,
                    ),
                    _PromoCard(
                      title: "Zerex shinalariga chegirma",
                      icon: Icons.tire_repair,
                      bgColor: Color(0xFFFFF8E1),
                      iconColor: Color(0xFFFFC107),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Notification List
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _messageItem(
                    icon: Icons.pan_tool,
                    color: const Color(0xFF1BC261),
                    title: "Yordam xizmati",
                    hasArrow: true,
                  ),

                  _messageItem(
                    icon: Icons.warning_amber_rounded,
                    color: const Color(0xFFFFC107),
                    title: "Ogohlantirishlar",
                    subtitle: "Mashina fotonazoratidan o'tildi",
                    time: "02:40",
                  ),
                  _messageItem(
                    icon: Icons.description,
                    color: const Color(0xFF1BC261),
                    title: "Pro Yangiliklari",
                    subtitle: "\"Ish bilan\" rejimidagi o'zgarishlar",
                    time: "Chor",
                  ),
                  _messageItem(
                    icon: Icons.card_giftcard,
                    color: const Color(0xFF1565C0),
                    title: "Bonuslar",
                    subtitle: "Avtomobil yuzasiga reklama materiallarini bepul ...",
                    time: "12 fev",
                  ),

                  _messageItem(
                    icon: Icons.account_balance_wallet,
                    color: Colors.teal,
                    title: "Balance",
                    hasArrow: true,
                    showDivider: false,
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageItem({
    required IconData icon,
    required Color color,
    required String title,
    String subtitle = "",
    String? time,
    bool hasArrow = false,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      const SizedBox(height: 2),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                  ],
                ),
              ),
              if (time != null)
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              if (hasArrow)
                Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 70,
            endIndent: 16,
            color: Colors.grey.shade200,
          ),
      ],
    );
  }
}

// ─── Promo Card ───────────────────────────────────────────────────────────────

class _PromoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool isNew;

  const _PromoCard({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Icon(icon, color: iconColor, size: 36),
                const Spacer(),
                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (isNew)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'New',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}




