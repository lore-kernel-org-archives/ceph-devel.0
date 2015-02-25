From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: RE: generic plugin support
Date: Wed, 25 Feb 2015 06:56:23 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA70538@g01jpexmbyt24>
References: <54ECEAC8.7060206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:23107 "EHLO
	mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbBYG42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 01:56:28 -0500
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 455B7AC0640
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 15:56:25 +0900 (JST)
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D75391DB8049
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 15:56:24 +0900 (JST)
In-Reply-To: <54ECEAC8.7060206@dachary.org>
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Varada Kari <Varada.Kari@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

SGkgTG9pYywNCg0KR3JlYXQhIEl0IHNlZW1zIGEgZ29vZCBpZGVhIGZvciBw
bHVnaW5zIHRoYXQgZ2V0IGludG8gQ2VwaCBsYXRlciENCldlJ2xsIGF0dGVu
ZCB5b3VyIHNlc3Npb24gb24gQ0RTIG5leHQgd2Vlay4NCg0KQ2hlZXJzLA0K
VGFrZXNoaSBNaXlhbWFlDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMb2ljIERhY2hhcnkgW21haWx0bzpsb2ljQGRhY2hhcnkub3Jn
XSANClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjUsIDIwMTUgNjoxOSBB
TQ0KVG86IFZhcmFkYSBLYXJpOyBNaXlhbWFlLCBUYWtlc2hpL+WuruWJjSDl
iZsNCkNjOiBDZXBoIERldmVsb3BtZW50DQpTdWJqZWN0OiBnZW5lcmljIHBs
dWdpbiBzdXBwb3J0DQoNCkhpLA0KDQpJIHByb3Bvc2VkIGEgYmx1ZXByaW50
IHRvIGFkZCBnZW5lcmljIHBsdWdpbiBzdXBwb3J0IHRvIENlcGggZm9yIHRo
ZSB1cGNvbWluZyBDZXBoIERldmVsb3BlciBTdW1taXQgdGhhdCB3aWxsIGJl
IGhlbGQgbmV4dCB3ZWVrOg0KDQogICAgaHR0cHM6Ly93aWtpLmNlcGguY29t
L1BsYW5uaW5nL0JsdWVwcmludHMvSW5mZXJuYWxpcy9HZW5lcmljX3N1cHBv
cnRfZm9yX3BsdWdpbnNfaW5zdGFsbGF0aW9uX2FuZF91cGdyYWRlDQoNCkl0
J3MgYSByb3VnaCBkcmFmdCBzdGlsbCBhbmQgSSd2ZSBjcmVhdGVkIGFuIGZl
YXR1cmUgcmVxdWVzdCB0byB0cmFjayBpdCBodHRwOi8vdHJhY2tlci5jZXBo
LmNvbS9pc3N1ZXMvMTA5NDEuIFNhbXVlbCBKdXN0IGFjdHVhbGx5IGNyZWF0
ZWQgYSB0aWNrZXQgYSB5ZWFyIGFnbyB0aGF0IHByb3Bvc2VzIHBhcnQgb2Yg
dGhlIHNvbHV0aW9uIGF0IGh0dHA6Ly90cmFja2VyLmNlcGguY29tL2lzc3Vl
cy83MjkxLiANCg0KVGFrZXNoaSwgaWYgc3VjaCBhIG1lY2hhbmlzbSB3YXMg
YXZhaWxhYmxlLCBpdCB3b3VsZCBoZWxwIGRlcGxveSB5b3VyIG5ldyBzaGVj
IHBsdWdpbiBvbiBhbiBleGlzdGluZyBjbHVzdGVyLCBldmVuIG9uIGEgZ2lh
bnQgY2x1c3RlciBhcyBsb25nIGFzIHRoZSBwbHVnaW4gaXMgQUJJIGNvbXBh
dGlibGUuDQoNClZhcmFkYSwgaXQgbG9va3MgbGlrZSBhIG5lY2Vzc2FyeSBm
aXJzdCBzdGVwIGZvciBhIGdlbmVyaWMga2V5L3ZhbHVlIHN0b3JlIHBsdWdn
YWJsZSBiYWNrZW5kLg0KDQpXb3VsZCB5b3UgYmUgaW50ZXJlc3RlZCB0byBw
YXJ0aWNpcGF0ZSBpbiBzdWNoIGEgZGVzaWduIHNlc3Npb24gPyANCg0KQ2hl
ZXJzDQoNCi0tIA0KTG/Dr2MgRGFjaGFyeSwgQXJ0aXNhbiBMb2dpY2llbCBM
aWJyZQ0KDQo=
