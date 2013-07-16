From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: Don't forget the 'up_read(&osdc->map_sem)' if met error.
Date: Tue, 16 Jul 2013 19:36:21 +0800
Message-ID: <201307161936127882610@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62388 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab3GPLi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 07:38:27 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so582404pde.18
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 04:38:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

U2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQog
ZnMvY2VwaC9pb2N0bC5jIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9pb2N0bC5jIGIvZnMvY2Vw
aC9pb2N0bC5jDQppbmRleCBlMGI0ZWYzLi5hNWNlNjJlIDEwMDY0NA0KLS0tIGEvZnMvY2VwaC9p
b2N0bC5jDQorKysgYi9mcy9jZXBoL2lvY3RsLmMNCkBAIC0xOTYsOCArMTk2LDEwIEBAIHN0YXRp
YyBsb25nIGNlcGhfaW9jdGxfZ2V0X2RhdGFsb2Moc3RydWN0IGZpbGUgKmZpbGUsIHZvaWQgX191
c2VyICphcmcpDQogCXIgPSBjZXBoX2NhbGNfZmlsZV9vYmplY3RfbWFwcGluZygmY2ktPmlfbGF5
b3V0LCBkbC5maWxlX29mZnNldCwgbGVuLA0KIAkJCQkJICAmZGwub2JqZWN0X25vLCAmZGwub2Jq
ZWN0X29mZnNldCwNCiAJCQkJCSAgJm9sZW4pOw0KLQlpZiAociA8IDApDQorCWlmIChyIDwgMCkg
ew0KKwkJdXBfcmVhZCgmb3NkYy0+bWFwX3NlbSk7DQogCQlyZXR1cm4gLUVJTzsNCisJfQ0KIAlk
bC5maWxlX29mZnNldCAtPSBkbC5vYmplY3Rfb2Zmc2V0Ow0KIAlkbC5vYmplY3Rfc2l6ZSA9IGNl
cGhfZmlsZV9sYXlvdXRfb2JqZWN0X3NpemUoY2ktPmlfbGF5b3V0KTsNCiAJZGwuYmxvY2tfc2l6
ZSA9IGNlcGhfZmlsZV9sYXlvdXRfc3UoY2ktPmlfbGF5b3V0KTsNCi0tIA0KMS44LjEuMg==

