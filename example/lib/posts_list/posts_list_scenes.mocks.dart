// Mocks generated by Mockito 5.2.0 from annotations
// in example/posts_list/posts_list_scenes.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:example/shared/api.dart' as _i2;
import 'package:example/shared/post.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi extends _i1.Mock implements _i2.Api {
  MockApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Post>> fetchPosts() =>
      (super.noSuchMethod(Invocation.method(#fetchPosts, []),
              returnValue: Future<List<_i4.Post>>.value(<_i4.Post>[]))
          as _i3.Future<List<_i4.Post>>);
}
