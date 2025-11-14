import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/more_widgets/transactions/transaction_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  // Sample transactions
  List<Map<String, dynamic>> get _transactions => [
        {
          'id': 'trx_1',
          'title': 'Payment Hold',
          'subtitle': 'Payment hold for Trip planner service to Joseph Fubara',
          'amount': '-\$65',
          'date': 'Aug 15, 11:30 AM',
          'status': 'Pending',
        },
        {
          'id': 'trx_2',
          'title': 'Premium Subscription',
          'subtitle': 'Premium subscription service for Tripitify',
          'amount': '-\$29.99',
          'date': 'Aug 12, 04:45 PM',
          'status': 'Completed',
        },
        {
          'id': 'trx_3',
          'title': 'Trip Planner Service - Joseph Fu...',
          'subtitle': 'Payment released for Trip planner service',
          'amount': '-\$65',
          'date': 'Aug 3, 03:15 PM',
          'status': 'Completed',
        },
      ];

  @override
  Widget build(BuildContext context) {
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
                    'Transactions',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'RECENT TRANSACTIONS',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: _transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final t = _transactions[index];
                    final statusColor = t['status'] == 'Pending'
                        ? const Color(0xFFF97316)
                        : const Color(0xFF10B981);

                    return TransactionItem(
                      title: t['title'],
                      subtitle: t['subtitle'],
                      amount: t['amount'],
                      date: t['date'],
                      status: t['status'],
                      statusColor: statusColor,
                      onTap: () =>
                          context.push('/transaction-details', extra: t),
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
