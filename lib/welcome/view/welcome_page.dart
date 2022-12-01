import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_repository/user_repository.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(context.read<UserRepository>()),
      child: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WelcomeBloc, WelcomeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              if (state.isNewUser) {
                context.pushRoute(
                  OtpCodeRoute(
                    phoneNumber: context.read<WelcomeBloc>().state.phoneNumber,
                  ),
                );
              } else {
                context.replaceRoute(const LoginRoute());
              }
            } else if (state.status.isLoading) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Cargando...')));
            } else if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Hubo un error')));
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.status.isAuthenticated) {
              context.replaceRoute(const HomeRoute());
            }
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _PhoneNumberField(),
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
          .read<WelcomeBloc>()
          .add(WelcomePhoneNumberChanged(value.completeNumber)),
      initialCountryCode: 'PE',
      disableLengthCheck: true,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<WelcomeBloc>().add(WelcomeSubmitButtonPressed()),
      child: const Text('Ingresar'),
    );
  }
}
