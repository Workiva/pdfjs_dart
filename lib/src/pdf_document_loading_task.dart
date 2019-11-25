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
  Future<PDFDocumentProxy> _future;
  JsObject _jsInternal;

  PDFDocumentLoadingTask() {
    _jsInternal = JsObject(context['pdfjsLib']['PDFDocumentLoadingTask']);
    _initFuture();
  }

  PDFDocumentLoadingTask._withJsInternal(this._jsInternal) {
    _initFuture();
  }

  void _initFuture() {
    _future = _promiseToFuture<PDFDocumentProxy>(_jsInternal['promise'],
        transform: (value) => PDFDocumentProxy._withJsInternal(value));
  }

  bool get destroyed => _jsInternal['destroyed'];

  String get docId => _jsInternal['docId'];

  Future<PDFDocumentProxy> get future => _future;

  Future destroy() => _promiseToFuture(_jsInternal.callMethod('destroy', []));

  Future<S> then<S>(dynamic onValue(PDFDocumentProxy value),
          {Function onError}) =>
      _future.then(onValue, onError: onError);
}
