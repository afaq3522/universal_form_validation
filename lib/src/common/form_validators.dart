/// Signature of a validator function.
///
/// Returns an error message when [value] is invalid, or `null` when valid.
/// Matches Flutter's `FormFieldValidator<String>` so composed validators can
/// be passed directly to a `TextFormField.validator`.
typedef Validator = String? Function(String? value);

/// Utilities for combining validators.
class FormValidators {
  /// Runs each validator in [validators] in order and returns the first
  /// error message, or `null` when all pass.
  ///
  /// ```dart
  /// TextFormField(
  ///   validator: FormValidators.compose([
  ///     (v) => BasicValidators.required(v, fieldName: 'Email'),
  ///     BasicValidators.email,
  ///   ]),
  /// )
  /// ```
  static Validator compose(List<Validator> validators) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// Wraps [validator] so that empty input is considered valid.
  ///
  /// Useful for optional fields that should still be validated when the
  /// user enters something.
  static Validator optional(Validator validator) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      return validator(value);
    };
  }
}
