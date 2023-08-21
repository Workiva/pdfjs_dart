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
  JsObject? _jsInternal;

  PDFPageProxy() {
    checkNotNull(context, message: 'context was null in PDFPageProxy');
    final pdfjsLib = PDFJS.versionSafePdfJsContext;
    checkState(pdfjsLib != null, message: 'pdfjsLib was null in PDFPageProxy');
    final pdfPageProxyJs = pdfjsLib?['PDFPageProxy'];
    checkState(pdfPageProxyJs != null, message: 'pdfPageProxyJs was null in PDFPageProxy');
    _jsInternal = JsObject(pdfPageProxyJs as JsFunction);
  }

  PDFPageProxy._withJsInternal(this._jsInternal);

  int? get pageNumber => _jsInternal?['pageNumber'] as int;

  int? get rotate => _jsInternal?['rotate'] as int;

  num? get userUnit => _jsInternal?['userUnit'] as num;

  JsArray<dynamic>? get view => _jsInternal?['view'] as JsArray<dynamic>;

  void cleanup() {
    _jsInternal?.callMethod('cleanup', []);
  }

  PageViewport getViewport(
    num scale, {
    int? rotation,
    bool? dontFlip,
  }) {
    final jsViewport = _jsInternal?.callMethod('getViewport', [
      JsObject.jsify({
        'scale': scale,
        'rotation': rotation,
        'dontFlip': dontFlip,
      })
    ]) as JsObject?;

    return PageViewport._withJsInternal(jsViewport);
  }

  /// Get a map of prop values useful for logging context
  Map<String, dynamic> toContext({String prefix = 'PDFPageProxy'}) => {
        '$prefix.pageNumber': pageNumber,
        '$prefix.rotate': rotate,
        '$prefix.userUnit': userUnit,
      };
}
