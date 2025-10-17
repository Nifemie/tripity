import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Payment Method Item Model
class PaymentMethodItem {
  final String id;
  final String title;
  final String subtitle;
  final String iconPath;

  PaymentMethodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });
}

/// Payment Method Selection Widget
class PaymentMethodSelector extends StatefulWidget {
  final String? selectedMethodId;
  final Function(String)? onMethodSelected;
  final VoidCallback? onAddPaymentMethod;

  const PaymentMethodSelector({
    Key? key,
    this.selectedMethodId,
    this.onMethodSelected,
    this.onAddPaymentMethod,
  }) : super(key: key);

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String? _selectedMethodId;

  @override
  void initState() {
    super.initState();
    _selectedMethodId = widget.selectedMethodId;
  }

  final List<PaymentMethodItem> _paymentMethods = [
    PaymentMethodItem(
      id: 'wallet',
      title: 'Tripify Wallet',
      subtitle: '\$150.00 available',
      iconPath: 'assets/images/Trips/Wallet_Money.svg',
    ),
    PaymentMethodItem(
      id: 'online',
      title: 'Pay Online',
      subtitle: 'Paypal, Paystack',
      iconPath: 'assets/images/Trips/Global.svg',
    ),
    PaymentMethodItem(
      id: 'debit',
      title: 'Debit Card',
      subtitle: '**** **** **** 1234',
      iconPath: 'assets/images/Trips/Card.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Method',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontFamily: 'Instrument Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              GestureDetector(
                onTap: widget.onAddPaymentMethod,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Payment Method List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _paymentMethods.length,
          itemBuilder: (context, index) {
            final method = _paymentMethods[index];
            final isSelected = _selectedMethodId == method.id;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PaymentMethodCard(
                method: method,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedMethodId = method.id;
                  });
                  widget.onMethodSelected?.call(method.id);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Individual Payment Method Card
class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodItem method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    Key? key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F9FF) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  method.iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF374151),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    method.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Checkmark
            if (isSelected)
              SvgPicture.asset(
                'assets/images/Trips/blue_Check_Circle.svg',
                width: 24,
                height: 24,
              ),
          ],
        ),
      ),
    );
  }
}

// Example Usage
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedMethod = 'wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Payment'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PaymentMethodSelector(
              selectedMethodId: selectedMethod,
              onMethodSelected: (methodId) {
                setState(() {
                  selectedMethod = methodId;
                });
                print('Selected payment method: $methodId');
              },
              onAddPaymentMethod: () {
                print('Add new payment method');
                // Navigate to add payment method screen
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}