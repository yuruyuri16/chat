import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(context.read<UserRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Cargando...')));
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          context.replaceRoute(const HomeRoute());
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Hubo un error...')));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _PhoneNumberField(),
              SizedBox(height: 16),
              _PasswordField(),
              SizedBox(height: 16),
              _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      onChanged: (value) => context
          .read<LoginBloc>()
          .add(LoginPhoneNumberChanged(value.completeNumber)),
      initialCountryCode: 'PE',
      disableLengthCheck: true,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(value)),
      decoration: const InputDecoration(labelText: 'Contraseña'),
      obscureText: true,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<LoginBloc>().add(LoginSubmitButtonPressed()),
      child: const Text('Iniciar sesión'),
    );
  }
}
