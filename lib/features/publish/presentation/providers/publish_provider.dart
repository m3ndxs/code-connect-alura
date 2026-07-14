import 'package:flutter/material.dart';

class PublishProvider extends ChangeNotifier {
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
}
