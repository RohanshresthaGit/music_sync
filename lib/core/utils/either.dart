/// A simple functional programming (FP) style `Either` implementation.
///
/// This class represents a value that can be either:
/// - `Left` → Failure case (error, exception, or invalid state)
/// - `Right` → Success case (valid result)
///
/// Inspired by functional libraries like `fpdart`.
///
/// ---
///
/// ## 🧠 Concept
///
/// Instead of throwing exceptions, functions return an `Either`:
///
/// - `Right(value)` → success result
/// - `Left(error)` → failure result
///
/// This forces explicit handling of both success and failure cases.
///
/// ---
///
/// ## 🚀 Core Features
///
/// ✔ Type-safe error handling  
/// ✔ No null values  
/// ✔ Functional composition using `fold()`  
/// ✔ Clear separation of success and failure paths  
///
/// ---
///
/// ## 📦 Usage Example
///
/// ### Returning a result:
/// ```dart
/// Either<String, int> fetchData() {
///   try {
///     return Right(200);
///   } catch (e) {
///     return Left('Something went wrong');
///   }
/// }
/// ```
///
/// ---
///
/// ### Consuming a result:
/// ```dart
/// final result = fetchData();
///
/// result.fold(
///   (error) => print('Error: $error'),
///   (data) => print('Success: $data'),
/// );
/// ```
///
/// ---
///
/// ## 🔥 Why use this?
///
/// - Avoids try/catch scattered across codebase
/// - Makes error handling explicit
/// - Improves readability in repositories and use cases
/// - Encourages functional programming style
///
/// ---
///
/// ## ⚠️ Notes
///
/// - `Left` is conventionally used for failures
/// - `Right` is conventionally used for success
/// - Always handle both sides using `fold()`
/// - Avoid ignoring Either results
///
/// ---
///
/// ## 🧩 Related Idea
///
/// This pattern is heavily inspired by:
/// - `fpdart`
/// - `dartz`
/// - Functional programming paradigms (Haskell, Scala)
sealed class Either<L, R> {
  const Either();

  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  );
}

/// -------------------- LEFT (Failure) --------------------
class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  ) {
    return onLeft(value);
  }

  @override
  String toString() => 'Left($value)';
}

/// -------------------- RIGHT (Success) --------------------
class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>(
    T Function(L l) onLeft,
    T Function(R r) onRight,
  ) {
    return onRight(value);
  }

  @override
  String toString() => 'Right($value)';
}

