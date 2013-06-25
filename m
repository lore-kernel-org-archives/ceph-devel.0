From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH][TRIVIAL] ceph: Free the previous caps if alloc failed.
Date: Tue, 25 Jun 2013 15:27:44 +0800
Message-ID: <201306251527405618532@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58427 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3FYH1r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 03:27:47 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so12142732pab.6
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jun 2013 00:27:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

U2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQog
ZnMvY2VwaC9jYXBzLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9jYXBzLmMgYi9mcy9jZXBoL2NhcHMuYw0KaW5kZXgg
ZGEwZjliOC4uNjI2YjBlYyAxMDA2NDQNCi0tLSBhL2ZzL2NlcGgvY2Fwcy5jDQorKysgYi9mcy9j
ZXBoL2NhcHMuYw0KQEAgLTIwMyw2ICsyMDMsMTEgQEAgb3V0X2FsbG9jX2NvdW50Og0KIAkvKiB3
ZSBkaWRuJ3QgbWFuYWdlIHRvIHJlc2VydmUgYXMgbXVjaCBhcyB3ZSBuZWVkZWQgKi8NCiAJcHJf
d2FybmluZygicmVzZXJ2ZSBjYXBzIGN0eD0lcCBFTk9NRU0gbmVlZD0lZCBnb3Q9JWRcbiIsDQog
CQkgICBjdHgsIG5lZWQsIGhhdmUpOw0KKwlpZiAoYWxsb2MpIHsNCisJCXN0cnVjdCBjZXBoX2Nh
cCAqdG1wOw0KKwkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGNhcCwgdG1wLCAmbmV3Y2Fwcywg
Y2Fwc19pdGVtKQ0KKwkJCWttZW1fY2FjaGVfZnJlZShjZXBoX2NhcF9jYWNoZXAsIGNhcCk7DQor
CX0NCiAJcmV0dXJuIHJldDsNCiB9DQogDQotLSANCjEuOC4xLjINCg==

