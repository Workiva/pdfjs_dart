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

enum LinkTarget {
  NONE,
  SELF,
  BLANK,
  PARENT,
  TOP,
}

enum VERBOSITY_LEVELS {
  errors,
  warnings,
  infos,
}

class PDFJS {
  /// the local copy of versionSafePdfJsContext once initialized
  static JsObject _pdfJsContext;

  /// the local copy of versionSafePdfJsViewerContext once initialized
  static JsObject _pdfJsViewerContext;

  /// Getter for obtaining the pdfjs context for various versions
  /// of pdf.js
  static JsObject get versionSafePdfJsContext {
    if(_pdfJsContext != null) {
      return _pdfJsContext;
    }
    
    // ^v2.5.207
    if(context['pdfjsLib'] != null) {
      _pdfJsContext = context['pdfjsLib'] as JsObject;
      return _pdfJsContext;
    }
    // v1.10.90+4
    else if(context['PDFJS'] != null) {
      _pdfJsContext = context['PDFJS'] as JsObject;
      return _pdfJsContext;
    }

    return null;    
  }

  /// Getter for obtaining the pdfjs viewer context for various versions
  /// of pdf.js
  static JsObject get versionSafePdfJsViewerContext {
    if(_pdfJsViewerContext != null) {
      return _pdfJsViewerContext;
    }

    // ^v2.5.207
    if(context['pdfjsLib'] != null) {
      _pdfJsViewerContext = context['pdfjsViewer'] as JsObject;
      return _pdfJsViewerContext;
    }
    // v1.10.90+4
    else if(context['PDFJS'] != null) {
      _pdfJsViewerContext = context['PDFJS'] as JsObject;
      return _pdfJsViewerContext;
    }

    return null;
  }

  static bool get cMapPacked => versionSafePdfJsContext['cMapPacked'] as bool;
  static set cMapPacked(bool cMapPacked) {
    versionSafePdfJsContext['cMapPacked'] = cMapPacked;
  }

  static String get cMapUrl => versionSafePdfJsContext['cMapUrl'] as String;
  static set cMapUrl(String cMapUrl) {
    versionSafePdfJsContext['cMapUrl'] = cMapUrl;
  }

  static bool get disableAutoFetch => versionSafePdfJsContext['disableAutoFetch'] as bool;
  static set disableAutoFetch(bool disableAutoFetch) {
    versionSafePdfJsContext['disableAutoFetch'] = disableAutoFetch;
  }

  static bool get disableCreateObjectURL => versionSafePdfJsContext['disableCreateObjectURL'] as bool;
  static set disableCreateObjectURL(bool disableCreateObjectURL) {
    versionSafePdfJsContext['disableCreateObjectURL'] = disableCreateObjectURL;
  }

  static bool get disableFontFace => versionSafePdfJsContext['disableFontFace'] as bool;
  static set disableFontFace(bool disableFontFace) {
    versionSafePdfJsContext['disableFontFace'] = disableFontFace;
  }

  static bool get disableRange => versionSafePdfJsContext['disableRange'] as bool;
  static set disableRange(bool disableRange) {
    versionSafePdfJsContext['disableRange'] = disableRange;
  }

  static bool get disableStream => versionSafePdfJsContext['disableStream'] as bool;
  static set disableStream(bool disableStream) {
    versionSafePdfJsContext['disableStream'] = disableStream;
  }

  static bool get disableWebGL => versionSafePdfJsContext['disableWebGL'] as bool;
  static set disableWebGL(bool disableWebGL) {
    versionSafePdfJsContext['disableWebGL'] = disableWebGL;
  }

  static bool get disableWorker => versionSafePdfJsContext['disableWorker'] as bool;
  static set disableWorker(bool disableWorker) {
    versionSafePdfJsContext['disableWorker'] = disableWorker;
  }

  static String get externalLinkRel => versionSafePdfJsContext['externalLinkRel'] as String;
  static set externalLinkRel(String externalLinkRel) {
    versionSafePdfJsContext['externalLinkRel'] = externalLinkRel;
  }

  static LinkTarget get externalLinkTarget => _linkTargetPdfjsToDart[versionSafePdfJsContext['externalLinkTarget']];
  static set externalLinkTarget(LinkTarget externalLinkTarget) {
    versionSafePdfJsContext['externalLinkTarget'] = _linkTargetDartToPdfjs[externalLinkTarget];
  }

  static String get imageResourcesPath => versionSafePdfJsContext['imageResourcesPath'] as String;
  static set imageResourcesPath(String imageResourcesPath) {
    versionSafePdfJsContext['imageResourcesPath'] = imageResourcesPath;
  }

  static bool get isEvalSupported => versionSafePdfJsContext['isEvalSupported'] as bool;
  static set isEvalSupported(bool isEvalSupported) {
    versionSafePdfJsContext['isEvalSupported'] = isEvalSupported;
  }

