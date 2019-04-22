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

class AnnotationLayerBuilderOptions {
  JsObject _jsInternal;
  IL10n _l10n;
  PDFPageProxy _pdfPage;

  AnnotationLayerBuilderOptions() {
    _jsInternal = new JsObject.jsify({});
  }

  IL10n get l10n => _l10n;
  set l10n(IL10n l10n) {
    _jsInternal['l10n'] = l10n;

    _l10n = l10n;
  }

  DivElement get pageDiv => _jsInternal['pageDiv'];
  set pageDiv(DivElement pageDiv) {
    _jsInternal['pageDiv'] = pageDiv;
  }

  PDFPageProxy get pdfPage => _pdfPage;
  set pdfPage(PDFPageProxy pdfPage) {
    _jsInternal['pdfPage'] = pdfPage._jsInternal;

    _pdfPage = pdfPage;
  }

  bool get renderInteractiveForms => _jsInternal['renderInteractiveForms'];
  set renderInteractiveForms(bool renderInteractiveForms) {
    _jsInternal['renderInteractiveForms'] = renderInteractiveForms;
  }
}

enum AnnotationLayerBuilderIntent { display }

class AnnotationLayerBuilder {
  JsObject _jsInternal;

  AnnotationLayerBuilder(AnnotationLayerBuilderOptions options) {
    _jsInternal =
        new JsObject(context['pdfjsViewer']['AnnotationLayerBuilder'], [
      options,
    ]);
  }

  AnnotationLayerBuilder._withJsInternal(this._jsInternal);

  void render(PageViewport viewport) {
    _jsInternal.callMethod('render', [viewport._jsInternal]);
  }
}

abstract class IPDFAnnotationLayerFactory {
  JsObject _jsInternal;

  IPDFAnnotationLayerFactory() {
    _jsInternal['createAnnotationLayerBuilder'] =
        (DivElement pageDiv, JsObject jsPdfPage,
            [bool renderInteractiveForms, JsObject jsL10n]) {
      PDFPageProxy pdfPage = new PDFPageProxy._withJsInternal(jsPdfPage);
      IL10n l10n = new _JsIL10n._withJsInternal(jsL10n);

      AnnotationLayerBuilder annotationLayerBuilder =
          createAnnotationLayerBuilder(pageDiv, pdfPage,
              l10n: l10n, renderInteractiveForms: renderInteractiveForms);

      return annotationLayerBuilder._jsInternal;
    };
  }

  AnnotationLayerBuilder createAnnotationLayerBuilder(
    DivElement pageDiv,
    PDFPageProxy pdfPage, {
    IL10n l10n: null,
    bool renderInteractiveForms: false,
  });
}

abstract class IPDFTextLayerFactory {
  JsObject _jsInternal;
}

class DefaultTextLayerFactory implements IPDFTextLayerFactory {
  JsObject _jsInternal;

  DefaultTextLayerFactory() {
    _jsInternal =
        new JsObject(context['pdfjsViewer']['DefaultTextLayerFactory'], []);
  }
}

class DefaultAnnotationLayerFactory implements IPDFAnnotationLayerFactory {
  JsObject _jsInternal;

  DefaultAnnotationLayerFactory() {
    _jsInternal = new JsObject(
        context['pdfjsViewer']['DefaultAnnotationLayerFactory'], []);
  }

  AnnotationLayerBuilder createAnnotationLayerBuilder(
    DivElement pageDiv,
    PDFPageProxy pdfPage, {
    IL10n l10n: null,
    bool renderInteractiveForms: false,
  }) {
    JsObject jsAnnotationLayerBuilder = _jsInternal.callMethod(
        'createAnnotationLayerBuilder', [
      pageDiv,
      pdfPage._jsInternal,
      renderInteractiveForms,
      l10n?._jsInternal
    ]);

    return new AnnotationLayerBuilder._withJsInternal(jsAnnotationLayerBuilder);
  }
}

abstract class IL10n {
  JsObject _jsInternal;

  Future<String> getDirection();

  Future<String> get(String key, Map args, String fallback);

  Future<Null> translate(HtmlElement element);
}

class _JsIL10n implements IL10n {
  JsObject _jsInternal;

  _JsIL10n._withJsInternal(this._jsInternal);

  Future<String> getDirection() {
    JsObject promise = _jsInternal.callMethod('getDirection', []);

    return _promiseToFuture<String>(promise);
  }

  Future<String> get(String key, Map args, String fallback) {
    JsObject promise = _jsInternal
        .callMethod('get', [key, new JsObject.jsify(args), fallback]);

    return _promiseToFuture<String>(promise);
  }

  Future<Null> translate(HtmlElement element) {
    JsObject promise = _jsInternal.callMethod('translate', [element]);

    return _promiseToFuture<Null>(promise);
  }
}
