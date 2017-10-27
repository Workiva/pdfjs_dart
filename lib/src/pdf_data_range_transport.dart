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

abstract class PDFDataRangeTransport {
  JsObject _jsInternal;

  PDFDataRangeTransport(int length, Uint8List initialData) {
    _jsInternal = new JsObject(context['PDFJS']['PDFDataRangeTransport'], [
      length,
      initialData,
    ]);

    _jsInternal['abort'] = this.abort;
    _jsInternal['requestDataRange'] = this.requestDataRange;
  }

  void abort() {}

  void onDataProgress(int loaded) {
    _jsInternal['onDataProgress'].apply([loaded], thisArg: _jsInternal);
  }

  void onDataProgressiveRead(Uint8List chunk) {
    _jsInternal['onDataProgressiveRead'].apply([chunk], thisArg: _jsInternal);
  }

  void onDataRange(int begin, Uint8List chunk) {
    _jsInternal['onDataRange'].apply([begin, chunk], thisArg: _jsInternal);
  }

  void requestDataRange(int begin, int end);

  void transportReady() {
    _jsInternal['transportReady'].apply([], thisArg: _jsInternal);
  }
}
