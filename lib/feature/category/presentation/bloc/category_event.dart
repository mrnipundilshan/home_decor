part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryInitialEvent extends CategoryEvent {
  final String category;

  const CategoryInitialEvent({required this.category});
}
