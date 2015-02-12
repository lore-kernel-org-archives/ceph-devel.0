From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: RE: unittest_erasure_code_shec  fails
Date: Thu, 12 Feb 2015 07:23:59 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA6C7BF@g01jpexmbyt24>
References: <54DBAE9A.6030205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:37982 "EHLO
	mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbBLHYF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 02:24:05 -0500
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E505AC0688
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 16:24:02 +0900 (JST)
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D9660E08001
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 16:24:01 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

SGkgTG9pYywNCg0KV2UgaGF2ZSBvcGVuZWQgYSBuZXcgcHVsbCByZXF1ZXN0
ICMzNzE2IHRvIGZpeCAjMTA4MzkganVzdCBub3cuDQoNCm1zaGVjOiBmaXhl
ZCBidWcgIzEwODM5ICh1bml0dGVzdF9lcmFzdXJlX2NvZGVfc2hlYyBmYWls
cykNCmh0dHBzOi8vZ2l0aHViLmNvbS9jZXBoL2NlcGgvcHVsbC8zNzE2DQoN
CkJlc3QgcmVnYXJkcywNClRha2VzaGkgTWl5YW1hZQ0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWl5YW1hZSwgVGFrZXNoaS/lrq7l
iY0g5YmbIA0KU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEyLCAyMDE1IDEy
OjI3IFBNDQpUbzogJ0xvaWMgRGFjaGFyeScNCkNjOiBDZXBoIERldmVsb3Bt
ZW50OyBTaGlvemF3YSwgS2Vuc3VrZS/loanmsqIg6LOi6LyUIChzaGlvemF3
YS5rZW5uc3VAanAuZnVqaXRzdS5jb20pOyBOYWthbywgVGFrYW5vcmkv5Lit
5bC+IOm3ueiplCAobmFrYW8udGFrYW5vcmlAanAuZnVqaXRzdS5jb20pOyBL
YWdhIFlvc2hpaGlyby/liqDos4Ag6Iqz5a6PICh5LWthZ2FAanAuZnVqaXRz
dS5jb20pOyBLYXdhZ3VjaGkgU2hvdGFyby/lt53lj6Mg57+U5aSq5pyXIChr
YXdhZ3VjaGkuc0BqcC5mdWppdHN1LmNvbSkNClN1YmplY3Q6IFJFOiB1bml0
dGVzdF9lcmFzdXJlX2NvZGVfc2hlYyBmYWlscw0KDQpIaSBMb2ljLA0KDQpX
ZSBhcmUgc29ycnkgZm9yIHRoZSBlcnJvcnMgaW4gdGhlIHRlc3Qgc2NyaXB0
IGFuZCB0aGFuayB5b3UgZm9yIHlvdXIgdXJnZW50IGhhbmRsaW5nLg0KVG8g
YmUgaG9uZXN0LCB3ZSBhbHNvIGhhZCBmb3VuZCB0aG9zZSBlcnJvcnMgbGFz
dCB3ZWVrIGFuZCB3ZSB0aG91Z2h0IHRoYXQgdGhvc2UgZXJyb3JzIGRlcGVu
ZCBvbiBleGVjdXRpb24gZW52aXJvbm1lbnQuDQpCYXNpY2FsbHkgdGhvc2Ug
YXJlIG5vdCByZXF1aXJlZCBhbmQgeW91ciBtb2RpZmljYXRpb24gd2FzIGVu
b3VnaCwgYnV0IHdlIHdpbGwgaXNzdWUgYW5vdGhlciBwdWxsIHJlcXVlc3Qg
bGF0ZXIgYmVjYXVzZSB3ZSB3b3VsZCBsaWtlIHRvIGVyYXNlIGFsbCB0aGUg
c2FtZSBraW5kcyBvZiB0ZXN0cyBhcyB0aG9zZS4NCg0KQmVzdCByZWdhcmRz
LA0KVGFrZXNoaSBNaXlhbWFlDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBjZXBoLWRldmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyBb
bWFpbHRvOmNlcGgtZGV2ZWwtb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBC
ZWhhbGYgT2YgTG9pYyBEYWNoYXJ5DQpTZW50OiBUaHVyc2RheSwgRmVicnVh
cnkgMTIsIDIwMTUgNDozNCBBTQ0KVG86IE1peWFtYWUsIFRha2VzaGkv5a6u
5YmNIOWJmw0KQ2M6IENlcGggRGV2ZWxvcG1lbnQNClN1YmplY3Q6IHVuaXR0
ZXN0X2VyYXN1cmVfY29kZV9zaGVjIGZhaWxzDQoNCkhpLA0KDQpBcyBvZiB0
b2RheSB0aGUgU0hFQyB1bml0IHRlc3QgZmFpbCBhcyBkZXNjcmliZWQgYXQg
aHR0cDovL3RyYWNrZXIuY2VwaC5jb20vaXNzdWVzLzEwODM5LiBDYW4geW91
IHJlcHJvZHVjZSB0aGUgZmFpbHVyZSBsb2NhbGx5ID8gSSdtIG5vdCBzdXJl
IHdoeSBpdCBoYXBwZW5zIG5vdyBhbmQgbm90IHllc3RlcmRheS4gSSdsbCBi
aXNlY3QgdGhlIGZhaWx1cmUgZG93biB0byB0aGUgZ3VpbHR5IGNvbW1pdCBi
dXQgaXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIGNvbmZpcm0gdGhh
dCB5b3UgYWxzbyBzZWUgaXQuDQoNCkNoZWVycw0KDQotLQ0KTG/Dr2MgRGFj
aGFyeSwgQXJ0aXNhbiBMb2dpY2llbCBMaWJyZQ0KDQo=
