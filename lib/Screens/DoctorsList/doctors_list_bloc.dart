import 'package:calmove/Modals/doctors_list_modal.dart';
import 'package:calmove/repos/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListBloc extends Bloc<DoctorsListEvent, DoctorsListState> {

  DoctorsListBloc() : super(DoctorsListInputNotLoadedYet());
  @override
  Stream<DoctorsListState> mapEventToState(DoctorsListEvent event) async* {
    if(event is DoctorsListUiLoadedEvent) {
      yield DoctorsListInputNotLoadedYet();
      final Doctors response = await DoctorsRepo().getData();
      yield DoctorsListLoadedState(response.data);
    }
  }

}

class DoctorsListEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DoctorsListUiLoadedEvent extends DoctorsListEvent {}

class DoctorsListState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DoctorsListInputNotLoadedYet extends DoctorsListState {}

class DoctorsListUiNotLoadedYet extends DoctorsListState {}

class DoctorsListLoadedState extends DoctorsListState {
  final List<DoctorData> ? data;

  DoctorsListLoadedState(this.data);
}