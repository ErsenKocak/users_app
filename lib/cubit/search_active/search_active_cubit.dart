import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SearchActiveCubit extends Cubit<bool> {
  SearchActiveCubit() : super(false);

  changeState(bool isSearchActive) => emit(isSearchActive);
}
