part of 'publish_bloc.dart';

abstract class PublishEvent extends Equatable {
  const PublishEvent();

  @override
  List<Object> get props => [];
}

class AddTagEvent extends PublishEvent {
  final String tag;
  const AddTagEvent(this.tag);
  @override
  List<Object> get props => [tag];
}

class RemoveTagEvent extends PublishEvent {
  final String tag;
  const RemoveTagEvent(this.tag);
  @override
  List<Object> get props => [tag];
}

class SelectTagEvent extends PublishEvent {
  final String tag;
  const SelectTagEvent(this.tag);
  @override
  List<Object> get props => [tag];
}

class ClearTagsEvent extends PublishEvent {}

class PickImageEvent extends PublishEvent {}

class RemoveImageEvent extends PublishEvent {}

class PublishSubmittedEvent extends PublishEvent {
  final String title;
  final String body;
  final String markdown;

  const PublishSubmittedEvent(this.title, this.body, this.markdown);

  @override
  List<Object> get props => [title, body, markdown];
}
