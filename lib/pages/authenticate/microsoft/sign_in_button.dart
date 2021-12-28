import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          child: state is SignedOutState
              ? const DefaultState()
              : const ProcessingState(),
          onPressed: state is SignedOutState
              ? () => context.read<AuthCubit>().signInWithEmailAndPassword(
                    email.text,
                    password.text,
                  )
              : null,
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(color: Colors.black26)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
        );
      },
    );
  }
}

class DefaultState extends StatelessWidget {
  const DefaultState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/microsoft-logo.png',
          height: 20,
        ),
        const SizedBox(width: 10),
        const Text(
          'Zaloguj się',
        ),
      ],
    );
  }
}

class ProcessingState extends StatelessWidget {
  const ProcessingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.black,
      ),
    );
  }
}
