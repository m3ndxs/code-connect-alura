import 'dart:io';
import 'package:code_connect_app/features/publish/domain/entities/post.dart';
import 'package:code_connect_app/features/publish/domain/usecase/post_publish_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'publish_event.dart';
part 'publish_state.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  final PostPublishUseCase postPublishUseCase;
  final ImagePicker _imagePicker;

  PublishBloc({
    required this.postPublishUseCase,
    ImagePicker? imagePicker,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        super(const PublishState()) {
    on<AddTagEvent>(_onAddTag);
    on<RemoveTagEvent>(_onRemoveTag);
    on<SelectTagEvent>(_onSelectTag);
    on<ClearTagsEvent>(_onClearTags);
    on<PickImageEvent>(_onPickImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<PublishSubmittedEvent>(_onPublishSubmitted);
  }

  void _onAddTag(AddTagEvent event, Emitter<PublishState> emit) {
    if (event.tag.trim().isEmpty) return;
    if (state.tags.contains(event.tag.trim())) return;
    emit(state.copyWith(tags: [...state.tags, event.tag.trim()]));
  }

  void _onRemoveTag(RemoveTagEvent event, Emitter<PublishState> emit) {
    emit(
      state.copyWith(
        tags: state.tags.where((t) => t != event.tag).toList(),
        clearSelectedTag: state.selectedTag == event.tag,
      ),
    );
  }

  void _onSelectTag(SelectTagEvent event, Emitter<PublishState> emit) {
    final newSelected = state.selectedTag == event.tag ? null : event.tag;
    emit(state.copyWith(selectedTag: newSelected));
  }

  void _onClearTags(ClearTagsEvent event, Emitter<PublishState> emit) {
    emit(state.copyWith(tags: [], clearSelectedTag: true));
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<PublishState> emit,
  ) async {
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      emit(state.copyWith(selectedImage: File(picked.path)));
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<PublishState> emit) {
    emit(state.copyWith(clearSelectedImage: true));
  }

  Future<void> _onPublishSubmitted(
    PublishSubmittedEvent event,
    Emitter<PublishState> emit,
  ) async {
    if (state.selectedImage == null) return;

    emit(state.copyWith(status: PublishStatus.loading));

    final result = await postPublishUseCase(
      event.title,
      event.body,
      event.markdown,
      state.selectedImage!,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PublishStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (post) => emit(state.copyWith(status: PublishStatus.success, post: post)),
    );
  }
}
