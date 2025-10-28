import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/Bookings_widget/cart_item_widget.dart';

// ==================== CART PROVIDER ====================

final cartItemsProvider = StateProvider<List<CartItem>>((ref) {
  return [
    CartItem(
      id: '1',
      title: 'Paris Walking Tour',
      description: 'Explore the artistic heart of Paris with a local guide',
      imageUrl: 'assets/images/Bookings/experience/paris_walking.png',
      category: 'Experience',
      location: 'Paris, France',
      duration: '2.5 hours',
      type: 'Tourism',
      price: 45.0,
    ),
  ];
});

// ==================== CART PAGE ====================

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartItemsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                _showEmptyCartDialog(context, ref);
              },
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: const Color(0xFFF3F4F6),
                ),
                child: const Center(
                  child: Text(
                    'Empty Cart',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111827),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Main Content - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Cart Items
                  if (cartItems.isEmpty)
                    _buildEmptyCartView()
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      separatorBuilder:
                          (context, index) => Container(
                            height: 8,
                            color: const Color(0xFFF3F4F6),
                          ),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemWidget(
                          item: item,
                          onClearSelection: () {
                            _clearSingleItem(ref, item.id);
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          // Bottom Button (Footer) - Always at bottom
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border(
                  top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                ),
              ),
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    _continueToBooking(context);
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      gradient: const LinearGradient(
                        begin: Alignment(-0.0421, -1.0),
                        end: Alignment(1.0712, 1.0),
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF2563EB),
                          Color(0xFF1E40AF),
                        ],
                        stops: [0.0, 0.5145, 1.0],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue to Booking',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Empty Cart View
  Widget _buildEmptyCartView() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: const Color(0xFFE5E7EB),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add experiences to your cart to get started',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Show Empty Cart Confirmation Dialog
  void _showEmptyCartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Empty Cart',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          content: const Text(
            'Are you sure you want to remove all items from your cart?',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(cartItemsProvider.notifier).state = [];
                Navigator.of(context).pop();
              },
              child: const Text(
                'Empty Cart',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Clear Single Item
  void _clearSingleItem(WidgetRef ref, String itemId) {
    final currentCart = ref.read(cartItemsProvider);
    ref.read(cartItemsProvider.notifier).state =
        currentCart.where((item) => item.id != itemId).toList();
  }

  // Continue to Booking
  void _continueToBooking(BuildContext context) {
    // Navigate to booking details page
    context.push('/booking-details');
  }
}
