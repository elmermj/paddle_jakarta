import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';
import 'package:paddle_jakarta/data/sources/user_data_sources.dart/remote_user_data_source.dart';

import 'remote_user_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseFirestore>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<GoogleSignInAccount>(),
  MockSpec<GoogleSignInAuthentication>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late RemoteUserDataSource remoteUserDataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    remoteUserDataSource = RemoteUserDataSource(mockFirebaseAuth, mockFirebaseFirestore);
  });

  group('RemoteUserDataSource', () {
    test('loginEmail - successful login', () async {
      const email = 'test@example.com';
      const password = 'password123';
      final mockUserCredential = MockUserCredential();

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      final result = await remoteUserDataSource.loginEmail(email, password);

      expect(result, equals(mockUserCredential));
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).called(1);
    });

    test('loginEmail - failed login', () async {
      const email = 'test@example.com';
      const password = 'password123';

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenThrow(Exception('Invalid credentials'));

      expect(() => remoteUserDataSource.loginEmail(email, password),
          throwsA(isA<Exception>()));
    });

    test('registerEmail - successful registration', () async {
      const email = 'test@example.com';
      const password = 'password123';
      const name = 'Test User';
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.updateDisplayName(name)).thenAnswer((_) async => {});

      await remoteUserDataSource.registerEmail(email, password, name);

      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).called(1);
      verify(mockUser.updateDisplayName(name)).called(1);
    });

    test('forgotPassword - successful password reset', () async {
      const email = 'test@example.com';

      when(mockFirebaseAuth.sendPasswordResetEmail(email: email))
          .thenAnswer((_) async => {});

      await remoteUserDataSource.forgotPassword(email);

      verify(mockFirebaseAuth.sendPasswordResetEmail(email: email)).called(1);
    });

    test('logout - successful logout', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

      await remoteUserDataSource.logout();

      verify(mockFirebaseAuth.signOut()).called(1);
    });

    test('saveUserData - update existing user', () async {
      final user = UserModel(
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        creationTime: Timestamp.now(),
        lastLogin: Timestamp.now(),
      );

      final mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
      final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
      final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(user.email)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);

      await remoteUserDataSource.saveUserData(user);

      verify(mockFirebaseFirestore.collection('users')).called(1);
      verify(mockCollectionReference.doc(user.email)).called(1);
      verify(mockDocumentReference.get()).called(1);
      verify(mockDocumentReference.update(user.toJson())).called(1);
    });

    test('saveUserData - create new user', () async {
      final user = UserModel(
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        creationTime: Timestamp.now(),
        lastLogin: Timestamp.now(),
      );

      final mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
      final mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
      final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(user.email)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      await remoteUserDataSource.saveUserData(user);

      verify(mockFirebaseFirestore.collection('users')).called(1);
      verify(mockCollectionReference.doc(user.email)).called(1);
      verify(mockDocumentReference.get()).called(1);
      verify(mockDocumentReference.set(user.toJson())).called(1);
    });

  });
}
