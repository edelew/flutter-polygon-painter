// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polygon_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PolygonEntity {
  List<Offset> get coordinates => throw _privateConstructorUsedError;
  bool get isFinished => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PolygonEntityCopyWith<PolygonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolygonEntityCopyWith<$Res> {
  factory $PolygonEntityCopyWith(
          PolygonEntity value, $Res Function(PolygonEntity) then) =
      _$PolygonEntityCopyWithImpl<$Res, PolygonEntity>;
  @useResult
  $Res call({List<Offset> coordinates, bool isFinished});
}

/// @nodoc
class _$PolygonEntityCopyWithImpl<$Res, $Val extends PolygonEntity>
    implements $PolygonEntityCopyWith<$Res> {
  _$PolygonEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = null,
    Object? isFinished = null,
  }) {
    return _then(_value.copyWith(
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolygonEntityImplCopyWith<$Res>
    implements $PolygonEntityCopyWith<$Res> {
  factory _$$PolygonEntityImplCopyWith(
          _$PolygonEntityImpl value, $Res Function(_$PolygonEntityImpl) then) =
      __$$PolygonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Offset> coordinates, bool isFinished});
}

/// @nodoc
class __$$PolygonEntityImplCopyWithImpl<$Res>
    extends _$PolygonEntityCopyWithImpl<$Res, _$PolygonEntityImpl>
    implements _$$PolygonEntityImplCopyWith<$Res> {
  __$$PolygonEntityImplCopyWithImpl(
      _$PolygonEntityImpl _value, $Res Function(_$PolygonEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = null,
    Object? isFinished = null,
  }) {
    return _then(_$PolygonEntityImpl(
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PolygonEntityImpl implements _PolygonEntity {
  _$PolygonEntityImpl(
      {required final List<Offset> coordinates, this.isFinished = false})
      : _coordinates = coordinates;

  final List<Offset> _coordinates;
  @override
  List<Offset> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  @JsonKey()
  final bool isFinished;

  @override
  String toString() {
    return 'PolygonEntity(coordinates: $coordinates, isFinished: $isFinished)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolygonEntityImpl &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_coordinates), isFinished);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolygonEntityImplCopyWith<_$PolygonEntityImpl> get copyWith =>
      __$$PolygonEntityImplCopyWithImpl<_$PolygonEntityImpl>(this, _$identity);
}

abstract class _PolygonEntity implements PolygonEntity {
  factory _PolygonEntity(
      {required final List<Offset> coordinates,
      final bool isFinished}) = _$PolygonEntityImpl;

  @override
  List<Offset> get coordinates;
  @override
  bool get isFinished;
  @override
  @JsonKey(ignore: true)
  _$$PolygonEntityImplCopyWith<_$PolygonEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
