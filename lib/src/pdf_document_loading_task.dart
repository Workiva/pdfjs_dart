// Copyright 2018 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of pdfjs;

class PDFDocumentLoadingTask {
  late Future<PDFDocumentProxy> _future;
  JsObject _jsInternal;

  PDFDocumentLoadingTask() :
    _jsInternal = JsObject(PDFJS.versionSafePdfJsContext!['PDFDocumentLoadingTask'] as JsFunction) {
      _initFuture();
  }

  PDFDocumentLoadingTask._withJsInternal(this._jsInternal) {
    _initFuture();
  }

  void _initFuture() {
    _future = _promiseToFuture<PDFDocumentProxy>(_jsInternal['promise'] as JsObject,
        transform: (value) => PDFDocumentProxy._withJsInternal(value as JsObject));
  }

  bool? get destroyed => _jsInternal['destroyed'] as bool?;

  String? get docId => _jsInternal['docId'] as String?;

  Future<PDFDocumentProxy> get future => _future;

  Future destroy() => _promiseToFuture(_jsInternal.callMethod('destroy', []) as JsObject);

  Future<S> then<S>(FutureOr<S> onValue(PDFDocumentProxy value), {Function? onError}) =>
      _future.then(onValue, onError: onError);
}
