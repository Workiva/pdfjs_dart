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
  static final JsObject _pdfjsContext = context['PDFJS'];

  static bool get cMapPacked => _pdfjsContext['cMapPacked'];
  static set cMapPacked(bool cMapPacked) {
    _pdfjsContext['cMapPacked'] = cMapPacked;
  }

  static String get cMapUrl => _pdfjsContext['cMapUrl'];
  static set cMapUrl(String cMapUrl) {
    _pdfjsContext['cMapUrl'] = cMapUrl;
  }

  static bool get disableAutoFetch => _pdfjsContext['disableAutoFetch'];
  static set disableAutoFetch(bool disableAutoFetch) {
    _pdfjsContext['disableAutoFetch'] = disableAutoFetch;
  }

  static bool get disableCreateObjectURL =>
      _pdfjsContext['disableCreateObjectURL'];
  static set disableCreateObjectURL(bool disableCreateObjectURL) {
    _pdfjsContext['disableCreateObjectURL'] = disableCreateObjectURL;
  }

  static bool get disableFontFace => _pdfjsContext['disableFontFace'];
  static set disableFontFace(bool disableFontFace) {
    _pdfjsContext['disableFontFace'] = disableFontFace;
  }

  static bool get disableRange => _pdfjsContext['disableRange'];
  static set disableRange(bool disableRange) {
    _pdfjsContext['disableRange'] = disableRange;
  }

  static bool get disableStream => _pdfjsContext['disableStream'];
  static set disableStream(bool disableStream) {
    _pdfjsContext['disableStream'] = disableStream;
  }

  static bool get disableWebGL => _pdfjsContext['disableWebGL'];
  static set disableWebGL(bool disableWebGL) {
    _pdfjsContext['disableWebGL'] = disableWebGL;
  }

  static bool get disableWorker => _pdfjsContext['disableWorker'];
  static set disableWorker(bool disableWorker) {
    _pdfjsContext['disableWorker'] = disableWorker;
  }

  static String get externalLinkRel => _pdfjsContext['externalLinkRel'];
  static set externalLinkRel(String externalLinkRel) {
    _pdfjsContext['externalLinkRel'] = externalLinkRel;
  }

  static LinkTarget get externalLinkTarget =>
      _linkTargetPdfjsToDart[_pdfjsContext['externalLinkTarget']];
  static set externalLinkTarget(LinkTarget externalLinkTarget) {
    _pdfjsContext['externalLinkTarget'] =
        _linkTargetDartToPdfjs[externalLinkTarget];
  }

  static String get imageResourcesPath => _pdfjsContext['imageResourcesPath'];
  static set imageResourcesPath(String imageResourcesPath) {
    _pdfjsContext['imageResourcesPath'] = imageResourcesPath;
  }

  static bool get isEvalSupported => _pdfjsContext['isEvalSupported'];
  static set isEvalSupported(bool isEvalSupported) {
    _pdfjsContext['isEvalSupported'] = isEvalSupported;
  }

  static int get maxImageSize => _pdfjsContext['maxImageSize'];
  static set maxImageSize(int maxImageSize) {
    _pdfjsContext['maxImageSize'] = maxImageSize;
  }

  static bool get pdfBug => _pdfjsContext['pdfBug'];
  static set pdfBug(bool pdfBug) {
    _pdfjsContext['pdfBug'] = pdfBug;
  }

  static bool get pdfjsNext => _pdfjsContext['pdfjsNext'];
  static set pdfjsNext(bool pdfjsNext) {
    _pdfjsContext['pdfjsNext'] = pdfjsNext;
  }

  static bool get postMessageTransfers => _pdfjsContext['postMessageTransfers'];
  static set postMessageTransfers(bool postMessageTransfers) {
    _pdfjsContext['postMessageTransfers'] = postMessageTransfers;
  }

  static VERBOSITY_LEVELS get verbosity =>
      _verbosityLevelsPdfjsToDart[_pdfjsContext['verbosity']];
  static set verbosity(VERBOSITY_LEVELS verbosity) {
    _pdfjsContext['verbosity'] = _verbosityLevelsDartToPdfjs[verbosity];
  }

  static int get workerPort => _pdfjsContext['workerPort'];
  static set workerPort(int workerPort) {
    _pdfjsContext['workerPort'] = workerPort;
  }

  static String get workerSrc => _pdfjsContext['workerSrc'];
  static set workerSrc(String workerSrc) {
    _pdfjsContext['workerSrc'] = workerSrc;
  }

  // getDocument methods

  @deprecated
  static PDFDocumentLoadingTask getDocument(dynamic src) {
    JsObject documentTask = _pdfjsContext.callMethod('getDocument', [src]);

    return new PDFDocumentLoadingTask._withJsInternal(documentTask);
  }

  static PDFDocumentLoadingTask getDocumentByDocumentInitParameters(
      DocumentInitParameters src) {
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

  static PDFDocumentLoadingTask getDocumentByPDFDataRangeTransport(
      PDFDataRangeTransport src) {
    // ignore: deprecated_member_use
    return getDocument(src._jsInternal);
  }

  // enum translation functionality

  // FOOTGUN: Both this list and the following list must be kept in
  // corresponding order
  static List<int> _pdfjsVerbosityLevels = [
    _pdfjsContext['VERBOSITY_LEVELS']['errors'],
    _pdfjsContext['VERBOSITY_LEVELS']['warnings'],
    _pdfjsContext['VERBOSITY_LEVELS']['infos'],
  ];

  // FOOTGUN: Both this list and the preceding list must be kept in
  // corresponding order
  static List<VERBOSITY_LEVELS> _dartVerbosityLevels = [
    VERBOSITY_LEVELS.errors,
    VERBOSITY_LEVELS.warnings,
    VERBOSITY_LEVELS.infos,
  ];

  static Map<int, VERBOSITY_LEVELS> _verbosityLevelsPdfjsToDart =
      new Map.fromIterables(_pdfjsVerbosityLevels, _dartVerbosityLevels);

  static Map<VERBOSITY_LEVELS, int> _verbosityLevelsDartToPdfjs =
      new Map.fromIterables(_dartVerbosityLevels, _pdfjsVerbosityLevels);

  // FOOTGUN: Both this list and the following list must be kept in
  // corresponding order
  static List<int> _pdfjsLinkTarget = [
    _pdfjsContext['LinkTarget']['NONE'],
    _pdfjsContext['LinkTarget']['SELF'],
    _pdfjsContext['LinkTarget']['BLANK'],
    _pdfjsContext['LinkTarget']['PARENT'],
    _pdfjsContext['LinkTarget']['TOP'],
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

  static Map<int, LinkTarget> _linkTargetPdfjsToDart =
      new Map.fromIterables(_pdfjsLinkTarget, _dartLinkTarget);

  static Map<LinkTarget, int> _linkTargetDartToPdfjs =
      new Map.fromIterables(_dartLinkTarget, _pdfjsLinkTarget);
}
