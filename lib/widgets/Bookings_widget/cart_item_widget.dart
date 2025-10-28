import 'package:flutter/material.dart';

// ==================== CART ITEM MODEL ====================

class CartItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String location;
  final String duration;
  final String type;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.location,
    required this.duration,
    required this.type,
    required this.price,
  });
}

// ==================== CART ITEM WIDGET ====================

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onClearSelection;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onClearSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Content Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title, Description, and Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        color: const Color(0xFFDBEAFE),
                      ),
                      child: Text(
                        item.category,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2563EB),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Details Row (aligned to the left)
          Row(
            children: [
              // Location
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Text(
                item.location,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 8),

              // Vertical Divider
              Container(width: 1, height: 12, color: const Color(0xFFE5E7EB)),
              const SizedBox(width: 8),

              // Duration
              Icon(Icons.access_time, size: 16, color: const Color(0xFF6B7280)),
              const SizedBox(width: 4),
              Text(
                item.duration,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 8),

              // Vertical Divider
              Container(width: 1, height: 12, color: const Color(0xFFE5E7EB)),
              const SizedBox(width: 8),

              // Type
              Icon(
                Icons.group_outlined,
                size: 16,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Text(
                item.type,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Price and Clear Selection Row (aligned to the left)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price
              Text(
                '\$${item.price.toStringAsFixed(0)}/person',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),

              // Clear Selection
              GestureDetector(
                onTap: onClearSelection,
                child: const Text(
                  'Clear Selection',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2563EB),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
