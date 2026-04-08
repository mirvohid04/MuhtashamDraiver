import 'dart:async';
import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animController;
  Animation<double>? _fadeAnim;
  double _dragPosition = 0.0;
  bool _isOnline = false;
  bool _isGross = true;
  Timer? _autoHideTimer;

  final double _buttonWidth = 70.0;

  List<Order> orders = [
    Order(
      id: 'ORD-001',
      customerName: 'Anvar Karimov',
      customerPhone: '+998 90 123 45 67',
      address: 'Chilonzor 9-kvartal, 12-uy',
      distance: '2.4 km',
      amount: 128000,
      items: ['Margherita Pizza - 89000', 'Coca-Cola 0.5L - 39000'],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Order(
      id: 'ORD-002',
      customerName: 'Dilnoza Abdurahimova',
      customerPhone: '+998 93 234 56 78',
      address: 'Yunusobod 14-mavze, 5-uy',
      distance: '5.1 km',
      amount: 245000,
      items: ['Sushi Set - 189000', 'Green Tea - 25000', 'Miso Soup - 31000'],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Order(
      id: 'ORD-003',
      customerName: 'Jasur Rahimov',
      customerPhone: '+998 94 345 67 89',
      address: 'Sergeli 3-mavze, 45-uy',
      distance: '7.8 km',
      amount: 89000,
      items: ['Cheeseburger - 45000', 'French Fries - 22000', 'Fanta - 22000'],
      status: OrderStatusType.READY_TO_PICKUP,
      orderTime: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Order(
      id: 'ORD-004',
      customerName: 'Gulnara Toshmatova',
      customerPhone: '+998 91 456 78 90',
      address: 'Mirobod 2-tor ko\'cha, 8-uy',
      distance: '1.2 km',
      amount: 567000,
      items: [
        'Beef Steak - 350000',
        'Red Wine - 150000',
        'Caesar Salad - 67000',
      ],
      status: OrderStatusType.READY_TO_PICKUP,
      orderTime: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Order(
      id: 'ORD-005',
      customerName: 'Sherzod Aliyev',
      customerPhone: '+998 97 567 89 01',
      address: 'Olmazor 7-mavze, 23-uy',
      distance: '3.6 km',
      amount: 176000,
      items: [
        'Chicken Wings - 89000',
        'Pepsi 1L - 45000',
        'Onion Rings - 42000',
      ],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Order(
      id: 'ORD-006',
      customerName: 'Madina Azimova',
      customerPhone: '+998 90 678 90 12',
      address: 'Yakkasaroy 4-tor ko\'cha, 15-uy',
      distance: '4.0 km',
      amount: 95000,
      items: ['Cesar Roll - 65000', 'Americano Coffee - 30000'],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 30)),
    ),
    Order(
      id: 'ORD-007',
      customerName: 'Bekzod Nurmatov',
      customerPhone: '+998 93 789 01 23',
      address: 'Shayxontohur 12-uy',
      distance: '6.3 km',
      amount: 312000,
      items: ['Lagman - 120000', 'Manti (6 dona) - 150000', 'Choy - 42000'],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
    ),
    Order(
      id: 'ORD-008',
      customerName: 'Nilufar Abdullaeva',
      customerPhone: '+998 94 890 12 34',
      address: 'Mirobod 3-tor ko\'cha, 7-uy',
      distance: '0.9 km',
      amount: 45000,
      items: ['Hot Dog - 25000', 'Coffee Latte - 20000'],
      status: OrderStatusType.READY_TO_PICKUP,
      orderTime: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    Order(
      id: 'ORD-009',
      customerName: 'Rustam Qodirov',
      customerPhone: '+998 91 901 23 45',
      address: 'Yunusobod 9-mavze, 34-uy',
      distance: '8.2 km',
      amount: 234000,
      items: ['Plov - 120000', 'Shashlik - 80000', 'Salat - 34000'],
      status: OrderStatusType.PREPARING,
      orderTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
    ),
    Order(
      id: 'ORD-010',
      customerName: 'Zarina Usmonova',
      customerPhone: '+998 93 012 34 56',
      address: 'Chilonzor 5-kvartal, 89-uy',
      distance: '3.1 km',
      amount: 189000,
      items: ['Sushi Roll - 150000', 'Miso Soup - 39000'],
      status: OrderStatusType.READY_TO_PICKUP,
      orderTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController!,
      curve: Curves.easeOut,
    );
    _animController!.forward();
  }

  @override
  void dispose() {
    _animController?.dispose();
    _autoHideTimer?.cancel();
    super.dispose();
  }

  void _openPanel() {
    _autoHideTimer?.cancel();
    setState(() {
      _isGross = true;
    });
    if (_isOnline) {
      _startAutoHideTimer();
    }
  }

  void _startAutoHideTimer() {
    _autoHideTimer?.cancel();
    _autoHideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _isOnline && _isGross) {
        setState(() {
          _isGross = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_fadeAnim == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final Size size = MediaQuery.of(context).size;
    final double maxDrag = size.width - 32 - _buttonWidth;

    return Container(
      color: const Color(0xFFF7F8FC),
      child: Stack(
        children: [
          // ── Asosiy kontent ──
          Column(
            children: [
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  "Buyurtmalar",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim!,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildDualColumnLayout(),
                  ),
                ),
              ),
            ],
          ),

          // ── Offline tugmasi (yuqori chap) ──
          if (_isOnline && !_isGross)
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _autoHideTimer?.cancel();
                  setState(() {
                    _isOnline = false;
                    _isGross = true;
                    _dragPosition = 0;
                  });
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.blueGrey, Colors.blueGrey.shade400],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 9, right: 11, top: 7.5, bottom: 15),
                    child: Icon(Icons.power_settings_new,
                        color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration:  Duration(milliseconds: 350),


              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                // Pastdan yuqoriga siljib chiqadi / yuqoridan pastga ketadi
                final slide = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: slide,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _isGross
                  ? _buildFullPanel(size, maxDrag)
                  : _buildMiniPanel(size),
            ),
          ),
        ],
      ),
    );
  }

  // ── To'liq panel (slider bilan) ──
  Widget _buildFullPanel(Size size, double maxDrag) {
    return Container(
      key: const ValueKey('full'),
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isOnline
                ? [
              Colors.blueGrey.withValues(alpha: 0.4),
              Colors.blueGrey.shade300,
            ]
                : [
              const Color(0xFF1BC261),
              const Color(0xFF4CD97B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Markazdagi matnlar
            Center(
              child: Opacity(
                opacity: (1 - (_dragPosition / maxDrag)).clamp(0.0, 1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isOnline ? 'Onlayn' : 'Oflayn',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      _isOnline ? 'Liniyadan chiqish' : 'Liniyaga chiqish',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Suriladigan tugma
            AnimatedPositioned(
              duration: Duration.zero,
              left: _dragPosition + 4,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragPosition += details.delta.dx;
                    if (_dragPosition < 0) _dragPosition = 0;
                    if (_dragPosition > maxDrag) _dragPosition = maxDrag;
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (_dragPosition > maxDrag * 0.8) {
                    setState(() {
                      _dragPosition = maxDrag;
                      _isOnline = true;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      if (mounted && _isOnline && _isGross) {
                        setState(() {
                          _isGross = false;
                        });
                      }
                    });
                  } else {
                    setState(() {
                      _dragPosition = 0;
                      _isOnline = false;
                    });
                    _autoHideTimer?.cancel();
                  }
                },
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isOnline ? Icons.power_settings_new : Icons.arrow_forward,
                    color:
                    _isOnline ? Colors.red : const Color(0xFF1BC261),
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Mini panel (faqat chiziq) ──
  Widget _buildMiniPanel(Size size) {
    return GestureDetector(
      key: const ValueKey('mini'),
      onTap: _openPanel,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: size.width,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDualColumnLayout() {
    final preparingOrders =
    orders.where((o) => o.status == OrderStatusType.PREPARING).toList();
    final readyOrders = orders
        .where((o) => o.status == OrderStatusType.READY_TO_PICKUP)
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: _buildStatusColumn(
              status: OrderStatusType.PREPARING,
              orders: preparingOrders,
              onOrderTap: _showOrderDetail,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: _buildStatusColumn(
              status: OrderStatusType.READY_TO_PICKUP,
              orders: readyOrders,
              onOrderTap: _showOrderDetail,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusColumn({
    required OrderStatusType status,
    required List<Order> orders,
    required Function(Order) onOrderTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [status.color, status.color.withValues(alpha: 0.8)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(status.icon, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      status.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${orders.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined,
                      size: 32, color: Colors.grey.shade300),
                  const SizedBox(height: 4),
                  Text(
                    "Bo'sh",
                    style: TextStyle(
                        color: Colors.grey.shade400, fontSize: 11),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(
                  order: orders[index],
                  currentStatus: status,
                  onTap: onOrderTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required Order order,
    required OrderStatusType currentStatus,
    required Function(Order) onTap,
  }) {
    final statusColor = currentStatus.color;

    return GestureDetector(
      onTap: () => onTap(order),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: statusColor, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getStatusIcon(order.status),
                    size: 16, color: statusColor.withValues(alpha: 0.9)),
                const SizedBox(width: 6),
                Text(
                  order.id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_formatPrice(order.amount)} so\'m',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: statusColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 12, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.address,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Icon(Icons.directions_walk,
                    size: 12, color: statusColor.withValues(alpha: 0.7)),
                const SizedBox(width: 4),
                Text(
                  order.distance,
                  style: TextStyle(
                      fontSize: 10,
                      color: statusColor,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Icon(Icons.access_time,
                    size: 11, color: Colors.grey.shade400),
                const SizedBox(width: 3),
                Text(
                  _formatTimeAgo(order.orderTime),
                  style:
                  TextStyle(fontSize: 9, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]} ',
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} daq';
    if (diff.inHours < 24) return '${diff.inHours} soat';
    return '${diff.inDays} kun';
  }

  IconData _getStatusIcon(OrderStatusType status) {
    switch (status) {
      case OrderStatusType.PENDING:
        return Icons.pending_actions;
      case OrderStatusType.PREPARING:
        return Icons.kitchen;
      case OrderStatusType.READY_TO_PICKUP:
        return Icons.inventory_2;
      case OrderStatusType.ACCEPTED:
        return Icons.check_circle;
      case OrderStatusType.ON_THE_WAY:
        return Icons.delivery_dining;
    }
  }

  void _acceptOrder(Order order) {
    setState(() {
      final index = orders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        orders[index].status = OrderStatusType.ACCEPTED;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${order.id} qabul qilindi!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showOrderDetail(Order order) {
    showDialog(
      context: context,
      builder: (ctx) => OrderDetailDialog(
        order: order,
        onAccept: order.status == OrderStatusType.READY_TO_PICKUP
            ? () {
          _acceptOrder(order);
          Navigator.of(ctx).pop();
        }
            : null,
        formatPrice: _formatPrice,
      ),
    );
  }
}

// ─── Dialog ──────────────────────────────────────────────────
class OrderDetailDialog extends StatelessWidget {
  final Order order;
  final VoidCallback? onAccept;
  final String Function(int) formatPrice;

  const OrderDetailDialog({
    super.key,
    required this.order,
    required this.onAccept,
    required this.formatPrice,
  });

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final status = order.status;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        width: 420,
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [status.color, status.color.withValues(alpha: 0.75)],
                ),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  Icon(status.icon, color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buyurtma #${order.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          status.title,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Mijoz ma\'lumotlari', status.color),
                    const SizedBox(height: 10),
                    _infoRow(Icons.person_outline, order.customerName,
                        'Ism Familiya'),
                    _infoRow(
                        Icons.phone_outlined, order.customerPhone, 'Telefon'),
                    _infoRow(
                        Icons.location_on_outlined, order.address, 'Manzil'),
                    _infoRow(Icons.directions_walk, order.distance, 'Masofa'),
                    _infoRow(Icons.access_time, _formatDate(order.orderTime),
                        'Buyurtma vaqti'),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: status.color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jami summa',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${formatPrice(order.amount)} so\'m',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: status.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (onAccept != null)
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(Icons.check_circle_outline,
                        color: Colors.white),
                    label: const Text(
                      'Qabul qilish',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget _infoRow(IconData icon, String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey.shade500)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Model ───────────────────────────────────────────────────
class Order {
  final String id;
  final String customerName;
  final String customerPhone;
  final String address;
  final String distance;
  final int amount;
  final List<String> items;
  OrderStatusType status;
  final DateTime orderTime;

  Order({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.distance,
    required this.amount,
    required this.items,
    required this.status,
    required this.orderTime,
  });
}

enum OrderStatusType {
  PENDING,
  PREPARING,
  READY_TO_PICKUP,
  ACCEPTED,
  ON_THE_WAY;

  String get title {
    switch (this) {
      case OrderStatusType.PENDING:
        return 'Yangi';
      case OrderStatusType.PREPARING:
        return 'Tayyorlanmoqda';
      case OrderStatusType.READY_TO_PICKUP:
        return 'Tayyor';
      case OrderStatusType.ACCEPTED:
        return 'Qabul qilindi';
      case OrderStatusType.ON_THE_WAY:
        return 'Yo\'lda';
    }
  }

  IconData get icon {
    switch (this) {
      case OrderStatusType.PENDING:
        return Icons.pending_actions;
      case OrderStatusType.PREPARING:
        return Icons.kitchen;
      case OrderStatusType.READY_TO_PICKUP:
        return Icons.inventory_2;
      case OrderStatusType.ACCEPTED:
        return Icons.check_circle;
      case OrderStatusType.ON_THE_WAY:
        return Icons.delivery_dining;
    }
  }

  Color get color {
    switch (this) {
      case OrderStatusType.PENDING:
        return const Color(0xFFF59E0B);
      case OrderStatusType.PREPARING:
        return const Color(0xFF4DB5FF);
      case OrderStatusType.READY_TO_PICKUP:
        return const Color(0xFF1BC261);
      case OrderStatusType.ACCEPTED:
        return const Color(0xFF3B82F6);
      case OrderStatusType.ON_THE_WAY:
        return const Color(0xFFEC4899);
    }
  }
}