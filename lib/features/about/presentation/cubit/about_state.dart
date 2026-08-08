abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final Map data;

  AboutLoaded(this.data);
}

class AboutError extends AboutState {
  final String message;

  AboutError(this.message);
}
