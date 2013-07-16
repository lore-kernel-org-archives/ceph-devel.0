From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 1/2] libceph:  For nofail == false, if __map_request failed,it should unregister.
Date: Tue, 16 Jul 2013 15:45:48 +0800
Message-ID: <201307161545461466089@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52613 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab3GPHpw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 03:45:52 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so502426pad.28
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 00:45:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Rm9yIG5vZmFpbCA9PSBmYWxzZSAgcmVxdWVzdCwgaWYgX19tYXBfcmVxdWVzdCBmYWlsZWQsIHRo
ZSBjYWxsZXIgZG8NCmNsZWFudXAgd29yayxsaWtlIHJlbGVhc2UgdGhlIHJlbGF0aXZlIHBhZ2Vz
Lkl0IGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UNCnRvIHJldHJ5IHRoaXMgcmVxdWVzdC5TbyBvbmx5
IGdpdmUgdXAgaXQuDQoNClNpZ25lZC1vZmYtYnk6IEppYW5wZW5nIE1hIDxtYWppYW5wZW5nQGdt
YWlsLmNvbT4NCi0tLQ0KIG5ldC9jZXBoL29zZF9jbGllbnQuYyB8IDMgKystDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0
L2NlcGgvb3NkX2NsaWVudC5jIGIvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQppbmRleCBkZDQ3ODg5
Li43ZDQwYTYxIDEwMDY0NA0KLS0tIGEvbmV0L2NlcGgvb3NkX2NsaWVudC5jDQorKysgYi9uZXQv
Y2VwaC9vc2RfY2xpZW50LmMNCkBAIC0yMTI5LDcgKzIxMjksOCBAQCBpbnQgY2VwaF9vc2RjX3N0
YXJ0X3JlcXVlc3Qoc3RydWN0IGNlcGhfb3NkX2NsaWVudCAqb3NkYywNCiAJCQlkb3V0KCJvc2Rj
X3N0YXJ0X3JlcXVlc3QgZmFpbGVkIG1hcCwgIg0KIAkJCQkiIHdpbGwgcmV0cnkgJWxsZFxuIiwg
cmVxLT5yX3RpZCk7DQogCQkJcmMgPSAwOw0KLQkJfQ0KKwkJfSBlbHNlDQorCQkJX191bnJlZ2lz
dGVyX3JlcXVlc3Qob3NkYywgcmVxKTsNCiAJCWdvdG8gb3V0X3VubG9jazsNCiAJfQ0KIAlpZiAo
cmVxLT5yX29zZCA9PSBOVUxMKSB7DQotLSANCjEuOC4xLjINCg==

