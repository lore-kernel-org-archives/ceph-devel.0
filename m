From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: Don't do set_layout for file which has been written.
Date: Thu, 11 Jul 2013 10:04:49 +0800
Message-ID: <201307111004467716774@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922Ab3GKCFB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 22:05:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7368550pbb.33
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 19:05:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Q2VwaGZzIGRvbid0IGNoYW5nZSB0aGUgbGF5b3V0IHdoaWNoIGhhcyBiZWVuIHdyaXR0ZW4uU28g
YWRkIHRoaXMgY2hlY2sNCmJlZm9yZSBkby4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEg
PG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQogZnMvY2VwaC9pb2N0bC5jIHwgMyArKysNCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy9jZXBoL2lv
Y3RsLmMgYi9mcy9jZXBoL2lvY3RsLmMNCmluZGV4IGUwYjRlZjMuLmNiZWE4OTYgMTAwNjQ0DQot
LS0gYS9mcy9jZXBoL2lvY3RsLmMNCisrKyBiL2ZzL2NlcGgvaW9jdGwuYw0KQEAgLTcyLDYgKzcy
LDkgQEAgc3RhdGljIGxvbmcgY2VwaF9pb2N0bF9zZXRfbGF5b3V0KHN0cnVjdCBmaWxlICpmaWxl
LCB2b2lkIF9fdXNlciAqYXJnKQ0KIAlzdHJ1Y3QgY2VwaF9pb2N0bF9sYXlvdXQgbmw7DQogCWlu
dCBlcnI7DQogDQorCS8qT25seSBmb3IgZmlsZSB3aGljaCBoYXMgbmV2ZXIgYmVlbiB3cml0dGVu
Ki8NCisJaWYgKGlfc2l6ZV9yZWFkKGlub2RlKSA+IDAgfHwgY2ktPmlfdHJ1bmNhdGVfc2VxID4g
MSkNCisJCXJldHVybiAtRU5PVEVNUFRZOw0KIAlpZiAoY29weV9mcm9tX3VzZXIoJmwsIGFyZywg
c2l6ZW9mKGwpKSkNCiAJCXJldHVybiAtRUZBVUxUOw0KIA0KLS0gDQoxLjguMS4yDQo=

