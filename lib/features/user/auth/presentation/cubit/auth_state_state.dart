part of 'auth_state_cubit.dart';

@immutable
sealed class AuthStateState extends Equatable {
  const AuthStateState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthStateState {}

final class AuthStateLoading extends AuthStateState {}

final class AuthStateSuccess extends AuthStateState {
  final UserModel user;

  const AuthStateSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthStateError extends AuthStateState {
  final String message;

  const AuthStateError(this.message);

  @override
  List<Object> get props => [message];
}
