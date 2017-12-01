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

enum NativeImageDecoderSupport {
  decode,
  display,
  none,
}

class DocumentInitParameters {
  Map<String, dynamic> _jsInternal;
  PDFDataRangeTransport _range;

  DocumentInitParameters() {
    _jsInternal = new Map<String, dynamic>();
  }

  TypedData get data => _jsInternal['data'];
  set data(TypedData data) {
    _jsInternal['data'] = data;
  }

  String get docBaseUrl => _jsInternal['docBaseUrl'];
  set docBaseUrl(String docBaseUrl) {
    _jsInternal['docBaseUrl'] = docBaseUrl;
  }

  TypedData get initialData => _jsInternal['initialData'];
  set initialData(TypedData initialData) {
    _jsInternal['initialData'] = initialData;
  }

  Map<String, dynamic> get httpHeaders => _jsInternal['httpHeaders'];
  set httpHeaders(Map<String, dynamic> httpHeaders) {
    _jsInternal['httpHeaders'] = httpHeaders;
  }

  int get length => _jsInternal['length'];
  set length(int length) {
    _jsInternal['length'] = length;
  }

  NativeImageDecoderSupport get nativeImageDecoderSupport =>
      _nativeImageDecoderSupportPdfjsToDart[
          _jsInternal['nativeImageDecoderSupport']];
  set nativeImageDecoderSupport(
      NativeImageDecoderSupport nativeImageDecoderSupport) {
    _jsInternal['nativeImageDecoderSupport'] =
        _nativeImageDecoderSupportDartToPdfjs[nativeImageDecoderSupport];
  }

  String get password => _jsInternal['password'];
  set password(String password) {
    _jsInternal['password'] = password;
  }

  PDFDataRangeTransport get range => _range;
  set range(PDFDataRangeTransport range) {
    _jsInternal['range'] = range;

    // It's not ideal that we store this, but PDF.js shouldn't be setting this
    // property and we can't properly recreate the original object
    _range = range;
  }

  int get rangeChunkSize => _jsInternal['rangeChunkSize'];
  set rangeChunkSize(int rangeChunkSize) {
    _jsInternal['rangeChunkSize'] = rangeChunkSize;
  }

  bool get stopAtErrors => _jsInternal['stopAtErrors'];
  set stopAtErrors(bool stopAtErrors) {
    _jsInternal['stopAtErrors'] = stopAtErrors;
  }

  String get url => _jsInternal['url'];
  set url(String url) {
    _jsInternal['url'] = url;
  }

  bool get withCredentials => _jsInternal['withCredentials'];
  set withCredentials(bool withCredentials) {
    _jsInternal['withCredentials'] = withCredentials;
  }

  // FOOTGUN: Both this list and the following list must be kept in
  // corresponding order
  static List<String> _pdfjsNativeImageDecoderSupport = [
    'decode',
    'display',
    'none',
  ];

  // FOOTGUN: Both this list and the preceding list must be kept in
  // corresponding order
  static List<NativeImageDecoderSupport> _dartNativeImageDecoderSupport = [
    NativeImageDecoderSupport.decode,
    NativeImageDecoderSupport.display,
    NativeImageDecoderSupport.none,
  ];

  static Map<String, NativeImageDecoderSupport>
      _nativeImageDecoderSupportPdfjsToDart = new Map.fromIterables(
          _pdfjsNativeImageDecoderSupport, _dartNativeImageDecoderSupport);

  static Map<NativeImageDecoderSupport, String>
      _nativeImageDecoderSupportDartToPdfjs = new Map.fromIterables(
          _dartNativeImageDecoderSupport, _pdfjsNativeImageDecoderSupport);
}
