import 'package:flutter/material.dart';
import 'package:universal_form_validation/universal_form_validation.dart';

void main() => runApp(const ExampleApp());

/// Example app demonstrating universal_form_validation.
class ExampleApp extends StatelessWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Universal Form Validation',
      home: SignUpPage(),
    );
  }
}

/// A sign-up form showing common and country-aware validators in action.
class SignUpPage extends StatefulWidget {
  /// Creates the sign-up page.
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  String _countryCode = 'US';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rules = CountryRules.of(_countryCode);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: TextValidators.name,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: BasicValidators.email,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              validator: TextValidators.username,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (v) => BasicValidators.password(
                v,
                requireUppercase: true,
                requireNumber: true,
                requireSpecialChar: true,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm password'),
              obscureText: true,
              validator: (v) =>
                  BasicValidators.confirmPassword(v, _passwordController.text),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              validator: NumberValidators.phone,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Website (optional)'),
              keyboardType: TextInputType.url,
              validator: FormValidators.optional(
                (v) => BasicValidators.url(v, requireScheme: false),
              ),
            ),
            DropdownButtonFormField<String>(
              initialValue: _countryCode,
              decoration: const InputDecoration(labelText: 'Country'),
              items: const [
                DropdownMenuItem(value: 'US', child: Text('United States')),
                DropdownMenuItem(value: 'CA', child: Text('Canada')),
                DropdownMenuItem(value: 'GB', child: Text('United Kingdom')),
                DropdownMenuItem(value: 'AU', child: Text('Australia')),
                DropdownMenuItem(value: 'IN', child: Text('India')),
                DropdownMenuItem(value: 'DE', child: Text('Germany')),
                DropdownMenuItem(value: 'PK', child: Text('Pakistan')),
              ],
              onChanged: (v) => setState(() => _countryCode = v ?? 'US'),
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'State / Province'),
              validator: rules.stateOrProvince,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Postal code'),
              validator: rules.postalCode,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are valid!')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
