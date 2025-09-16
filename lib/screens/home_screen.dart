import 'package:flutter/material.dart';
import 'package:my_app/custom/base_screen.dart';
import 'package:my_app/custom/button.dart';
import 'package:my_app/data/sample_image.dart';
import 'package:my_app/widgets/image_item.dart';
import 'package:my_app/widgets/toggle_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onThemeChanged});

  final void Function(ThemeMode) onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeMode _currentMode = ThemeMode.system;
  final List<ImageItem> items = sampleImages;
  String? selectedId;
  final TextEditingController _descriptionController = TextEditingController();

  void _handleToggle() {
    setState(() {
      if (_currentMode == ThemeMode.light) {
        _currentMode = ThemeMode.dark;
      } else {
        _currentMode = ThemeMode.light;
      }
      widget.onThemeChanged(_currentMode);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseScreen(
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
            onPressed: _handleToggle,
            icon: Icon(
              _currentMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleTabs(width: width),
              const SizedBox(height: 16),
              Text(
                'What type of posters do you want to create?',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),

              // Image selector
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = selectedId == item.id;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedId = item.id;
                        });
                      },
                      child: AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.outline.withOpacity(0.1),
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                // The image
                                Positioned.fill(
                                  child: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // Gradient + Text at bottom center
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.2),
                                          Colors.black.withOpacity(0.8),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              // Description box
              if (selectedId != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.surfaceVariant,
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Add description...",
                          border: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Upload image tapped"),
                              ),
                            );
                          },
                          icon: const Icon(Icons.image, size: 28),
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Settings',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20),
              // Size & Category box
              Container(
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.surfaceVariant,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Size"),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Text("1080 X 1920 px"),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      thickness: 0.5,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),),

                    // Second row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Category"),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Text("Foods and beverage"),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Generate button
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CustomButton(
                  text: 'Generate',
                  isAsset: false,
                  imagePath:
                      'https://cdn.pixabay.com/photo/2015/05/22/19/01/business-779542_640.jpg',
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
