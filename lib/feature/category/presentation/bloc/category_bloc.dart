import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/category/domain/entity/item_entity.dart';
import 'package:home_decor/feature/category/domain/usecases/category_usecases.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUsecases categoryUsecases;

  CategoryBloc({required this.categoryUsecases}) : super(HomeInitial()) {
    on<CategoryEvent>((event, emit) {});

    on<CategoryInitialEvent>(_categoryInitialEvent);
  }

  FutureOr<void> _categoryInitialEvent(
    CategoryInitialEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());

    final failureOrtopsellings = await categoryUsecases.getTopSelling();

    failureOrtopsellings.fold(
      (failure) => emit(CategoryErrorState()),
      (topSellingitems) =>
          emit(CategoryLoadedState(topSellingItems: topSellingitems)),
    );
  }
}
