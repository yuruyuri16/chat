import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_repository/user_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(context.read<UserRepository>()),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (state.status.isSuccess) {
          context.replaceRoute(const LoginRoute());
        } else if (state.status.isLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Cargando...')));
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Hubo un error')));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Registro')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _NameField(),
              SizedBox(height: 16),
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

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (name) =>
          context.read<RegisterBloc>().add(RegisterNameChanged(name)),
      decoration: const InputDecoration(labelText: 'Nombre'),
      autocorrect: false,
      enableSuggestions: false,
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      onChanged: (value) => context
          .read<RegisterBloc>()
          .add(RegisterPhoneNumberChanged(value.completeNumber)),
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
      onChanged: (password) =>
          context.read<RegisterBloc>().add(RegisterPasswordChanged(password)),
      decoration: const InputDecoration(labelText: 'Contraseña'),
      autocorrect: false,
      enableSuggestions: false,
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
          context.read<RegisterBloc>().add(RegisterSubmitButtonPressed()),
      child: const Text('Registrar'),
    );
  }
}
