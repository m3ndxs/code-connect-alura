import 'dart:io';

import 'package:code_connect_app/features/publish/data/models/publish_request_model.dart';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PublishProvider extends ChangeNotifier {
  // Dependencias
  final PublishRepository repository;

  PublishProvider(this.repository);

  // Estados da tela
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Post? _post;
  Post? get post => _post;

  // Tags
  final List<String> _tags = [];
  List<String> get tags => List.unmodifiable(_tags);

  String? _selectedTag;
  String? get selectedTag => _selectedTag;

  void addTag(String value) {
    final tag = value.trim();

    if (tag.isEmpty) return;

    if (_tags.contains(tag)) return;

    _tags.add(tag);

    notifyListeners();
  }

  void removeTags(String tag) {
    _tags.remove(tag);

    notifyListeners();
  }

  void clearTags() {
    _tags.clear();

    notifyListeners();
  }

  void selectTag(String tag) {
    if (_selectedTag == tag) {
      _selectedTag = null;
    } else {
      _selectedTag = tag;
    }

    notifyListeners();
  }

  // Publicar Posts
  Future<void> publish({
    required String title,
    required String body,
    required String markdown,
    required File image,
  }) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      final request = PublishRequestModel(
        title: title,
        body: body,
        markdown: markdown,
        image: image,
      );

      _post = await repository.publish(request);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Upload Image
  File? selectedImage;

  Future<void> pickImage() async {
    print('Entrou no pickImage');

    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    selectedImage = File(image.path);

    notifyListeners();
  }

  void removeImage() {
    selectedImage = null;
    notifyListeners();
  }
}
