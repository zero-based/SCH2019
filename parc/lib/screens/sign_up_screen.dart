import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_event.dart';
import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../widgets/outlined_text_field.dart';
import '../widgets/rounded_button.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(),
        child: _SignUpForm(),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  SignUpBloc _signUpBloc;

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _licenseController.text.isNotEmpty;

  bool isFormValid(SignUpState state) {
    return state.isEmailValid && state.isLicenseValid && state.isPasswordValid;
  }

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated && state.isFormValid;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _licenseController.addListener(_onLicenseChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Creating Account..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Failed to Create an Account!"),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(SignedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 32.0),
                OutlinedTextField(
                  text: 'Name',
                  controller: _nameController,
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  text: 'Email',
                  controller: _emailController,
                  validator: (_) {
                    return !state.isEmailValid ? "Invalid Email." : null;
                  },
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  text: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (_) {
                    return !state.isPasswordValid ? "Invalid Password." : null;
                  },
                ),
                SizedBox(height: 32.0),
                OutlinedTextField(
                  text: 'License',
                  controller: _licenseController,
                  validator: (_) {
                    return !state.isLicenseValid ? "Invalid License." : null;
                  },
                ),
                SizedBox(height: 32.0),
                RoundedButton(
                  text: 'Sign up',
                  onPressed:
                      isSignUpButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onLicenseChanged() {
    _signUpBloc.add(
      LicenseChanged(license: _licenseController.text),
    );
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      Submitted(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        license: _licenseController.text,
      ),
    );
  }
}
