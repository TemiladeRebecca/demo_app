import 'package:flutter/material.dart';

// Shared gradient for underline
const LinearGradient tabGradient = LinearGradient(
  colors: [Colors.blue, Colors.purple],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class ToggleTabs extends StatefulWidget {
  const ToggleTabs({super.key, required this.width});

  final double width;

  @override
  State<ToggleTabs> createState() => _ToggleTabsState();
}

class _ToggleTabsState extends State<ToggleTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface.withOpacity(0.6);

    Widget buildTabText(String text, int index) {
      final isSelected = _selectedTab == index;

      return GestureDetector(
        onTap: () {
          setState(() => _selectedTab = index);
        },
        child: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected
                ? theme
                      .colorScheme
                      .onSurface // highlight with theme color
                : defaultColor,
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabText("Smart Script", 0),
            buildTabText("Advanced Script", 1),
          ],
        ),
        SizedBox(height: 6),
        Stack(
          children: [
            const Divider(thickness: 1, height: 10),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: _selectedTab == 0 ? 0 : widget.width / 2,
              child: Container(
                width: widget.width / 2,
                height: 3,
                decoration: const BoxDecoration(gradient: tabGradient),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
