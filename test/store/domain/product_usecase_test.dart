import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storelist/store/domain/product_domain_model.dart';
import 'package:storelist/store/domain/product_domain_model_mapper.dart';
import 'package:storelist/store/domain/product_repository.dart';
import 'package:storelist/store/domain/product_usecase.dart';
import 'package:storelist/store/failure.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';

// Create mocks
class MockProductRepository extends Mock implements ProductRepository {}

class MockProductDomainModelMapper extends Mock
    implements ProductDomainModelMapper {}

void main() {
  late MockProductRepository mockRepository;
  late MockProductDomainModelMapper mockMapper;
  late GetProductUseCase useCase;

  setUp(() {
    mockRepository = MockProductRepository();
    mockMapper = MockProductDomainModelMapper();
    useCase = GetProductUseCase(mockRepository, mockMapper);
  });

  group('GetProductUseCase.fetchProductsData', () {
    test(
      'returns Right(ProductDomainModelList) when repository succeeds and mapping works',
      () async {
        // Arrange
        final fakeResponse = Response(
          requestOptions: RequestOptions(
            path: "https://fakestoreapi.com/products",
          ),
          statusCode: 200,
          data: [
            {"id": 1, "title": "Product 1"},
            {"id": 2, "title": "Product 2"},
          ],
        );

        final fakeDomainList = ProductDomainModelList(
          productDomainModels: [
            ProductDomainModel(
              id: 1,
              title: "title",
              price: 1.0,
              description: 'description',
              category: 'category',
              image: 'image',
              rating: Rating(rate: 4.5, count: 10),
            ),
            ProductDomainModel(
              id: 2,
              title: "title",
              price: 10.4,
              description: 'description',
              category: 'category',
              image: 'image',
              rating: Rating(rate: 3.5, count: 5),
            ),
          ],
        );

        when(
          () => mockRepository.fetchProductsData(),
        ).thenAnswer((_) async => Future.value(Right(fakeResponse)));

        when(() => mockMapper.execute(fakeResponse)).thenReturn(fakeDomainList);

        // Act
        final result = await useCase.fetchProductsData();

        // Assert
        expect(result.isRight(), true);
      },
    );

    test('returns Left(Failure) when repository fails', () async {
      // Arrange
      final failure = Failure(errorMessage: "Network error");
      when(
        () => mockRepository.fetchProductsData(),
      ).thenAnswer((_) async => Future.value(Left(failure)));

      // Act
      final result = await useCase.fetchProductsData();

      // Assert
      expect(result.isLeft(), true);
    });

    test('returns Left(Failure) when mapping throws exception', () async {
      // Arrange
      final fakeResponse = Response(
        requestOptions: RequestOptions(
          path: "https://fakestoreapi.com/products",
        ),
        statusCode: 200,
        data: [],
      );

      when(
        () => mockRepository.fetchProductsData(),
      ).thenAnswer((_) async => Future.value(Right(fakeResponse)));

      when(
        () => mockMapper.execute(fakeResponse),
      ).thenThrow(Exception("Invalid format"));

      // Act
      final result = await useCase.fetchProductsData();

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
