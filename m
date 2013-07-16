From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 0/2] libceph: handle notarget requests.
Date: Tue, 16 Jul 2013 15:45:44 +0800
Message-ID: <201307161545418344598@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33734 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab3GPHps (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 03:45:48 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so396352pdi.41
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 00:45:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

SW4gZnVuYyBjZXBoX29zZGNfc3RhcnRfcmVxdWVzdCx0aGVyZSBhcmUgdHdvIHR5cGVzOg0KQTpu
b2ZhaWwgd2hpY2ggbWVhbiBpZiBtZXQgZXJyb3IsIHRoZSByZXF1ZXN0IHdpbGwgcmV0cnkgdG8g
ZG8uDQpCOmZhaWwgd2hpY2ggbWVhbiBpZiBtZXQgZXJyb3IsIHRoZSBjYWxsZXIgaGFuZGxlIHRo
ZSBlcnJvcixsaWtlIHJlYWxzZSB0aG9zZSByZWxhdGl2ZSBwYWdlcy4NCg0KQnV0IG5vdywgdGhl
IGNvZGUgZG9uJ3QgZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGVtLg0KRm9yIGNhbGxlciB3aGljaCBj
YW4gbWV0IGVycm9yLCBpdCBtdXN0IGNhbGwgX191bnJlZ2lzdGVyX3JlcXVlc3QgaWYgbWV0IGVy
cm9yLkl0IGRvbid0IG1ha2UgYW55IHNlbnNlIHRvIHJldHJ5IHRvIGRvIGJlY2F1c2UgdGhlIGNh
bGxlcg0KYWxyZWF5IGhhbmRsZSBmYWlsZWQgcm91dGluZSBsaWtlIHJlbGVhc2UgcGFwZ2VzLg0K
Rm9yIHJlcXVlc3RzIHdoaWNoIGluIHJlcV9ub3RhcmdldCx0aGV5IG9ubHkgcmVtYXAgaW4gZnVu
YyBjZXBoX29zZGNfaGFuZGxlX21hcCB3aGljaCB1cGRhdGUgdGhlIGVwb2NoIG9mIG9zZG1hcC4N
CkJ1dCBmb3IgcmVhc2VvbiB3aGljaCBjYXVzZSBfX21hcF9yZXF1ZXN0IGZhaWxlZCBsaWtlIEVO
T01FTSxpdCB3b24ndCB1cGRhdGUgdGhlIGVwb2NoIG9mIG9zZG1hcCxzbyBub3RhcmdldC1yZXF1
ZXN0cyB3b24ndCByZW1hcCBmb3IgZXZlci4NCg0KDQoNCkppYW5wZW5nIE1hICgyKToNCiAgbGli
Y2VwaDogRm9yIG5vZmFpbCA9PSBmYWxzZSwgaWYgX19tYXBfcmVxdWVzdCBmYWlsZWQsaXQgc2hv
dWxkIHVucmVnaXN0ZXIuDQogIGxpYmNlcGg6IFJlbWFwIG5vdGFyZ2V0IHJlcXVlc3RzIGluIGhh
bmRsZV90aW1lb3V0Lg0KDQogbmV0L2NlcGgvb3NkX2NsaWVudC5jIHwgMzkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSk=

