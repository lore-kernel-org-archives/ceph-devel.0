From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph python crash dumps
Date: Tue, 3 Jan 2017 16:39:01 -0500
Message-ID: <CAGbvivK+Rec86bxhW_Sq6tOR0fJpLRcZqVpkNXAkq_MvTMQipA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35145 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdACVjC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 16:39:02 -0500
Received: by mail-it0-f53.google.com with SMTP id c20so293804089itb.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 13:39:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I have a python based WSGI application running inside Apache that uses the
ceph python bindings to perform some operations.  Recently its been
throwing exceptions when trying to make ceph connections, but I can't
figure out what is really causing the issue here.

Running ceph 10.2.5 with latest python-ceph packages.

Anyone seen this sort of thing before or have any idea how to prevent it?

The following error appears in the Apache error logs:

common/ceph_crypto.cc: In function 'void ceph::crypto::init(CephContext*)'
thread 7fb1ca8c4700 time 2017-01-03 16:25:31.334606
common/ceph_crypto.cc: 77: FAILED assert(crypto_context != __null)
 ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
 1: (()+0x169b7b) [0x7fb1b1b82b7b]
 2: (()+0x1b88c0) [0x7fb1b1bd18c0]
 3: (()+0x184615) [0x7fb1b1b9d615]
 4: (()+0x181800) [0x7fb1b1b9a800]
 5: (()+0x95f2d) [0x7fb1b1aaef2d]
 6: (rados_connect()+0x1c) [0x7fb1b1a7dadc]
 7: (()+0x29070) [0x7fb1bb1a4070]
 8: (PyEval_EvalFrameEx()+0x4d4e) [0x7fb1d9fb324e]
 9: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 10: (PyEval_EvalFrameEx()+0x48d8) [0x7fb1d9fb2dd8]
 11: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 12: (PyEval_EvalFrameEx()+0x48d8) [0x7fb1d9fb2dd8]
 13: (PyEval_EvalFrameEx()+0x4b59) [0x7fb1d9fb3059]
 14: (PyEval_EvalFrameEx()+0x4b59) [0x7fb1d9fb3059]
 15: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 16: (()+0x1c37a5) [0x7fb1d9fe97a5]
 17: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 18: (()+0xbb7bd) [0x7fb1d9ee17bd]
 19: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 20: (()+0x13467f) [0x7fb1d9f5a67f]
 21: (()+0x13268f) [0x7fb1d9f5868f]
 22: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 23: (PyEval_EvalFrameEx()+0x2316) [0x7fb1d9fb0816]
 24: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 25: (()+0x1c37a5) [0x7fb1d9fe97a5]
 26: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 27: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 28: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 29: (()+0x1c37a5) [0x7fb1d9fe97a5]
 30: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 31: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 32: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 33: (()+0x1c37a5) [0x7fb1d9fe97a5]
 34: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 35: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 36: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 37: (()+0x1c37a5) [0x7fb1d9fe97a5]
 38: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 39: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 40: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 41: (()+0x1c37a5) [0x7fb1d9fe97a5]
 42: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 43: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 44: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 45: (()+0x1c37a5) [0x7fb1d9fe97a5]
 46: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 47: (PyEval_EvalFrameEx()+0xeb1) [0x7fb1d9faf3b1]
 48: (PyEval_EvalFrameEx()+0x4b59) [0x7fb1d9fb3059]
 49: (PyEval_EvalFrameEx()+0x4b59) [0x7fb1d9fb3059]
 50: (PyEval_EvalFrameEx()+0x4b59) [0x7fb1d9fb3059]
 51: (PyEval_EvalCodeEx()+0x80d) [0x7fb1d9fb454d]
 52: (()+0x1c36d0) [0x7fb1d9fe96d0]
 53: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 54: (()+0xbb7bd) [0x7fb1d9ee17bd]
 55: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 56: (()+0x1347e5) [0x7fb1d9f5a7e5]
 57: (PyObject_Call()+0x43) [0x7fb1d9f55d43]
 58: (PyEval_CallObjectWithKeywords()+0x47) [0x7fb1d9fce577]
 59: (()+0x17644) [0x7fb1da3a1644]
 60: (()+0x1dba8) [0x7fb1da3a7ba8]
 61: (()+0x8184) [0x7fb1de916184]
 62: (clone()+0x6d) [0x7fb1de64337d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
to interpret this.
