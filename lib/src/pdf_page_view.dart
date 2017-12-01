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

enum PDFPageViewRenderer { canvas, svg }

class PDFPageView {
  JsObject _jsInternal;

  PDFPageView({
    DivElement container,
    num id,
    num scale,
    PageViewport defaultViewport,
    PDFPageViewRenderer renderer,
  }) {
    String rendererString;
    switch (renderer) {
      case PDFPageViewRenderer.canvas:
        rendererString = 'canvas';
        break;
      case PDFPageViewRenderer.svg:
        rendererString = 'svg';
        break;
    }

    _jsInternal = new JsObject(context['PDFJS']['PDFPageView'], [
      new JsObject.jsify({
        'container': container,
        'id': id,
        'scale': scale,
        'defaultViewport': defaultViewport._jsInternal,
        'renderer': rendererString,
      })
    ]);
  }

  DivElement get div => _jsInternal['div'];

  void cancelRendering() {
    _jsInternal['cancelRendering'].apply([], thisArg: _jsInternal);
  }

  void destroy() {
    _jsInternal['destroy'].apply([], thisArg: _jsInternal);
  }

  void draw() {
    _jsInternal['draw'].apply([], thisArg: _jsInternal);
  }

  void setPdfPage(PDFPageProxy pdfPage) {
    _jsInternal['setPdfPage']
        .apply([pdfPage._jsInternal], thisArg: _jsInternal);
  }

  void update(num scale, [num rotation = 0]) {
    _jsInternal['update'].apply([scale, rotation], thisArg: _jsInternal);
  }
}
