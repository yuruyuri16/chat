import 'package:auto_route/auto_route.dart';
import 'package:chat/app/app.dart';
import 'package:chat/welcome/otp_code/otp_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:user_repository/user_repository.dart';

class OtpCodePage extends StatelessWidget {
  const OtpCodePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCodeBloc(context.read<UserRepository>(), phoneNumber),
      child: const OtpCodeView(),
    );
  }
}

class OtpCodeView extends StatelessWidget {
  const OtpCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCodeBloc, OtpCodeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (state.status.isSuccess) {
          context.replaceRoute(const RegisterRoute());
        } else if (state.status.isLoading) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Cargando...')));
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Hubo un error...')));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Código')),
        body: Align(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _OtpCodeField(),
                SizedBox(height: 16),
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpCodeField extends StatelessWidget {
  const _OtpCodeField();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    return Pinput(
      onChanged: (value) =>
          context.read<OtpCodeBloc>().add(OtpCodeCodeChanged(value)),
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      defaultPinTheme: PinTheme(
        width: size.width / 6,
        height: size.width / 6,
        textStyle: GoogleFonts.poppins(
          fontSize: 22,
          color: const Color.fromRGBO(30, 60, 87, 1),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: borderColor),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2,
      child: ElevatedButton(
        onPressed: () =>
            context.read<OtpCodeBloc>().add(OtpCodeSubmitButtonPressed()),
        child: const Text('Enviar'),
      ),
    );
  }
}
