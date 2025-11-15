import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  // Sample transactions
  List<Map<String, dynamic>> get _transactions => [
        {
          'id': '#TRX-982134',
          'title': 'Payment Hold',
          'subtitle': 'Payment hold for Trip planner service t...',
          'amount': '-\$65',
          'date': 'Aug 15, 11:30 AM',
          'status': 'Pending',
          'to': 'Joseph Fubara',
          'description':
              'Payment hold for Trip planner service to Joseph Fubara',
          'method': 'Escrow',
        },
        {
          'id': '#TRX-982133',
          'title': 'Premium Subscription',
          'subtitle': 'Premium subscription service for Trip...',
          'amount': '-\$29.99',
          'date': 'Aug 12, 04:45 PM',
          'status': 'Completed',
          'to': 'Triptify',
          'description': 'Premium subscription service for Triptify',
          'method': 'Credit Card',
        },
        {
          'id': '#TRX-982132',
          'title': 'Trip Planner Service - Joseph Fu...',
          'subtitle': 'Payment released for Trip planner servi...',
          'amount': '-\$65',
          'date': 'Aug 3, 03:15 PM',
          'status': 'Completed',
          'to': 'Joseph Fubara',
          'description': 'Payment released for Trip planner service',
          'method': 'Escrow',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'RECENT TRANSACTIONS',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade200)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _transactions.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 2, color: Colors.grey.shade200),
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return _TransactionItem(
                      transaction: transaction,
                      onTap: () => context.push('/transaction-details',
                          extra: transaction),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Transaction Item Widget
class _TransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const _TransactionItem({
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = transaction['status'] == 'Pending';
    final statusColor =
        isPending ? const Color(0xFFF97316) : const Color(0xFF10B981);
    final amountColor = isPending ? const Color(0xFFF97316) : Colors.red;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Indicator
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['title'],
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction['subtitle'],
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction['date'],
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction['amount'],
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isPending
                        ? const Color(0xFFFFF7ED)
                        : const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    transaction['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
