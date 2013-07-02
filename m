From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 3/3] ceph: For ceph_sync_read, update the atime of file.
Date: Tue, 2 Jul 2013 13:45:17 +0800
Message-ID: <201307021345131042678@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Rm9yIGJ1ZmZlciByZWFkLCB0aGUgZnVuYyBnZW5lcmljX2ZpbGVfYWlvX3JlYWQgd2lsbCB1cGRh
dGUgYXRpbWUgb2YNCmZpbGUuQnV0IHRoZSBjZXBoX3N5bmNfcmVhZCBkb24ndCBkbyBpdC5TbyBh
ZGQgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwu
Y29tPg0KLS0tDQogZnMvY2VwaC9maWxlLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxl
LmMNCmluZGV4IDY1NmUxNjkuLjg3ZGYxNWEgMTAwNjQ0DQotLS0gYS9mcy9jZXBoL2ZpbGUuYw0K
KysrIGIvZnMvY2VwaC9maWxlLmMNCkBAIC00NDIsNiArNDQyLDkgQEAgZG9uZToNCiAJCWNlcGhf
cHV0X3BhZ2VfdmVjdG9yKHBhZ2VzLCBudW1fcGFnZXMsIHRydWUpOw0KIAllbHNlDQogCQljZXBo
X3JlbGVhc2VfcGFnZV92ZWN0b3IocGFnZXMsIG51bV9wYWdlcyk7DQorDQorCWZpbGVfYWNjZXNz
ZWQoZmlsZSk7DQorDQogCWRvdXQoInN5bmNfcmVhZCByZXN1bHQgJWRcbiIsIHJldCk7DQogCXJl
dHVybiByZXQ7DQogfQ0KLS0gDQoxLjguMS4yDQo=
