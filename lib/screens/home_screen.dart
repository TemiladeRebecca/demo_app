import 'package:flutter/material.dart';
import 'package:my_app/custom/base_screen.dart';
import 'package:my_app/data/sample_image.dart';
import 'package:my_app/widgets/image_item.dart';
import 'package:my_app/widgets/toggle_tab.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key, required this.onThemeChanged});

  final void Function(ThemeMode) onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeMode _currentMode = ThemeMode.system;
  final List<ImageItem> items = sampleImages;
  String? selectedId;
  String? selectedDescription;
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
    return BaseScreen(
      scrollable: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      appBar: AppBar(
        title: const Text('Demo'),
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
            children: [
              ToggleTabs(
                width: width,
              ),
              Text(
                'What type of posters do you want to create?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.start,
              ),
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
                        selectedDescription = item.description;
                      });
                    },
                    child: AnimatedScale(
                      scale: isSelected ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.all(8),
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        
            // Description box
            if (selectedId != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Add description...",
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(48, 16, 16, 16),
                      ),
                    ),
        
                    // Image upload button (bottom-left)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: IconButton(
                        onPressed: () {
                          // 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Upload image tapped"),
                            ),
                          );
                        },
                        icon: const Icon(Icons.image, size: 28),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
