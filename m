From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 1/2] ceph: update atime after read.
Date: Wed, 3 Jul 2013 13:34:56 +0800
Message-ID: <201307031334515420104@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50785 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3GCFfA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 01:35:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Tm93IGNlcGggZG9uJ3QgdXBkYXRlIGF0aW1lIGFmdGVyIHJlYWQuU28gYWRkIHRoaXMgZnVuY3Rp
b24uDQoNClNpZ25lZC1vZmYtYnk6IEppYW5wZW5nIE1hIDxtYWppYW5wZW5nQGdtYWlsLmNvbT4N
Ci0tLQ0KIGZzL2NlcGgvZmlsZS5jIHwgOSArKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy9jZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmls
ZS5jDQppbmRleCA2NTZlMTY5Li5mYTc0ZTZmIDEwMDY0NA0KLS0tIGEvZnMvY2VwaC9maWxlLmMN
CisrKyBiL2ZzL2NlcGgvZmlsZS5jDQpAQCAtNjY5LDYgKzY2OSwxNSBAQCBhZ2FpbjoNCiBvdXQ6
DQogCWRvdXQoImFpb19yZWFkICVwICVsbHguJWxseCBkcm9wcGluZyBjYXAgcmVmcyBvbiAlcyA9
ICVkXG4iLA0KIAkgICAgIGlub2RlLCBjZXBoX3Zpbm9wKGlub2RlKSwgY2VwaF9jYXBfc3RyaW5n
KGdvdCksIChpbnQpcmV0KTsNCisNCisJaWYgKHJldCA+IDApIHsNCisJCWludCBkaXJ0eTsNCisJ
CXNwaW5fbG9jaygmY2ktPmlfY2VwaF9sb2NrKTsNCisJCWRpcnR5ID0gX19jZXBoX21hcmtfZGly
dHlfY2FwcyhjaSwgQ0VQSF9DQVBfRklMRV9SRCk7DQorCQlzcGluX3VubG9jaygmY2ktPmlfY2Vw
aF9sb2NrKTsNCisJCWlmIChkaXJ0eSkNCisJCQlfX21hcmtfaW5vZGVfZGlydHkoaW5vZGUsIGRp
cnR5KTsNCisJfQ0KIAljZXBoX3B1dF9jYXBfcmVmcyhjaSwgZ290KTsNCiANCiAJaWYgKGNoZWNr
ZW9mICYmIHJldCA+PSAwKSB7DQotLSANCjEuOC4xLjINCg==

