From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: RE: Re: What should be in the next hammer/firefly release ?
Date: Thu, 10 Sep 2015 10:57:44 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:37976 "EHLO
	mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbIJK5t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 06:57:49 -0400
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id E998AAC02FC
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 19:57:46 +0900 (JST)
Received: from g01jpexchyt37.g01.fujitsu.local (unknown [10.128.193.4])
	by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id 29C2B46E4B2
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 19:57:46 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "Toshine, Naoyoshi" <toshine@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

SGkgTG9pYywNCg0KQXMgdGhlIGxhc3QgcHVsbCByZXF1ZXN0ICM1MjU3IHdh
cyBjb21taXR0ZWQgaW50byB0aGUgbWFpbiB0cnVuaywNCndlIGJlbGlldmUg
YWxsIHRoZSBTSEVDIGNvZGVzIGluIG1haW4gdHJ1bmsgYXJlIHJlYWR5IHRv
IGJlIGJhY2twb3J0ZWQgaW50byBIYW1tZXIgYnJhbmNoLg0KV2hhdCBjYW4g
d2UgZG8gYXQgdGhpcyBtb21lbnQ/DQoNCkJlc3QgcmVnYXJkcywNClRha2Vz
aGkgTWl5YW1hZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogTWl5YW1hZSwgVGFrZXNoaS/lrq7liY0g5YmbIA0KU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAzLCAyMDE1IDQ6MDkgUE0NClRvOiAnY2VwaC1kZXZl
bC1vd25lckB2Z2VyLmtlcm5lbC5vcmcnDQpDYzogUGF1bCBWb24tU3RhbXdp
dHogKFBWb25TdGFtd2l0ekB1cy5mdWppdHN1LmNvbSk7IFRvc2hpbmUsIE5h
b3lvc2hpL+WIqeaguSDnm7TkvbM7IFNoaW96YXdhLCBLZW5zdWtlL+Whqeay
oiDos6LovJQ7IE5ha2FvLCBUYWthbm9yaS/kuK3lsL4g6be56KmUIChuYWth
by50YWthbm9yaUBqcC5mdWppdHN1LmNvbSkNClN1YmplY3Q6IFJlOiBXaGF0
IHNob3VsZCBiZSBpbiB0aGUgbmV4dCBoYW1tZXIvZmlyZWZseSByZWxlYXNl
ID8NCg0KRGVhciBMb2ljLA0KDQpXZSB3b3VsZCBsaWtlIHRvIGxldCBmb2xs
b3dpbmcgdHdvIHBhdGNoZXMgYmUgYmFja3BvcnRlZCB0byBoYW1tZXIgdjAu
OTQuNC4NCihBbmQgb3VyIHdpc2ggaXMgZmluYWxseSBiYWNrcG9ydGluZyB0
aGVzZSBwYXRjaGVzIHRvIFJIQ1MgdjEuMy4pIENhbiBpdCBiZSBwb3NzaWJs
ZT8gSWYgcG9zc2libGUsIHBsZWFzZSBsZXQgdXMga25vdyB3aGF0IHNob3Vs
ZCBiZSBzdGFydGVkIGF0IGZpcnN0Lg0KKENhdXRpb246ICM1MjU3IGhhcyBu
b3QgYmVlbiBjb21taXR0ZWQgdG8gbWFzdGVyIGJyYW5jaCB5ZXQuKQ0KDQpl
cmFzdXJlLWNvZGU6IHNoZWMgcGx1Z2luIGZlYXR1cmUgIzU0OTMNCmh0dHBz
Oi8vZ2l0aHViLmNvbS9jZXBoL2NlcGgvcHVsbC81NDkzDQoNCmVyYXN1cmUg
Y29kZTogc2hlYyBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24gYnkgZGVjb2Rp
bmcgY2FjaGUgIzUyNTcNCmh0dHBzOi8vZ2l0aHViLmNvbS9jZXBoL2NlcGgv
cHVsbC81MjU3DQoNCkJlc3QgcmVnYXJkcywNClRha2VzaGkgTWl5YW1hZQ0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTG9pYyBEYWNo
YXJ5IDxsb2ljIDxhdD4gZGFjaGFyeS5vcmc+DQpTdWJqZWN0OiBXaGF0IHNo
b3VsZCBiZSBpbiB0aGUgbmV4dCBoYW1tZXIvZmlyZWZseSByZWxlYXNlID8N
Ck5ld3Nncm91cHM6IGdtYW5lLmNvbXAuZmlsZS1zeXN0ZW1zLmNlcGguZGV2
ZWwNCkRhdGU6IDIwMTUtMDktMDIgMTE6MDA6NTMgR01UICgxNSBob3VycyBh
bmQgMzIgbWludXRlcyBhZ28pIEhpLA0KDQpJIGFkZGVkIGEgbGluayB0bw0K
DQpodHRwOi8vdHJhY2tlci5jZXBoLmNvbS9wcm9qZWN0cy9jZXBoLXJlbGVh
c2VzL3dpa2kvSE9XVE8jT3ZlcnZpZXctb2YtdGhlLWJhY2twb3J0cy1pbi1w
cm9ncmVzcw0KDQp0byBzaG93IGFsbCBpc3N1ZXMgdGhhdCBzaG91bGQgYmUg
aW4gdGhlIG5leHQgcG9pbnQgcmVsZWFzZSBmb3INCg0KaGFtbWVyIHYwLjk0
LjQgOiBodHRwOi8vdHJhY2tlci5jZXBoLmNvbS92ZXJzaW9ucy80OTUNCmZp
cmVmbHkgdjAuODAuMTEgOiBodHRwOi8vdHJhY2tlci5jZXBoLmNvbS92ZXJz
aW9ucy80ODANCg0KQ2hlZXJzDQoNCi0tDQpMb8OvYyBEYWNoYXJ5LCBBcnRp
c2FuIExvZ2ljaWVsIExpYnJlDQo=
