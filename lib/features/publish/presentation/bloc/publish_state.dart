part of 'publish_bloc.dart';

enum PublishStatus { initial, loading, success, failure }

class PublishState extends Equatable {
  final List<String> tags;
  final String? selectedTag;
  final File? selectedImage;
  final PublishStatus status;
  final Post? post;
  final String? errorMessage;

  const PublishState({
    this.tags = const [],
    this.selectedTag,
    this.selectedImage,
    this.status = PublishStatus.initial,
    this.post,
    this.errorMessage,
  });

  PublishState copyWith({
    List<String>? tags,
    String? selectedTag,
    bool clearSelectedTag = false,
    File? selectedImage,
    bool clearSelectedImage = false,
    PublishStatus? status,
    Post? post,
    String? errorMessage,
  }) {
    return PublishState(
      tags: tags ?? this.tags,
      selectedTag: clearSelectedTag ? null : (selectedTag ?? this.selectedTag),
      selectedImage: clearSelectedImage
          ? null
          : (selectedImage ?? this.selectedImage),
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    tags,
    selectedTag,
    selectedImage,
    status,
    post,
    errorMessage,
  ];
}
