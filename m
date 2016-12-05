From: xxhdx1985126 <xxhdx1985126@163.com>
Subject: question about ReplicatedPG::do_op
Date: Mon, 5 Dec 2016 17:07:08 +0800 (CST)
Message-ID: <5b867a2e.bca8.158ce3c9b56.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m50-156.163.com ([123.125.50.156]:55103 "EHLO m50-156.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbcLEJio (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 04:38:44 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

SGkswqBldmVyeW9uZS4KCkknbSB0cnlpbmcgdG8gcmVhZCB0aGUgc291cmNlIGNvZGUgb2YgY2Vw
aCdzIHJlYWQvd3JpdGUgb3BlcmF0aW9uIHByb2Nlc3NpbmcuIEluIFJlcGxpY2F0ZWRQRzo6ZG9f
b3AsIEkgZm91bmQgdGhhdCB3aGVuIHRoZSBjYWxsIHRvICJnZXRfcndfbG9ja3Mod3JpdGVfb3Jk
ZXJlZCwgY3R4KSIgZmFpbCwgYXMgc2hvd2VkIGluIHRoZSBmb2xsb3dpbmcsIHRoZSBtZXRob2Qg
UmVwbGljYXRlZFBHOjpkb19vcCB3aWxsIHJldHVybi4gSG93ZXZlciwgd2hlbiBSZXBsaWNhdGVk
UEc6OmRvX29wIGlzIGNhbGxlZCwgdGhlIG9wIGlzIGRlcXVldWVkIGZyb20gdGhlIG9zZF9vcF93
cSwgd291bGRuJ3QgdGhlIG9wIGJlIGxvc3QgaWYgZG9fb3AgcmV0dXJuIHdpdGhvdXQgcmVxdWV1
ZWluZyB0aGUgb3A/ICBJZiBpdCBpcyBsb3N0LCB3b3VsZG4ndCB0aGlzIGxlYWQgdG8gYW4gZXJy
b3I/ICBUaGFua3MuCgogICAgICAgICBlbHNlIGlmICghZ2V0X3J3X2xvY2tzKHdyaXRlX29yZGVy
ZWQsIGN0eCkpIHsKCQlkb3V0KDIwKQoJCQkJCTw8IF9fZnVuY19fIDw8ICIgd2FpdGluZyBmb3Ig
cncgbG9ja3MgIiA8PCBkZW5kbDsKCQlvcC0+bWFya19kZWxheWVkKCJ3YWl0aW5nIGZvciBydyBs
b2NrcyIpOwoJCWNsb3NlX29wX2N0eChjdHgsIC1FQlVTWSk7CgkJcmV0dXJuOwoJfQ==
