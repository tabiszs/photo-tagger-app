import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:photo_tagger/pages/authenticate/microsoft/sign_in_button.dart';

class SignOutPage extends StatelessWidget {
  const SignOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return MaterialApp(
        home: LogInFormWidget(
          state: state,
        ),
      );
    });
  }
}

class LogInFormWidget extends StatefulWidget {
  const LogInFormWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final AuthState state;

  @override
  State<LogInFormWidget> createState() => _LogInFormWidgetState();
}

// https://stackoverflow.com/questions/46551268/when-the-keyboard-appears-the-flutter-widgets-resize-how-to-prevent-this
class _LogInFormWidgetState extends State<LogInFormWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static const double _edgeInsets = 32;
  bool? correctDomain = true;

  @override
  Widget build(BuildContext context) {
    AuthState state = widget.state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _edgeInsets),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(height: 2 * _edgeInsets),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/skauci-logo.png',
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Adres e-mail: @skauci-europy.pl',
                      errorText: correctDomain == null
                          ? null
                          : (correctDomain! ? null : "Niepoprawna domena."),
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
                    Text(
                      state.error!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
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
          ),
        ),
      ),
    );
  }
}
