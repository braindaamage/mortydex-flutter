import 'package:flutter_test/flutter_test.dart';
import 'package:mdx_characters/mdx_characters.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/entities/character_mocks.dart';
import '../fixtures/interfaces/mdx_character_data_source.mocks.dart';

void main() {
  late MockMDXCharacterDataSource mockDataSource;
  late MDXCharacterRepositoryImp repository;
  final mockCharacterDataGenerator = MockCharacterDataGenerator();

  setUp(() {
    mockDataSource = MockMDXCharacterDataSource();
    repository = MDXCharacterRepositoryImp(dataSource: mockDataSource);
  });

  final tCharacter = mockCharacterDataGenerator.getMockCharacter();
  final tCharacters = [
    tCharacter,
    mockCharacterDataGenerator.getMockCharacter()
  ];
  final tPage = mockCharacterDataGenerator.generateUniqueId();
  final tId = tCharacter.id;
  final tName = tCharacter.name;
  final tListOfIds = tCharacters.map((chharacter) => chharacter.id).toList();
  final tFilter = MDXCharacterFilter(name: tName);

  group('MDXCharacterRepositoryImp', () {
    group('Success Cases', () {
      test('should get all characters from the datasource', () async {
        // arrange
        when(mockDataSource.getAllCharacters(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getAllCharacters(tPage);
        // assert
        expect(result, equals(tCharacters));
        verify(mockDataSource.getAllCharacters(tPage));
        verifyNoMoreInteractions(mockDataSource);
      });

      test('should get character by id from the datasource', () async {
        // arrange
        when(mockDataSource.getCharacterById(any))
            .thenAnswer((_) async => tCharacter);
        // act
        final result = await repository.getCharacterById(tId);
        // assert
        expect(result, equals(tCharacter));
        verify(mockDataSource.getCharacterById(tId));
        verifyNoMoreInteractions(mockDataSource);
      });

      test('should get characters by list of ids from the datasource',
          () async {
        // arrange
        when(mockDataSource.getCharactersByIds(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getCharactersByIds(tListOfIds);
        // assert
        expect(result, equals(tCharacters));
        verify(mockDataSource.getCharactersByIds(tListOfIds));
        verifyNoMoreInteractions(mockDataSource);
      });

      test('should get characters by filter from the datasource', () async {
        // arrange
        when(mockDataSource.getFilteredCharacters(any))
            .thenAnswer((_) async => tCharacters);
        // act
        final result = await repository.getFilteredCharacters(tFilter);
        // assert
        expect(result, equals(tCharacters));
        verify(mockDataSource.getFilteredCharacters(tFilter));
        verifyNoMoreInteractions(mockDataSource);
      });
    });

    group('Throw Exceptions', () {
      test(
          'should throw an exception when there is an error getting characters from the datasource',
          () async {
        // arrange
        when(mockDataSource.getAllCharacters(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getAllCharacters(tPage),
            throwsA(isInstanceOf<Exception>()));
        verify(mockDataSource.getAllCharacters(tPage));
        verifyNoMoreInteractions(mockDataSource);
      });

      test(
          'should throw an exception when there is an error getting character by id from the datasource',
          () async {
        // arrange
        when(mockDataSource.getCharacterById(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getCharacterById(tId),
            throwsA(isInstanceOf<Exception>()));
        verify(mockDataSource.getCharacterById(tId));
        verifyNoMoreInteractions(mockDataSource);
      });

      test(
          'should throw an exception when there is an error getting characters by ids from the datasource',
          () async {
        // arrange
        when(mockDataSource.getCharactersByIds(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getCharactersByIds(tListOfIds),
            throwsA(isInstanceOf<Exception>()));
        verify(mockDataSource.getCharactersByIds(tListOfIds));
        verifyNoMoreInteractions(mockDataSource);
      });

      test(
          'should throw an exception when there is an error getting characters by filter from the datasource',
          () async {
        // arrange
        when(mockDataSource.getFilteredCharacters(any)).thenThrow(Exception());

        // assert
        expect(() async => await repository.getFilteredCharacters(tFilter),
            throwsA(isInstanceOf<Exception>()));
        verify(mockDataSource.getFilteredCharacters(tFilter));
        verifyNoMoreInteractions(mockDataSource);
      });
    });
  });
}
