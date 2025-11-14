import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/models/home_screen/location_state.dart';
import '../../controllers/home_controller.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(homeControllerProvider).locationState;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Location Section
        Flexible(
          child: GestureDetector(
            onTap: () =>
                ref.read(homeControllerProvider.notifier).refreshLocation(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 4),
                locationState.isLoading
                    ? const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      )
                    : Flexible(
                        child: Text(
                          locationState.location,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        // Right side: Notification and Traveller
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Notification Icon - Updated to use SVG
            GestureDetector(
              onTap: () {
                context.push('/notifications');
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: const Color(0xFFF3F4F6),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Home/Bell_notification.svg',
                    // Replace with your SVG file path
                    width: 24, // Adjust icon size as needed
                    height: 24,
                    // You can add color if needed:
                    // colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),
            // Add some spacing between notification and traveller

            // Traveller Box
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                color: const Color(0xFFF3F4F6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Traveller",
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
