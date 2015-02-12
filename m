From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: RE: unittest_erasure_code_shec  fails
Date: Thu, 12 Feb 2015 03:26:44 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA6C73C@g01jpexmbyt24>
References: <54DBAE9A.6030205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48175 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbbBLD0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 22:26:48 -0500
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [10.0.237.143])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 536B63EE0B6
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 12:26:47 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5A82AAC05C3
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 12:26:46 +0900 (JST)
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EE0701DB803A
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 12:26:45 +0900 (JST)
In-Reply-To: <54DBAE9A.6030205@dachary.org>
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

SGkgTG9pYywNCg0KV2UgYXJlIHNvcnJ5IGZvciB0aGUgZXJyb3JzIGluIHRo
ZSB0ZXN0IHNjcmlwdCBhbmQgdGhhbmsgeW91IGZvciB5b3VyIHVyZ2VudCBo
YW5kbGluZy4NClRvIGJlIGhvbmVzdCwgd2UgYWxzbyBoYWQgZm91bmQgdGhv
c2UgZXJyb3JzIGxhc3Qgd2VlayBhbmQgd2UgdGhvdWdodCB0aGF0IHRob3Nl
DQplcnJvcnMgZGVwZW5kIG9uIGV4ZWN1dGlvbiBlbnZpcm9ubWVudC4NCkJh
c2ljYWxseSB0aG9zZSBhcmUgbm90IHJlcXVpcmVkIGFuZCB5b3VyIG1vZGlm
aWNhdGlvbiB3YXMgZW5vdWdoLCBidXQgd2Ugd2lsbCBpc3N1ZQ0KYW5vdGhl
ciBwdWxsIHJlcXVlc3QgbGF0ZXIgYmVjYXVzZSB3ZSB3b3VsZCBsaWtlIHRv
IGVyYXNlIGFsbCB0aGUgc2FtZSBraW5kcyBvZiB0ZXN0cw0KYXMgdGhvc2Uu
DQoNCkJlc3QgcmVnYXJkcywNClRha2VzaGkgTWl5YW1hZQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2VwaC1kZXZlbC1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpjZXBoLWRldmVsLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIExvaWMgRGFjaGFyeQ0KU2VudDog
VGh1cnNkYXksIEZlYnJ1YXJ5IDEyLCAyMDE1IDQ6MzQgQU0NClRvOiBNaXlh
bWFlLCBUYWtlc2hpL+WuruWJjSDliZsNCkNjOiBDZXBoIERldmVsb3BtZW50
DQpTdWJqZWN0OiB1bml0dGVzdF9lcmFzdXJlX2NvZGVfc2hlYyBmYWlscw0K
DQpIaSwNCg0KQXMgb2YgdG9kYXkgdGhlIFNIRUMgdW5pdCB0ZXN0IGZhaWwg
YXMgZGVzY3JpYmVkIGF0IGh0dHA6Ly90cmFja2VyLmNlcGguY29tL2lzc3Vl
cy8xMDgzOS4gQ2FuIHlvdSByZXByb2R1Y2UgdGhlIGZhaWx1cmUgbG9jYWxs
eSA/IEknbSBub3Qgc3VyZSB3aHkgaXQgaGFwcGVucyBub3cgYW5kIG5vdCB5
ZXN0ZXJkYXkuIEknbGwgYmlzZWN0IHRoZSBmYWlsdXJlIGRvd24gdG8gdGhl
IGd1aWx0eSBjb21taXQgYnV0IGl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBj
b3VsZCBjb25maXJtIHRoYXQgeW91IGFsc28gc2VlIGl0Lg0KDQpDaGVlcnMN
Cg0KLS0gDQpMb8OvYyBEYWNoYXJ5LCBBcnRpc2FuIExvZ2ljaWVsIExpYnJl
DQoNCg==
