import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../mocks.dart';

void main() {
  group('AuthRepository', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockGoogleSignIn mockGoogleSignIn;
    late AuthRepository authRepository;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      authRepository = AuthRepository(mockFirebaseAuth);
    });

    test('signInWithEmailAndPassword returns a User', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);

      final result = await authRepository.signInWithGoogle(
          'test@example.com', 'password');
      expect(result, mockUser);
    });

    test('signOut calls signOut method', () async {
      await authRepository.signOut();
      verify(mockFirebaseAuth.signOut()).called(1);
    });

    test('signInWithGoogle returns a User', () async {
      final mockGoogleSignInAccount = MockGoogleSignInAccount();
      final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(mockGoogleSignInAccount.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(mockGoogleSignInAuthentication.accessToken)
          .thenReturn('accessToken');
      when(mockGoogleSignInAuthentication.idToken).thenReturn('idToken');
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authRepository.signInWithGoogle();
      expect(result, mockUser);
    });

    test('signInAnonymously returns a User', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) async => mockUserCredential);

      final result = await authRepository.signInAnonymously();
      expect(result, mockUser);
    });
  });
}
