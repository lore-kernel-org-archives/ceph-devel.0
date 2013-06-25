From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH][TRIVIAL] ceph: Free mdsc if alloc mdsc->mdsmap failed.
Date: Tue, 25 Jun 2013 14:48:19 +0800
Message-ID: <201306251448154186071@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51677 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3FYGsW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 02:48:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so12145708pac.29
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 23:48:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

U2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQog
ZnMvY2VwaC9tZHNfY2xpZW50LmMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19jbGllbnQu
YyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQppbmRleCA0ZDI5MjAzLi45ZmI1OGY2IDEwMDY0NA0K
LS0tIGEvZnMvY2VwaC9tZHNfY2xpZW50LmMNCisrKyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jDQpA
QCAtMzA0MCw4ICszMDQwLDEwIEBAIGludCBjZXBoX21kc2NfaW5pdChzdHJ1Y3QgY2VwaF9mc19j
bGllbnQgKmZzYykNCiAJZnNjLT5tZHNjID0gbWRzYzsNCiAJbXV0ZXhfaW5pdCgmbWRzYy0+bXV0
ZXgpOw0KIAltZHNjLT5tZHNtYXAgPSBremFsbG9jKHNpemVvZigqbWRzYy0+bWRzbWFwKSwgR0ZQ
X05PRlMpOw0KLQlpZiAobWRzYy0+bWRzbWFwID09IE5VTEwpDQorCWlmIChtZHNjLT5tZHNtYXAg
PT0gTlVMTCkgew0KKwkJa2ZyZWUobWRzYyk7DQogCQlyZXR1cm4gLUVOT01FTTsNCisJfQ0KIA0K
IAlpbml0X2NvbXBsZXRpb24oJm1kc2MtPnNhZmVfdW1vdW50X3dhaXRlcnMpOw0KIAlpbml0X3dh
aXRxdWV1ZV9oZWFkKCZtZHNjLT5zZXNzaW9uX2Nsb3NlX3dxKTsNCi0tIA0KMS44LjEuMg0K

