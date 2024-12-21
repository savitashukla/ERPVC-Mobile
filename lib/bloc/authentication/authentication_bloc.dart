import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/model/user_model.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:erpvc/repos/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(mapAuthenticationStatusChangedToState);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  mapAuthenticationStatusChangedToState(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return   emit(AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        // return const AuthenticationState.authenticated();
        final user = await _tryGetUser();

        return user != null
            ? emit(AuthenticationState.authenticated(user))
            : emit(AuthenticationState.unauthenticated());
      default:
        return emit(AuthenticationState.unknown());
    }
  }

  Future<UserModel?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
