From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: Add check returned value on func ceph_calc_ceph_pg.
Date: Fri, 2 Aug 2013 18:14:48 +0800
Message-ID: <201308021814466765843@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:54952 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030658Ab3HBKOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 06:14:52 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so524661pbb.28
        for <ceph-devel@vger.kernel.org>; Fri, 02 Aug 2013 03:14:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

RnVuYyBjZXBoX2NhbGNfY2VwaF9wZyBtYXliZSBmYWlsZWQuU28gYWRkIGNoZWNrIGZvciByZXR1
cm5lZCB2YWx1ZS4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21h
aWwuY29tPg0KLS0tDQogZnMvY2VwaC9pb2N0bC5jIHwgOCArKysrKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9j
ZXBoL2lvY3RsLmMgYi9mcy9jZXBoL2lvY3RsLmMNCmluZGV4IGUwYjRlZjMuLjhjNDYzZGQgMTAw
NjQ0DQotLS0gYS9mcy9jZXBoL2lvY3RsLmMNCisrKyBiL2ZzL2NlcGgvaW9jdGwuYw0KQEAgLTIw
OSw4ICsyMDksMTIgQEAgc3RhdGljIGxvbmcgY2VwaF9pb2N0bF9nZXRfZGF0YWxvYyhzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgdm9pZCBfX3VzZXIgKmFyZykNCiAJc25wcmludGYoZGwub2JqZWN0X25hbWUs
IHNpemVvZihkbC5vYmplY3RfbmFtZSksICIlbGx4LiUwOGxseCIsDQogCQkgY2VwaF9pbm8oaW5v
ZGUpLCBkbC5vYmplY3Rfbm8pOw0KIA0KLQljZXBoX2NhbGNfY2VwaF9wZygmcGdpZCwgZGwub2Jq
ZWN0X25hbWUsIG9zZGMtPm9zZG1hcCwNCi0JCWNlcGhfZmlsZV9sYXlvdXRfcGdfcG9vbChjaS0+
aV9sYXlvdXQpKTsNCisJciA9IGNlcGhfY2FsY19jZXBoX3BnKCZwZ2lkLCBkbC5vYmplY3RfbmFt
ZSwgb3NkYy0+b3NkbWFwLA0KKwkJCQljZXBoX2ZpbGVfbGF5b3V0X3BnX3Bvb2woY2ktPmlfbGF5
b3V0KSk7DQorCWlmIChyIDwgMCkgew0KKwkJdXBfcmVhZCgmb3NkYy0+bWFwX3NlbSk7DQorCQly
ZXR1cm4gcjsNCisJfQ0KIA0KIAlkbC5vc2QgPSBjZXBoX2NhbGNfcGdfcHJpbWFyeShvc2RjLT5v
c2RtYXAsIHBnaWQpOw0KIAlpZiAoZGwub3NkID49IDApIHsNCi0tIA0KMS44LjEuMg0KDQoNClRo
YW5rcyENCkppYW5wZW5nIE1h

