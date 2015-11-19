From: =?UTF-8?Q?Marcin_Gibu=c5=82a?= <m.gibula@beyond.pl>
Subject: Re: OSD memory usage during startup - advice needed
Date: Thu, 19 Nov 2015 21:30:34 +0100
Message-ID: <564E316A.8050601@beyond.pl>
References: <564E11ED.7080001@beyond.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010505090100080802050109"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ip-92-43-119-196.beyond.pl ([92.43.119.196]:55228 "EHLO
	mx.beyond.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161362AbbKSUap (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Nov 2015 15:30:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.beyond.pl (Postfix) with ESMTP id 82E2EBBD
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 21:30:43 +0100 (CET)
Received: from mx.beyond.pl ([127.0.0.1])
	by localhost (mw.beyond.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AI2i7aYtirZT for <ceph-devel@vger.kernel.org>;
	Thu, 19 Nov 2015 21:30:42 +0100 (CET)
Received: from [192.168.1.120] (src75-20.unii.maverick.com.pl [194.187.75.20])
	(Authenticated sender: m.gibula@beyond.pl)
	by mx.beyond.pl (Postfix) with ESMTPSA id D6DCA720
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 21:30:42 +0100 (CET)
In-Reply-To: <564E11ED.7080001@beyond.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010505090100080802050109
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> Judging from debug output, the problem is in journal recovery, when it
> tries to delete object with huge (several milion keys - it is radosgw
> index* for bucket with over 50mln objects) amount of keys, using
> leveldb's rmkeys_by_prefix() method.
>
> Looking at the source code, rmkeys_by_prefix() batches all operations
> into one list and then submit_transaction() executes them all atomically.
>
> I'd love to write a patch for this issue, but it seems unfixable (or is
> it?) with current API and method behaviour. Could you offer any advice
> on how to proceed?

Answering myself, could anyone verify if attached patch looks ok? Should 
reduce memory footprint a bit.

When I first read this code, I assumed that data pointed by 
leveldb::Slice have to be reachable until db->Write is called.

However, looking into leveldb and into its source code, there is no such 
requirement - leveldb makes its own copy of key, so we're effectivly 
doubling memory footprint for no reason.

-- 
mg

--------------010505090100080802050109
Content-Type: text/plain; charset=UTF-8;
 name="leveldb.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="leveldb.patch"

LS0tIGEvc3JjL29zL0xldmVsREJTdG9yZS5jYw0KKysrIGIvc3JjL29zL0xldmVsREJTdG9y
ZS5jYw0KQEAgLTE1Niw5ICsxNTYsOCBAQCB2b2lkIExldmVsREJTdG9yZTo6TGV2ZWxEQlRy
YW5zYWN0aW9uSW1wbDo6c2V0KA0KICAgYnVmZmVycy5wdXNoX2JhY2sodG9fc2V0X2JsKTsN
CiAgIGJ1ZmZlcmxpc3QgJmJsID0gKihidWZmZXJzLnJiZWdpbigpKTsNCiAgIHN0cmluZyBr
ZXkgPSBjb21iaW5lX3N0cmluZ3MocHJlZml4LCBrKTsNCi0gIGtleXMucHVzaF9iYWNrKGtl
eSk7DQotICBiYXQuRGVsZXRlKGxldmVsZGI6OlNsaWNlKCooa2V5cy5yYmVnaW4oKSkpKTsN
Ci0gIGJhdC5QdXQobGV2ZWxkYjo6U2xpY2UoKihrZXlzLnJiZWdpbigpKSksDQorICBiYXQu
RGVsZXRlKGxldmVsZGI6OlNsaWNlKGtleSkpOw0KKyAgYmF0LlB1dChsZXZlbGRiOjpTbGlj
ZShrZXkpLA0KICAgICAgICAgIGxldmVsZGI6OlNsaWNlKGJsLmNfc3RyKCksIGJsLmxlbmd0
aCgpKSk7DQogfQ0KDQpAQCAtMTY2LDggKzE2NSw3IEBAIHZvaWQgTGV2ZWxEQlN0b3JlOjpM
ZXZlbERCVHJhbnNhY3Rpb25JbXBsOjpybWtleShjb25zdCBzdHJpbmcgJnByZWZpeCwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBz
dHJpbmcgJmspDQogew0KICAgc3RyaW5nIGtleSA9IGNvbWJpbmVfc3RyaW5ncyhwcmVmaXgs
IGspOw0KLSAga2V5cy5wdXNoX2JhY2soa2V5KTsNCi0gIGJhdC5EZWxldGUobGV2ZWxkYjo6
U2xpY2UoKihrZXlzLnJiZWdpbigpKSkpOw0KKyAgYmF0LkRlbGV0ZShsZXZlbGRiOjpTbGlj
ZShrZXkpKTsNCiB9DQoNCiB2b2lkIExldmVsREJTdG9yZTo6TGV2ZWxEQlRyYW5zYWN0aW9u
SW1wbDo6cm1rZXlzX2J5X3ByZWZpeChjb25zdCBzdHJpbmcgJnByZWZpeCkNCkBAIC0xNzcs
OCArMTc1LDcgQEAgdm9pZCBMZXZlbERCU3RvcmU6OkxldmVsREJUcmFuc2FjdGlvbkltcGw6
OnJta2V5c19ieV9wcmVmaXgoY29uc3Qgc3RyaW5nICZwcmVmaXgNCiAgICAgICAgaXQtPnZh
bGlkKCk7DQogICAgICAgIGl0LT5uZXh0KCkpIHsNCiAgICAgc3RyaW5nIGtleSA9IGNvbWJp
bmVfc3RyaW5ncyhwcmVmaXgsIGl0LT5rZXkoKSk7DQotICAgIGtleXMucHVzaF9iYWNrKGtl
eSk7DQotICAgIGJhdC5EZWxldGUoKihrZXlzLnJiZWdpbigpKSk7DQorICAgIGJhdC5EZWxl
dGUoa2V5KTsNCiAgIH0NCiB9DQoNCmRpZmYgLS1naXQgYS9zcmMvb3MvTGV2ZWxEQlN0b3Jl
LmggYi9zcmMvb3MvTGV2ZWxEQlN0b3JlLmgNCmluZGV4IDQ2MTdjNWMuLmRkMjQ4ZGQgMTAw
NjQ0DQotLS0gYS9zcmMvb3MvTGV2ZWxEQlN0b3JlLmgNCisrKyBiL3NyYy9vcy9MZXZlbERC
U3RvcmUuaA0KQEAgLTE3NSw3ICsxNzUsNiBAQCBwdWJsaWM6DQogICBwdWJsaWM6DQogICAg
IGxldmVsZGI6OldyaXRlQmF0Y2ggYmF0Ow0KICAgICBsaXN0PGJ1ZmZlcmxpc3Q+IGJ1ZmZl
cnM7DQotICAgIGxpc3Q8c3RyaW5nPiBrZXlzOw0KICAgICBMZXZlbERCU3RvcmUgKmRiOw0K
DQogICAgIExldmVsREJUcmFuc2FjdGlvbkltcGwoTGV2ZWxEQlN0b3JlICpkYikgOiBkYihk
Yikge30NCg==
--------------010505090100080802050109--
