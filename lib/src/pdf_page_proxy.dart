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

class PDFPageProxy {
  JsObject _jsInternal;

  PDFPageProxy() {
    _jsInternal = new JsObject(context['pdfjsLib']['PDFPageProxy']);
  }

  PDFPageProxy._withJsInternal(this._jsInternal);

  int get pageNumber => _jsInternal['pageNumber'];

  int get rotate => _jsInternal['rotate'];

  num get userUnit => _jsInternal['userUnit'];

  List<num> get view => _jsInternal['view'];

  void cleanup() {
    _jsInternal.callMethod('cleanup', []);
  }

  PageViewport getViewport(num scale, {int rotation = null, bool dontFlip = null}) {
    JsObject jsViewport = _jsInternal.callMethod('getViewport', [
      new JsObject.jsify({
        'scale': scale,
        'rotation': rotation,
        'dontFlip': dontFlip,
      })
    ]);

    return new PageViewport._withJsInternal(jsViewport);
  }
}
