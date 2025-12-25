import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/usecases/item_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ItemUsecases itemUsecases;

  HomeBloc({required this.itemUsecases}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<HomePageInitialEvent>(_homePageInitialEvent);
  }

  FutureOr<void> _homePageInitialEvent(
    HomePageInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeTopSellingLoadingState());

    final failureOrtopsellings = await itemUsecases.getTopSelling();

    failureOrtopsellings.fold(
      (failure) => emit(HomeTopSellingErrorState()),
      (topSellingitems) =>
          emit(HomeTopSellingLoadedState(topSellingItems: topSellingitems)),
    );
  }
}
