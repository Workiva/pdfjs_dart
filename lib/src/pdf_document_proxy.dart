// Copyright 2017 Workiva Inc.
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

class PDFDocumentProxy {
  JsObject _jsInternal;

  PDFDocumentProxy() {
    _jsInternal = new JsObject(context['PDFJS']['PDFDocumentProxy']);
  }

  PDFDocumentProxy._withJsInternal(this._jsInternal);

  String get fingerprint => _jsInternal['fingerprint'];

  int get numPages => _jsInternal['numPages'];

  void cleanup() {
    _jsInternal['cleanup'].apply([], thisArg: _jsInternal);
  }

  void destroy() {
    _jsInternal['destroy'].apply([], thisArg: _jsInternal);
  }

  Future<TypedData> getData() {
    JsObject promise = _jsInternal['getData'].apply([], thisArg: _jsInternal);

    return _promiseToFuture<TypedData>(promise);
  }

  Future<PDFPageProxy> getPage(int pageNumber) {
    JsObject promise =
        _jsInternal['getPage'].apply([pageNumber], thisArg: _jsInternal);

    return _promiseToFuture<PDFPageProxy>(promise,
        transform: (value) => new PDFPageProxy._withJsInternal(value));
  }

  Future<String> getPageMode() {
    JsObject promise = _jsInternal['getPageMode'].apply([], thisArg: _jsInternal);

    return _promiseToFuture<String>(promise);
  }
}
