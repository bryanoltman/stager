// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_environment_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BasicEnvironmentState extends BasicEnvironmentState {
  @override
  final double textScale;
  @override
  final bool isDarkMode;
  @override
  final bool isTextBold;
  @override
  final bool showSemantics;
  @override
  final TargetPlatform? targetPlatform;
  @override
  final int? heightOverride;
  @override
  final int? widthOverride;

  factory _$BasicEnvironmentState(
          [void Function(BasicEnvironmentStateBuilder)? updates]) =>
      (new BasicEnvironmentStateBuilder()..update(updates))._build();

  _$BasicEnvironmentState._(
      {required this.textScale,
      required this.isDarkMode,
      required this.isTextBold,
      required this.showSemantics,
      this.targetPlatform,
      this.heightOverride,
      this.widthOverride})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        textScale, r'BasicEnvironmentState', 'textScale');
    BuiltValueNullFieldError.checkNotNull(
        isDarkMode, r'BasicEnvironmentState', 'isDarkMode');
    BuiltValueNullFieldError.checkNotNull(
        isTextBold, r'BasicEnvironmentState', 'isTextBold');
    BuiltValueNullFieldError.checkNotNull(
        showSemantics, r'BasicEnvironmentState', 'showSemantics');
  }

  @override
  BasicEnvironmentState rebuild(
          void Function(BasicEnvironmentStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BasicEnvironmentStateBuilder toBuilder() =>
      new BasicEnvironmentStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BasicEnvironmentState &&
        textScale == other.textScale &&
        isDarkMode == other.isDarkMode &&
        isTextBold == other.isTextBold &&
        showSemantics == other.showSemantics &&
        targetPlatform == other.targetPlatform &&
        heightOverride == other.heightOverride &&
        widthOverride == other.widthOverride;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, textScale.hashCode);
    _$hash = $jc(_$hash, isDarkMode.hashCode);
    _$hash = $jc(_$hash, isTextBold.hashCode);
    _$hash = $jc(_$hash, showSemantics.hashCode);
    _$hash = $jc(_$hash, targetPlatform.hashCode);
    _$hash = $jc(_$hash, heightOverride.hashCode);
    _$hash = $jc(_$hash, widthOverride.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BasicEnvironmentState')
          ..add('textScale', textScale)
          ..add('isDarkMode', isDarkMode)
          ..add('isTextBold', isTextBold)
          ..add('showSemantics', showSemantics)
          ..add('targetPlatform', targetPlatform)
          ..add('heightOverride', heightOverride)
          ..add('widthOverride', widthOverride))
        .toString();
  }
}

class BasicEnvironmentStateBuilder
    implements Builder<BasicEnvironmentState, BasicEnvironmentStateBuilder> {
  _$BasicEnvironmentState? _$v;

  double? _textScale;
  double? get textScale => _$this._textScale;
  set textScale(double? textScale) => _$this._textScale = textScale;

  bool? _isDarkMode;
  bool? get isDarkMode => _$this._isDarkMode;
  set isDarkMode(bool? isDarkMode) => _$this._isDarkMode = isDarkMode;

  bool? _isTextBold;
  bool? get isTextBold => _$this._isTextBold;
  set isTextBold(bool? isTextBold) => _$this._isTextBold = isTextBold;

  bool? _showSemantics;
  bool? get showSemantics => _$this._showSemantics;
  set showSemantics(bool? showSemantics) =>
      _$this._showSemantics = showSemantics;

  TargetPlatform? _targetPlatform;
  TargetPlatform? get targetPlatform => _$this._targetPlatform;
  set targetPlatform(TargetPlatform? targetPlatform) =>
      _$this._targetPlatform = targetPlatform;

  int? _heightOverride;
  int? get heightOverride => _$this._heightOverride;
  set heightOverride(int? heightOverride) =>
      _$this._heightOverride = heightOverride;

  int? _widthOverride;
  int? get widthOverride => _$this._widthOverride;
  set widthOverride(int? widthOverride) =>
      _$this._widthOverride = widthOverride;

  BasicEnvironmentStateBuilder();

  BasicEnvironmentStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _textScale = $v.textScale;
      _isDarkMode = $v.isDarkMode;
      _isTextBold = $v.isTextBold;
      _showSemantics = $v.showSemantics;
      _targetPlatform = $v.targetPlatform;
      _heightOverride = $v.heightOverride;
      _widthOverride = $v.widthOverride;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BasicEnvironmentState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BasicEnvironmentState;
  }

  @override
  void update(void Function(BasicEnvironmentStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BasicEnvironmentState build() => _build();

  _$BasicEnvironmentState _build() {
    final _$result = _$v ??
        new _$BasicEnvironmentState._(
            textScale: BuiltValueNullFieldError.checkNotNull(
                textScale, r'BasicEnvironmentState', 'textScale'),
            isDarkMode: BuiltValueNullFieldError.checkNotNull(
                isDarkMode, r'BasicEnvironmentState', 'isDarkMode'),
            isTextBold: BuiltValueNullFieldError.checkNotNull(
                isTextBold, r'BasicEnvironmentState', 'isTextBold'),
            showSemantics: BuiltValueNullFieldError.checkNotNull(
                showSemantics, r'BasicEnvironmentState', 'showSemantics'),
            targetPlatform: targetPlatform,
            heightOverride: heightOverride,
            widthOverride: widthOverride);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
