From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: allow sync_read/write return partial successed size of read/write.
Date: Wed, 21 Aug 2013 15:02:51 +0800
Message-ID: <201308211502490443362@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32883 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab3HUHCy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 03:02:54 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so57222pdj.6
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 00:02:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

SGkgU2FnZToNCglUaGlzIHBhdGNoIGJhc2VkIG9uIG15IHByZXZpb3VzIHBhdGNoImNlcGg6IGZp
eCBidWdzIGFib3V0IGhhbmRsaW5nIHNob3J0LXJlYWQgZm9yIHN5bmMgcmVhZCBtb2RlIi4NCkkg
Y2FuJ3Qgc2VlIHRoaXMgcGF0Y2ggaW4gY2VwaC1jbGllbnQjdGVzdGluZy5NYXliZSB5b3UgZm9y
Z2V0IGl0ID8NCg0KVGhhbmtzIQ0KSmlhbnBlbmcgTWENCg0KRm9yIHN5bmNfcmVhZC93cml0ZSwg
aXQgbWF5IGRvIG11bHRpIHN0cmlwZSBvcGVyYXRpb25zLklmIG9uZSBvZiB0aG9zZQ0KbWV0IGVy
cm8sIHdlIHJldHVybiB0aGUgZm9ybWVyIHN1Y2Nlc3NlZCBzaXplIHJhdGhlciB0aGFuIGEgZXJy
b3IgdmFsdWUuDQpUaGVyZSBpcyBhIGV4Y2VwdGlvbiBmb3Igd3JpdGUtb3BlcmF0aW9uIG1ldCAt
RU9MRFNOQVBDLklmIHRoaXMgb2NjdXIsd2UNCnJldHJ5IHRoZSB3aG9sZSB3cml0ZSBhZ2Fpbi4N
Cg0KU2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0t
DQogZnMvY2VwaC9maWxlLmMgfCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMv
Y2VwaC9maWxlLmMNCmluZGV4IDY5YzQ2NjkuLmRkNTI1YzUgMTAwNjQ0DQotLS0gYS9mcy9jZXBo
L2ZpbGUuYw0KKysrIGIvZnMvY2VwaC9maWxlLmMNCkBAIC0zNzMsNyArMzczLDcgQEAgbW9yZToN
CiAJCQlnb3RvIG1vcmU7DQogCX0NCiANCi0JaWYgKHJldCA+PSAwKSB7DQorCWlmIChyZWFkID4g
MCkgew0KIAkJcmV0ID0gcmVhZDsNCiAJCS8qIGRpZCB3ZSBib3VuY2Ugb2ZmIGVvZj8gKi8NCiAJ
CWlmIChwb3MgKyBsZWZ0ID4gaW5vZGUtPmlfc2l6ZSkNCkBAIC02MTEsNyArNjExLDggQEAgb3V0
Og0KIAkJaWYgKGNoZWNrX2NhcHMpDQogCQkJY2VwaF9jaGVja19jYXBzKGNlcGhfaW5vZGUoaW5v
ZGUpLCBDSEVDS19DQVBTX0FVVEhPTkxZLA0KIAkJCQkJTlVMTCk7DQotCX0NCisJfSBlbHNlIGlm
IChyZXQgIT0gLUVPTERTTkFQQyAmJiB3cml0dGVuID4gMCkNCisJCXJldCA9IHdyaXR0ZW47DQog
CXJldHVybiByZXQ7DQogfQ0KIA0KLS0gDQoxLjguMS4yDQo=

