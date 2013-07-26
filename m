From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH][TRIVIAL] ceph: Add comments for ENOENT which returned from osd.
Date: Fri, 26 Jul 2013 10:52:13 +0800
Message-ID: <201307261052055540112@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44417 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab3GZCwU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 22:52:20 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so1495069pbc.35
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 19:52:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

VGhlIGVycm9yIEVOT0VOVCBmcm9tIG9zZCBoYXMgc3BlY2lhbCBtZWFuaW5nLkl0IG1lYW5zIHRo
ZSBkYXRhIG9mDQpyZWFkLWFyZWEgYXJlIGFsbC16ZXJvLkluIG9yZGVyIHRvIHJlZHVjZSB0aGUg
ZmxvdyBiZXR3ZWVuIGNsaWVudCBhbmQNCm9zZCwgaXQgdXNlZCB0aGlzIG1ldGhvZC4NCg0KU2ln
bmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQogZnMv
Y2VwaC9maWxlLmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9maWxlLmMgYi9mcy9jZXBoL2ZpbGUuYw0KaW5kZXggMmRk
ZjA2MS4uODFhOWRmYyAxMDA2NDQNCi0tLSBhL2ZzL2NlcGgvZmlsZS5jDQorKysgYi9mcy9jZXBo
L2ZpbGUuYw0KQEAgLTM0Miw2ICszNDIsMTEgQEAgbW9yZToNCiAJCQkJICBjaS0+aV90cnVuY2F0
ZV9zZXEsDQogCQkJCSAgY2ktPmlfdHJ1bmNhdGVfc2l6ZSwNCiAJCQkJICBwYWdlX3BvcywgcGFn
ZXNfbGVmdCwgcGFnZV9hbGlnbik7DQorCS8qDQorCSAqIFRoaXMgZXJyb3IgaXMgcmV0dXJuIGZy
b20gb3NkLkl0IG1lYW5zIHRoZSByZWFkLWFyZWEgaXMgYWxsemVyby4NCisJICogU28gaW4gb3Jk
ZXIgdG8gcmVkdWNlIHRoZSBmbG93LGl0IHJldHVybiB0aGlzIHZhbHVlIHRoZSByZWNpdmVyDQor
CSAqIHNob3VsZCBmaWxsIHplcm8uDQorCSAqLw0KIAlpZiAocmV0ID09IC1FTk9FTlQpDQogCQly
ZXQgPSAwOw0KIAloaXRfc3RyaXBlID0gdGhpc19sZW4gPCBsZWZ0Ow0KLS0gDQoxLjguMS4yDQoN
ClRoYW5rcyENCkppYW5wZW5nIE1h

