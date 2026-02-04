import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/category/domain/entity/item_entity.dart';
import 'package:home_decor/feature/category/domain/usecases/category_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

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

    final failureOritemList = await categoryUsecases.getTopSelling(
      event.category,
    );

    failureOritemList.fold(
      (failure) => emit(CategoryErrorState()),
      (itemList) => emit(CategoryLoadedState(itemList: itemList)),
    );
  }
}
