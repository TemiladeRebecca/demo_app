import 'package:flutter/material.dart';

// Define the gradient (shared between text + underline)
const LinearGradient tabGradient = LinearGradient(
  colors: [Colors.blue, Colors.purple],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class ToggleTabs extends StatefulWidget {
  const ToggleTabs({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<ToggleTabs> createState() => _ToggleTabsState();
}

class _ToggleTabsState extends State<ToggleTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface; // fallback to theme text

    Widget buildTabText(String text, int index) {
      final isSelected = _selectedTab == index;

      final textWidget = Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: isSelected ? null : defaultColor, // null -> overridden by ShaderMask
        ),
      );

      // If selected, wrap with ShaderMask for gradient
      return GestureDetector(
        onTap: () {
          setState(() => _selectedTab = index);
        },
        child: isSelected
            ? ShaderMask(
                shaderCallback: (bounds) =>
                    tabGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                blendMode: BlendMode.srcIn,
                child: textWidget,
              )
            : textWidget,
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
        Stack(
          children: [
            const Divider(thickness: 1, height: 20),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              left: _selectedTab == 0 ? 0 : widget.width / 2,
              child: Container(
                width: widget.width / 2,
                height: 3,
                decoration: const BoxDecoration(
                  gradient: tabGradient,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
