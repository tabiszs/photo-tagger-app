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
              ? const Text('Sign in')
              : const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
          onPressed: state is SignedOutState
              ? () => context.read<AuthCubit>().signInWithEmailAndPassword(
                    email.text,
                    password.text,
                  )
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        );
      },
    );
  }
}
