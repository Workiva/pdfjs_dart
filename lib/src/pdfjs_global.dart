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
  /// the local copy of _pdfJsContext once initialized
  static JsObject _pdfJsContext;

  /// Getter for obtaining the pdfjs context for various versions
  /// of pdf.js
  static JsObject get _versionSafePdfJsContext {
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

  static bool get cMapPacked => _versionSafePdfJsContext['cMapPacked'] as bool;
  static set cMapPacked(bool cMapPacked) {
    _versionSafePdfJsContext['cMapPacked'] = cMapPacked;
  }

  static String get cMapUrl => _versionSafePdfJsContext['cMapUrl'] as String;
  static set cMapUrl(String cMapUrl) {
    _versionSafePdfJsContext['cMapUrl'] = cMapUrl;
  }

  static bool get disableAutoFetch => _versionSafePdfJsContext['disableAutoFetch'] as bool;
  static set disableAutoFetch(bool disableAutoFetch) {
    _versionSafePdfJsContext['disableAutoFetch'] = disableAutoFetch;
  }

  static bool get disableCreateObjectURL => _versionSafePdfJsContext['disableCreateObjectURL'] as bool;
  static set disableCreateObjectURL(bool disableCreateObjectURL) {
    _versionSafePdfJsContext['disableCreateObjectURL'] = disableCreateObjectURL;
  }

  static bool get disableFontFace => _versionSafePdfJsContext['disableFontFace'] as bool;
  static set disableFontFace(bool disableFontFace) {
    _versionSafePdfJsContext['disableFontFace'] = disableFontFace;
  }

  static bool get disableRange => _versionSafePdfJsContext['disableRange'] as bool;
  static set disableRange(bool disableRange) {
    _versionSafePdfJsContext['disableRange'] = disableRange;
  }

  static bool get disableStream => _versionSafePdfJsContext['disableStream'] as bool;
  static set disableStream(bool disableStream) {
    _versionSafePdfJsContext['disableStream'] = disableStream;
  }

  static bool get disableWebGL => _versionSafePdfJsContext['disableWebGL'] as bool;
  static set disableWebGL(bool disableWebGL) {
    _versionSafePdfJsContext['disableWebGL'] = disableWebGL;
  }

  static bool get disableWorker => _versionSafePdfJsContext['disableWorker'] as bool;
  static set disableWorker(bool disableWorker) {
    _versionSafePdfJsContext['disableWorker'] = disableWorker;
  }

  static String get externalLinkRel => _versionSafePdfJsContext['externalLinkRel'] as String;
  static set externalLinkRel(String externalLinkRel) {
    _versionSafePdfJsContext['externalLinkRel'] = externalLinkRel;
  }

  static LinkTarget get externalLinkTarget => _linkTargetPdfjsToDart[_versionSafePdfJsContext['externalLinkTarget']];
  static set externalLinkTarget(LinkTarget externalLinkTarget) {
    _versionSafePdfJsContext['externalLinkTarget'] = _linkTargetDartToPdfjs[externalLinkTarget];
  }

  static String get imageResourcesPath => _versionSafePdfJsContext['imageResourcesPath'] as String;
  static set imageResourcesPath(String imageResourcesPath) {
    _versionSafePdfJsContext['imageResourcesPath'] = imageResourcesPath;
  }

  static bool get isEvalSupported => _versionSafePdfJsContext['isEvalSupported'] as bool;
  static set isEvalSupported(bool isEvalSupported) {
    _versionSafePdfJsContext['isEvalSupported'] = isEvalSupported;
  }

  static int get maxImageSize => _versionSafePdfJsContext['maxImageSize'] as int;
  static set maxImageSize(int maxImageSize) {
    _versionSafePdfJsContext['maxImageSize'] = maxImageSize;
  }

  static bool get pdfBug => _versionSafePdfJsContext['pdfBug'] as bool;
  static set pdfBug(bool pdfBug) {
    _versionSafePdfJsContext['pdfBug'] = pdfBug;
  }

  static bool get pdfjsNext => _versionSafePdfJsContext['pdfjsNext'] as bool;
  static set pdfjsNext(bool pdfjsNext) {
    _versionSafePdfJsContext['pdfjsNext'] = pdfjsNext;
  }

  static bool get postMessageTransfers => _versionSafePdfJsContext['postMessageTransfers'] as bool;
  static set postMessageTransfers(bool postMessageTransfers) {
    _versionSafePdfJsContext['postMessageTransfers'] = postMessageTransfers;
  }

  static VERBOSITY_LEVELS get verbosity => _verbosityLevelsPdfjsToDart[_versionSafePdfJsContext['verbosity']];
  static set verbosity(VERBOSITY_LEVELS verbosity) {
    _versionSafePdfJsContext['verbosity'] = _verbosityLevelsDartToPdfjs[verbosity];
  }

  static int get workerPort => _versionSafePdfJsContext['workerPort'] as int;
  static set workerPort(int workerPort) {
    _versionSafePdfJsContext['workerPort'] = workerPort;
  }

  static String get workerSrc => _versionSafePdfJsContext['workerSrc'] as String;
  static set workerSrc(String workerSrc) {
    _versionSafePdfJsContext['workerSrc'] = workerSrc;
  }

  // getDocument methods

  @deprecated
  static PDFDocumentLoadingTask getDocument(dynamic src) {
    JsObject documentTask = _versionSafePdfJsContext.callMethod('getDocument', [src]) as JsObject;

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
    _versionSafePdfJsContext['VERBOSITY_LEVELS']['errors'] as int,
    _versionSafePdfJsContext['VERBOSITY_LEVELS']['warnings'] as int,
    _versionSafePdfJsContext['VERBOSITY_LEVELS']['infos'] as int,
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
    _versionSafePdfJsContext['LinkTarget']['NONE'] as int,
    _versionSafePdfJsContext['LinkTarget']['SELF'] as int,
    _versionSafePdfJsContext['LinkTarget']['BLANK'] as int,
    _versionSafePdfJsContext['LinkTarget']['PARENT'] as int,
    _versionSafePdfJsContext['LinkTarget']['TOP'] as int,
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
