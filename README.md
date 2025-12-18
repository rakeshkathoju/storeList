# storelist# 🦋 Flutter Clean Architecture Project

A Flutter project structured with **Clean Architecture**, using:
- **Dio** for networking and API calls
- **Bloc** for predictable state management
- **GoRouter** for declarative navigation and deep linking

---

## 📂 Project Structure
lib/
├── core/                
├── data/                
│   ├── models/          
│   ├── sources/         
│   └── repositories/    
├── domain/              
│   ├── entities/        
│   ├── usecases/        
│   └── repositories/    
├── presentation/        
│   ├── blocs/           
│   ├── pages/           
│   └── widgets/         
└── main.dart            



                ┌─────────────────────────────┐
                │         Presentation        │
                │   (UI Widgets + Bloc/Cubit) │
                └───────────────┬─────────────┘
                                │
                                ▼
                ┌─────────────────────────────┐
                │           Domain            │
                │   (Entities + UseCases)     │
                └───────────────┬─────────────┘
                                │
                                ▼
                ┌─────────────────────────────┐
                │            Data             │
                │ (Repositories + Mappers)    │
                └───────────────┬─────────────┘
                                │
                                ▼
                ┌─────────────────────────────┐
                │       External Layer        │
                │   Dio (REST APIs) + Local   │
                │   DB + Secure Storage       │
                └─────────────────────────────┘


- Bloc (Presentation Layer):
- Handles UI state.
- Calls UseCases from the Domain layer.
- Emits states (Loading, Loaded, Error) to widgets.
- GoRouter (Navigation):
- Declarative routing between pages.
- Reads Bloc state for guards/redirection (e.g., redirect to login if unauthenticated).
- Domain Layer:
- Pure business logic.
- Defines Entities and UseCases.
- Returns results as Either<Failure, Entity>.
- Data Layer:
- Implements repositories.
- Uses Mappers to convert DTOs → Domain models.
- Wraps Dio responses in Either.
- Dio (External Layer):
- Handles HTTP requests.
- Provides raw JSON responses.
- Errors are caught and mapped to Failure.

