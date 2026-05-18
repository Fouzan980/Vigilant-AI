import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/category_dropdown.dart';
import '../../../shared/widgets/media_picker_row.dart';
import '../../../core/db/report_entity.dart';
import '../../../core/api/api_client.dart';
import '../../../shared/providers/pipeline_providers.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  String _audience = 'Public';
  String? _category;
  String _severity = 'Medium';
  bool _isAnonymous = false;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedImages.add(File(video.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submitReport() async {
    if (_descController.text.trim().isEmpty && _selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a description or an image.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final reportData = {
        'description': _descController.text.trim(),
        'category': _category ?? 'Other',
        'severity': _severity,
        'audience': _audience,
        'isAnonymous': _isAnonymous,
        'createdAt': DateTime.now().toIso8601String(),
      };

      bool isSynced = false;
      final reportPipeline = ref.read(reportPipelineProvider);
      try {
        await reportPipeline.add({
          ...reportData,
          'status': 'open',
          'location': 'Unknown location',
        });
        isSynced = true;
      } catch (e) {
        debugPrint('Firestore error while saving report: $e');
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.submitReport(reportData);
        if (response.statusCode == 201 || response.statusCode == 200) {
          isSynced = true;
        }
      } catch (e) {
        debugPrint('Network fallback not available: $e');
      }

      final entity = ReportEntity()
        ..description = reportData['description'] as String
        ..category = reportData['category'] as String
        ..severity = reportData['severity'] as String
        ..createdAt = DateTime.now()
        ..isSynced = isSynced;

      await LocalDB.saveReport(entity);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isSynced
                ? 'Report sent to Firestore and API.'
                : 'Saved offline. Will sync when online.',
          ),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('New Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Section
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: const Text(
                            'TU',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isAnonymous ? 'Anonymous User' : 'Test User',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            ActionChip(
                              avatar: const Icon(Icons.location_on, size: 16),
                              label: const Text(
                                'Downtown',
                                style: TextStyle(fontSize: 12),
                              ),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Audience
                    Wrap(
                      spacing: 8,
                      children:
                          [
                            'Public',
                            'Neighborhood Only',
                            'Authorities Only',
                          ].map((String choice) {
                            return FilterChip(
                              label: Text(choice),
                              selected: _audience == choice,
                              onSelected: (bool selected) {
                                if (selected) {
                                  setState(() => _audience = choice);
                                }
                              },
                              selectedColor: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(51),
                              checkmarkColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            );
                          }).toList(),
                    ),
                    const Divider(height: 32),

                    // Text Area
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        hintText: "What's happening in your neighborhood?",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                      minLines: 4,
                      maxLines: 8,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 32),

                    // Category
                    Text(
                      'Incident Type',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    CategoryDropdown(
                      selectedCategory: _category,
                      onChanged: (val) => setState(() => _category = val),
                    ),
                    const SizedBox(height: 16),

                    // Severity
                    Text(
                      'How serious',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'Low',
                          label: Text(
                            'Low',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        ButtonSegment(
                          value: 'Medium',
                          label: Text(
                            'Medium',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        ButtonSegment(
                          value: 'Critical',
                          label: Text(
                            'Critical',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      selected: {_severity},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() => _severity = newSelection.first);
                      },
                    ),
                    const Divider(height: 32),

                    // Media Previews
                    if (_selectedImages.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(
                                          _selectedImages[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 12,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                    // Media Action Bar
                    MediaPickerRow(
                      onPhotoPressed: _pickImage,
                      onVideoPressed: _pickVideo,
                      onLocationPressed: () {},
                      onTagPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Anonymous Toggle
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.visibility_off, color: Colors.grey),
                    const SizedBox(width: 16),
                    const Expanded(child: Text('Post anonymously')),
                    Switch(
                      value: _isAnonymous,
                      onChanged: (val) => setState(() => _isAnonymous = val),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: _isSubmitting ? null : _submitReport,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Report'),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Sent to local authorities and community feed.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
