From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: Don't get layout from mds for regular file which has been written.
Date: Thu, 11 Jul 2013 16:59:55 +0800
Message-ID: <201307111659490192618@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43345 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab3GKJAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 05:00:04 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so7303965pdj.17
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 02:00:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Rm9yIHJlZ3VsYXIgZmlsZSB3aGljaCBoYXMgYmVlbiB3cml0dGVuLCBpdCBjYW4ndCBjaGFuZ2Ug
bGF5b3V0Lg0KU28gaXQgY2FuIGdldCBsYXlvdXQgZnJvbSBsb2NhbCByYXRoZXIgdGhhbiBtZHMu
DQoNClNpZ25lZC1vZmYtYnk6IEppYW5wZW5nIE1hIDxtYWppYW5wZW5nQGdtYWlsLmNvbT4NCi0t
LQ0KIGZzL2NlcGgvaW9jdGwuYyB8IDEwICsrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9pb2N0
bC5jIGIvZnMvY2VwaC9pb2N0bC5jDQppbmRleCBlMGI0ZWYzLi4yYjc0ODc5IDEwMDY0NA0KLS0t
IGEvZnMvY2VwaC9pb2N0bC5jDQorKysgYi9mcy9jZXBoL2lvY3RsLmMNCkBAIC0xNywxMCArMTcs
MTYgQEANCiBzdGF0aWMgbG9uZyBjZXBoX2lvY3RsX2dldF9sYXlvdXQoc3RydWN0IGZpbGUgKmZp
bGUsIHZvaWQgX191c2VyICphcmcpDQogew0KIAlzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvICpjaSA9
IGNlcGhfaW5vZGUoZmlsZV9pbm9kZShmaWxlKSk7DQorCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBm
aWxlX2lub2RlKGZpbGUpOw0KIAlzdHJ1Y3QgY2VwaF9pb2N0bF9sYXlvdXQgbDsNCi0JaW50IGVy
cjsNCisJaW50IGVyciA9IDA7DQorDQorCS8qRm9yIHJlZ3VsYXIgZmlsZSB3aGljaCBoYXMgYmVl
biB3cml0dGVuLGl0IGNhbid0IGNoYW5nZSBsYXlvdXQNCisJICogU28gaXQgZG9uJ3QgZ2V0IGxh
eW91dCBmcm9tIG1kcyovDQorCWlmICghKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgJiYgKGlfc2l6
ZV9yZWFkKGlub2RlKSA+IDAgfHwNCisJCWNpLT5pX3RydW5jYXRlX3NlcSA+IDEpKSkNCisJCWVy
ciA9IGNlcGhfZG9fZ2V0YXR0cihmaWxlX2lub2RlKGZpbGUpLCBDRVBIX1NUQVRfQ0FQX0xBWU9V
VCk7DQogDQotCWVyciA9IGNlcGhfZG9fZ2V0YXR0cihmaWxlX2lub2RlKGZpbGUpLCBDRVBIX1NU
QVRfQ0FQX0xBWU9VVCk7DQogCWlmICghZXJyKSB7DQogCQlsLnN0cmlwZV91bml0ID0gY2VwaF9m
aWxlX2xheW91dF9zdShjaS0+aV9sYXlvdXQpOw0KIAkJbC5zdHJpcGVfY291bnQgPSBjZXBoX2Zp
bGVfbGF5b3V0X3N0cmlwZV9jb3VudChjaS0+aV9sYXlvdXQpOw0KLS0gDQoxLjguMS4yDQo=

