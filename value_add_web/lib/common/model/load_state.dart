enum _LoadStateValue { idle, loading, success, failure }

/// 加载状态
final class LoadState {
  final _LoadStateValue _value;
  final String? message;

  LoadState.idle({this.message}) : _value = _LoadStateValue.idle;

  LoadState.loading({this.message}) : _value = _LoadStateValue.loading;

  LoadState.success({this.message}) : _value = _LoadStateValue.success;

  LoadState.failure({this.message}) : _value = _LoadStateValue.failure;

  bool get isIdle => _value == _LoadStateValue.idle;
  bool get isLoading => _value == _LoadStateValue.loading;
  bool get isSuccess => _value == _LoadStateValue.success;
  bool get isFailure => _value == _LoadStateValue.failure;
  bool get isCompleted => !isLoading && !isIdle;

  get value => _value;
}
