import 'package:calmove/repos/login_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInputNotLoadedYet());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginInputLoaded) {
      yield LoginInputIsProcessing();
      final response = await LoginRepo(event.username, event.password).getData();
      if(response['Success'] == true) {
        yield LoginSuccessfulState(response['Message']);
      } else {
        yield LoginErrorState(response['Message']);
      }
    }
  }

}

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInputLoaded extends LoginEvent {
  final username;
  final password;

  LoginInputLoaded(this.username,this.password);

  @override
  List<Object?> get props => [username,password];
}

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInputNotLoadedYet extends LoginState {}

class LoginInputIsProcessing extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final message;
  LoginSuccessfulState(this.message);
}

class LoginErrorState extends LoginState {
  final message;
  LoginErrorState(this.message);
}