  static int get maxImageSize => versionSafePdfJsContext['maxImageSize'] as int;
  static set maxImageSize(int maxImageSize) {
    versionSafePdfJsContext['maxImageSize'] = maxImageSize;
  }

  static bool get pdfBug => versionSafePdfJsContext['pdfBug'] as bool;
  static set pdfBug(bool pdfBug) {
    versionSafePdfJsContext['pdfBug'] = pdfBug;
  }

  static bool get pdfjsNext => versionSafePdfJsContext['pdfjsNext'] as bool;
  static set pdfjsNext(bool pdfjsNext) {
    versionSafePdfJsContext['pdfjsNext'] = pdfjsNext;
  }

  static bool get postMessageTransfers => versionSafePdfJsContext['postMessageTransfers'] as bool;
  static set postMessageTransfers(bool postMessageTransfers) {
    versionSafePdfJsContext['postMessageTransfers'] = postMessageTransfers;
  }

  static VERBOSITY_LEVELS get verbosity => _verbosityLevelsPdfjsToDart[versionSafePdfJsContext['verbosity']];
  static set verbosity(VERBOSITY_LEVELS verbosity) {
    versionSafePdfJsContext['verbosity'] = _verbosityLevelsDartToPdfjs[verbosity];
  }

  static int get workerPort => versionSafePdfJsContext['workerPort'] as int;
  static set workerPort(int workerPort) {
    versionSafePdfJsContext['workerPort'] = workerPort;
  }

  static String get workerSrc => versionSafePdfJsContext['workerSrc'] as String;
  static set workerSrc(String workerSrc) {
    versionSafePdfJsContext['workerSrc'] = workerSrc;
  }

  // getDocument methods

  @deprecated
  static PDFDocumentLoadingTask getDocument(dynamic src) {
    JsObject documentTask = versionSafePdfJsContext.callMethod('getDocument', [src]) as JsObject;

    return PDFDocumentLoadingTask._withJsInternal(documentTask);
  }

  static PDFDocumentLoadingTask getDocumentByDocumentInitParameters(DocumentInitParameters src) {
    // ignore: deprecated_member_use
    return getDocument(src._jsInternal);
  }

  static PDFDocumentLoadingTask getDocumentByString(String src) {
    // ignore: deprecated_member_use
    return getDocument(src);
  }

  static PDFDocumentLoadingTask getDocumentByTypedArray(TypedData src) {
    // ignore: deprecated_member_use
    return getDocument(src);
  }

  static PDFDocumentLoadingTask getDocumentByPDFDataRangeTransport(PDFDataRangeTransport src) {
    // ignore: deprecated_member_use
    return getDocument(src._jsInternal);
  }

  // enum translation functionality

  // FOOTGUN: Both this list and the following list must be kept in
  // corresponding order
  static List<int> _pdfjsVerbosityLevels = [
    versionSafePdfJsContext['VERBOSITY_LEVELS']['errors'] as int,
    versionSafePdfJsContext['VERBOSITY_LEVELS']['warnings'] as int,
    versionSafePdfJsContext['VERBOSITY_LEVELS']['infos'] as int,
  ];

  // FOOTGUN: Both this list and the preceding list must be kept in
  // corresponding order
  static List<VERBOSITY_LEVELS> _dartVerbosityLevels = [
    VERBOSITY_LEVELS.errors,
    VERBOSITY_LEVELS.warnings,
    VERBOSITY_LEVELS.infos,
  ];

  static Map<int, VERBOSITY_LEVELS> _verbosityLevelsPdfjsToDart =
      Map.fromIterables(_pdfjsVerbosityLevels, _dartVerbosityLevels);

  static Map<VERBOSITY_LEVELS, int> _verbosityLevelsDartToPdfjs =
      Map.fromIterables(_dartVerbosityLevels, _pdfjsVerbosityLevels);

  // FOOTGUN: Both this list and the following list must be kept in
  // corresponding order
  static List<int> _pdfjsLinkTarget = [
    versionSafePdfJsContext['LinkTarget']['NONE'] as int,
    versionSafePdfJsContext['LinkTarget']['SELF'] as int,
    versionSafePdfJsContext['LinkTarget']['BLANK'] as int,
    versionSafePdfJsContext['LinkTarget']['PARENT'] as int,
    versionSafePdfJsContext['LinkTarget']['TOP'] as int,
  ];

  // FOOTGUN: Both this list and the preceding list must be kept in
  // corresponding order
  static List<LinkTarget> _dartLinkTarget = [
    LinkTarget.NONE,
    LinkTarget.SELF,
    LinkTarget.BLANK,
    LinkTarget.PARENT,
    LinkTarget.TOP,
  ];

  static Map<int, LinkTarget> _linkTargetPdfjsToDart = Map.fromIterables(_pdfjsLinkTarget, _dartLinkTarget);

  static Map<LinkTarget, int> _linkTargetDartToPdfjs = Map.fromIterables(_dartLinkTarget, _pdfjsLinkTarget);
}
