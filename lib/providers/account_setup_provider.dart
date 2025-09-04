
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSetupState {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String password;
  final bool useOneTimePasscode;
  final bool isPasswordVisible;

  AccountSetupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.countryCode = '+234',
    this.password = '',
    this.useOneTimePasscode = false,
    this.isPasswordVisible = false,
  });

  AccountSetupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? countryCode,
    String? password,
    bool? useOneTimePasscode,
    bool? isPasswordVisible,
  }) {
    return AccountSetupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
      useOneTimePasscode: useOneTimePasscode ?? this.useOneTimePasscode,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  bool get isFormValid {
    if (useOneTimePasscode) {
      return firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty;
    } else {
      return firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty;
    }
  }
}

class AccountSetupStateNotifier extends StateNotifier<AccountSetupState> {
  AccountSetupStateNotifier() : super(AccountSetupState());

  void setFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void setLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void setCountryCode(String value) {
    state = state.copyWith(countryCode: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setUseOneTimePasscode(bool value) {
    state = state.copyWith(useOneTimePasscode: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }
}

final accountSetupProvider =
    StateNotifierProvider<AccountSetupStateNotifier, AccountSetupState>(
  (ref) => AccountSetupStateNotifier(),
);
