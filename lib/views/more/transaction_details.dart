import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? data;

  const TransactionDetailsScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passed =
        data ?? GoRouterState.of(context).extra as Map<String, dynamic>?;
    // Fallback if no extra passed
    final tx = passed ??
        {
          'id': '#TRX-0000',
          'title': 'Payment Hold',
          'amount': '-\$65',
          'date': 'Aug 15, 2025 at 11:30 AM',
          'status': 'Pending',
          'to': 'Joseph Fubara',
          'description':
              'Payment hold for Trip planner service to Joseph Fubara',
          'method': 'Escrow',
        };

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: Color(0xFF111827)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        tx['amount'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tx['title'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tx['date'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // status pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: tx['status'] == 'Pending'
                              ? const Color(0xFFFFF7ED)
                              : const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          tx['status'] ?? '',
                          style: TextStyle(
                            color: tx['status'] == 'Pending'
                                ? const Color(0xFFF97316)
                                : const Color(0xFF059669),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // details list
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      const Text('To',
                          style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFFF3F4F6)),
                          const SizedBox(width: 12),
                          Text(
                            tx['to'] ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF111827)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),
                      const Text('Description',
                          style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(tx['description'] ?? '',
                          style: const TextStyle(color: Color(0xFF111827))),

                      const SizedBox(height: 14),
                      const Text('Payment Method',
                          style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(tx['method'] ?? '',
                          style: const TextStyle(color: Color(0xFF111827))),

                      const SizedBox(height: 14),
                      const Text('Transaction ID',
                          style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(tx['id'] ?? '#TRX-0000',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Transaction ID copied')));
                            },
                            child: const Icon(Icons.copy,
                                size: 18, color: Color(0xFF2563EB)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // Report button
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Report Transaction')));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFFFEE2E2)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.flag_outlined,
                                    color: Color(0xFFEF4444)),
                                SizedBox(width: 8),
                                Text('Report Transaction',
                                    style: TextStyle(
                                        color: Color(0xFFEF4444),
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
