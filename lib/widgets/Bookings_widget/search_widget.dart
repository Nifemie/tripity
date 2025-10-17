import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Provider to manage search query state
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider to track if search is focused
final searchFocusProvider = StateProvider<bool>((ref) => false);

class BookingSearchBar extends ConsumerStatefulWidget {
  final String hintText;
  final VoidCallback? onVoiceSearch;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const BookingSearchBar({
    Key? key,
    this.hintText = 'Search flights, stays, experiences & more',
    this.onVoiceSearch,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  ConsumerState<BookingSearchBar> createState() => _BookingSearchBarState();
}

class _BookingSearchBarState extends ConsumerState<BookingSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen to focus changes
    _focusNode.addListener(() {
      ref.read(searchFocusProvider.notifier).state = _focusNode.hasFocus;
    });

    // Listen to text changes
    _controller.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _controller.text;
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFF0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Search Icon
          Icon(
            Icons.search,
            size: 24,
            color: const Color(0xFF8E8E93),
          ),

          const SizedBox(width: 12),

          // Search Input Field
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onTap: widget.onTap,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Color(0xFF000000),
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFF8E8E93),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),

          const SizedBox(width: 12),

          // Microphone Icon
          GestureDetector(
            onTap: widget.onVoiceSearch ?? _handleVoiceSearch,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.mic_none,
                size: 24,
                color: const Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleVoiceSearch() {
    // Default voice search handler
    print('Voice search triggered');
    // You can implement voice recognition here
  }
}



class ResponsiveSearchBar extends ConsumerWidget {
  const ResponsiveSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: _getResponsivePadding(context),
      child: BookingSearchBar(
        onChanged: (value) {
          // Handle search query changes
          print('Search query: $value');
        },
        onVoiceSearch: () {
          // Handle voice search
          print('Voice search activated');
        },
        onTap: () {
          // Navigate to search page or show search modal
          print('Search bar tapped');
        },
      ),
    );
  }

  EdgeInsets _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1200) {
      // Desktop
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 8);
    } else if (width > 600) {
      // Tablet
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 8);
    } else {
      // Mobile
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }
}



class SearchBarExample extends ConsumerWidget {
  const SearchBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final isFocused = ref.watch(searchFocusProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booking',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.shopping_cart_outlined),
                ],
              ),
            ),

            // Search Bar
            const ResponsiveSearchBar(),

            // Show search results or recent searches
            if (searchQuery.isNotEmpty)
              Expanded(
                child: Center(
                  child: Text('Searching for: $searchQuery'),
                ),
              )
            else if (isFocused)
              Expanded(
                child: Center(
                  child: Text('Recent Searches'),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text('Start searching...'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



class ReadOnlySearchBar extends ConsumerWidget {
  final VoidCallback onTap;

  const ReadOnlySearchBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 600),
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFF0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 24,
              color: const Color(0xFF8E8E93),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Search flights, stays, experiences & more',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFF8E8E93),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.mic_none,
              size: 24,
              color: const Color(0xFF000000),
            ),
          ],
        ),
      ),
    );
  }
}