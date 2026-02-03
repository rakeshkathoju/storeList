import 'package:dio/dio.dart';
import 'package:storelist/store/data/product_repository_impl.dart';

import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late ProductRepositoryImpl repository;
  final fakeResponse = Response(
    requestOptions: RequestOptions(path: "https://fakestoreapi.com/products"),
    statusCode: 200,
    data: [
      {"id": 1, "title": "Product 1"},
      {"id": 2, "title": "Product 2"},
    ],
  );

  setUp(() {
    mockDio = MockDio();
    repository = ProductRepositoryImpl(mockDio);
  });

  group('ProductRepositoryImpl.fetchProductsData', () {
    test('returns Right(Response) when Dio succeeds', () async {
      // Act
      when(() => mockDio.get("https://fakestoreapi.com/products"))
          .thenAnswer((_) async => fakeResponse);
      final result = await repository.fetchProductsData();

      // Assert
      expect(result.isRight(), true);
    });

    test('returns Left(Failure) when Dio throws exception', () async {
      // Arrange
      when(() => mockDio.get("https://fakestoreapi.com/products"))
          .thenThrow(Exception("Network error"));

      // Act
      final result = await repository.fetchProductsData();

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure.errorMessage, contains("Network error"));
      }, (_) => fail("Expected failure but got success"));
    });
  });
}
