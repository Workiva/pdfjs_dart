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

enum PDFPageViewRenderer { canvas, svg }

class PDFPageView {
  late JsObject _jsInternal;

  PDFPageView({
    DivElement? container,
    num? id,
    num? scale,
    PageViewport? defaultViewport,
    PDFPageViewRenderer? renderer,
    IPDFAnnotationLayerFactory? annotationLayerFactory,
    IPDFTextLayerFactory? textLayerFactory,
  }) {
    String? rendererString;
    switch (renderer) {
      case PDFPageViewRenderer.canvas:
        rendererString = 'canvas';
        break;
      case PDFPageViewRenderer.svg:
        rendererString = 'svg';
        break;
      case null:
        throw Exception('Un-expected error due to null renderer');
    }

    _jsInternal = JsObject(
        PDFJS.versionSafePdfJsViewerContext?['PDFPageView'] as JsFunction, [
      JsObject.jsify({
        'container': container,
        'id': id,
        'scale': scale,
        'defaultViewport': defaultViewport?._jsInternal,
        'renderer': rendererString,
        'annotationLayerFactory': annotationLayerFactory?._jsInternal,
        'textLayerFactory': textLayerFactory?._jsInternal,
        'eventBus': JsObject(
            PDFJS.versionSafePdfJsViewerContext?['EventBus'] as JsFunction),
      })
    ]);
  }

  DivElement? get div => _jsInternal['div'] as DivElement?;

  void cancelRendering() {
    _jsInternal.callMethod('cancelRendering', []);
  }

  void destroy() {
    _jsInternal.callMethod('destroy', []);
  }

  void draw() {
    _jsInternal.callMethod('draw', []);
  }

  void setPdfPage(PDFPageProxy pdfPage) {
    _jsInternal.callMethod('setPdfPage', [pdfPage._jsInternal]);
  }

  void update(num scale, [num rotation = 0]) {
    _updateV2(scale: scale, rotation: rotation);

    if (!_isUpdated(scale: scale, rotation: rotation)) {
      _updateV1(scale, rotation: rotation);
    }
  }

  /// v2.11.338+
  void _updateV2({num scale = 0, num rotation = 0}) {
    _jsInternal.callMethod('update', [
      JsObject.jsify({
        'scale': scale,
        'rotation': rotation,
      })
    ]);
  }

  bool _isUpdated({num scale = 0, num rotation = 0}) {
    dynamic jsScale = _jsInternal['scale'];
    num? jsRotation = _jsInternal['rotation'] as num?;
    return jsScale is num && jsScale == scale && jsRotation == rotation;
  }

  void _updateV1(num scale, {num rotation = 0}) {
    _jsInternal.callMethod('update', [scale, rotation]);
  }
}
