From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 2/2] ceph: for sync_read, call file_accessed to update atime.
Date: Wed, 3 Jul 2013 14:11:48 +0800
Message-ID: <201307031334535261195@gmail.com>
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

Rm9yIGNlcGhfc3luY19yZWFkLGl0IGRvbid0IGNhbGwgZmlsZV9hY2Nlc3NlZCB0byB1cGRhdGUg
YXRpbWUuQnV0IHRoZQ0KYnVmZmVyX3JlYWQgZG8gaXQgLlNvIGFkZCBpdC4NCg0KU2lnbmVkLW9m
Zi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQogZnMvY2VwaC9m
aWxlLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdp
dCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxlLmMNCmluZGV4IGZhNzRlNmYuLmIwZTZm
MGIgMTAwNjQ0DQotLS0gYS9mcy9jZXBoL2ZpbGUuYw0KKysrIGIvZnMvY2VwaC9maWxlLmMNCkBA
IC00NDIsNiArNDQyLDcgQEAgZG9uZToNCiAJCWNlcGhfcHV0X3BhZ2VfdmVjdG9yKHBhZ2VzLCBu
dW1fcGFnZXMsIHRydWUpOw0KIAllbHNlDQogCQljZXBoX3JlbGVhc2VfcGFnZV92ZWN0b3IocGFn
ZXMsIG51bV9wYWdlcyk7DQorCWZpbGVfYWNjZXNzZWQoZmlsZSk7DQogCWRvdXQoInN5bmNfcmVh
ZCByZXN1bHQgJWRcbiIsIHJldCk7DQogCXJldHVybiByZXQ7DQogfQ0KLS0gDQoxLjguMS4yDQo=
