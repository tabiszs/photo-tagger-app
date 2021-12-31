import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:photo_tagger/pages/authenticate/microsoft/sign_in_button.dart';

//TODO - make as form
// przechodzienie do następnej kontrolki
// wstępna walidacja
class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static const double _edgeInsets = 32;
  bool? correctDomain = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _edgeInsets),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 2 * _edgeInsets),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/skauci-logo.png'),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Adres e-mail: @skauci-europy.pl',
                  // FSE
                  // errorText: correctDomain == null
                  //     ? null
                  //     : (correctDomain! ? null : "Niepoprawna domena."),
                ),
                controller: emailController,
                onSubmitted: (String text) {
                  setState(() {
                    text.trimRight();
                    correctDomain = text.endsWith('@skauci-europy.pl');
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hasło',
                ),
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              if (state is SignedOutState && state.error != null) ...[
                Text(state.error!),
                const SizedBox(height: 16),
              ] else
                const SizedBox(height: 32),
              SignInButton(
                email: emailController,
                password: passwordController,
              )
            ],
          ),
        ),
      );
    });
  }
}
