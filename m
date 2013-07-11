From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph:Update the file time after mmap-write.
Date: Thu, 11 Jul 2013 09:17:18 +0800
Message-ID: <201307110917146231510@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33706 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab3GKBRh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 21:17:37 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so7231997pbb.8
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 18:17:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

QWx0aG91Z2gsIG1tYXAtd3JpdGUgb2YgY2VwaCB1cGRhdGUgdGhlIHRpbWUgb2YgZmlsZSB1c2lu
Zw0KZmlsZV91cGRhdGVfdGltZS5CZWNhdXNlIGl0IGRvbid0IG1hcmsgdGhlIHJlbGF0aXZlIGNh
cCBzbyB0aGUgdGltZQ0KY2FuJ3Qgc2F2ZS4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEg
PG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQogZnMvY2VwaC9hZGRyLmMgfCA4ICsrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvY2Vw
aC9hZGRyLmMgYi9mcy9jZXBoL2FkZHIuYw0KaW5kZXggMzhiNWMxYi4uNTJmN2M3YyAxMDA2NDQN
Ci0tLSBhL2ZzL2NlcGgvYWRkci5jDQorKysgYi9mcy9jZXBoL2FkZHIuYw0KQEAgLTEyMzEsMTAg
KzEyMzEsMTggQEAgc3RhdGljIGludCBjZXBoX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSwgc3RydWN0IHZtX2ZhdWx0ICp2bWYpDQogDQogCXJldCA9IGNlcGhfdXBkYXRl
X3dyaXRlYWJsZV9wYWdlKHZtYS0+dm1fZmlsZSwgb2ZmLCBsZW4sIHBhZ2UpOw0KIAlpZiAocmV0
ID09IDApIHsNCisJCWludCBkaXJ0eTsNCisJCXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpID0g
Y2VwaF9pbm9kZShpbm9kZSk7DQogCQkvKiBzdWNjZXNzLiAgd2UnbGwga2VlcCB0aGUgcGFnZSBs
b2NrZWQuICovDQogCQlzZXRfcGFnZV9kaXJ0eShwYWdlKTsNCiAJCXVwX3JlYWQoJm1kc2MtPnNu
YXBfcndzZW0pOw0KIAkJcmV0ID0gVk1fRkFVTFRfTE9DS0VEOw0KKw0KKwkJc3Bpbl9sb2NrKCZj
aS0+aV9jZXBoX2xvY2spOw0KKwkJZGlydHkgPSBfX2NlcGhfbWFya19kaXJ0eV9jYXBzKGNpLCBD
RVBIX0NBUF9GSUxFX1dSKTsNCisJCXNwaW5fdW5sb2NrKCZjaS0+aV9jZXBoX2xvY2spOw0KKwkJ
aWYgKGRpcnR5KQ0KKwkJICAgICAgIAlfX21hcmtfaW5vZGVfZGlydHkoaW5vZGUsIGRpcnR5KTsN
CiAJfSBlbHNlIHsNCiAJCWlmIChyZXQgPT0gLUVOT01FTSkNCiAJCQlyZXQgPSBWTV9GQVVMVF9P
T007DQotLSANCjEuOC4xLjINCg==

