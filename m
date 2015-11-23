From: "hzwulibin" <hzwulibin@gmail.com>
Subject: Re: why my cluster become unavailable
Date: Mon, 23 Nov 2015 09:00:16 +0800
Message-ID: <5652651C.8040902@gmail.com>
References: <CAN4gH2NsnmOY8AcQaT245uwDh2fXmwnBTBKdP6_xKQ2M0PVeKA@mail.gmail.com>
	<CACJqLyazL_vCxpRGUGROgXN0reyJdUxL-i-OxseT5UV2cXu3pQ@mail.gmail.com>
	<alpine.DEB.2.00.1511210948270.24879@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35330 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbbKWBAR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Nov 2015 20:00:17 -0500
Received: by pacej9 with SMTP id ej9so173838319pac.2
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2015 17:00:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511210948270.24879@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

SGksIFNhZ2UNCg0KVGhhbmtzISBXaWxsIHRyeSBpdCB3aGVuIG5leHQgdGVzdGluZyENCg0KLS0t
LS0tLS0tLS0tLS0tLS0tCQkJCSANCmh6d3VsaWJpbg0KMjAxNS0xMS0yMw0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQrlj5Hk
u7bkurrvvJpTYWdlIFdlaWwgPHNhZ2VAbmV3ZHJlYW0ubmV0Pg0K5Y+R6YCB5pel5pyf77yaMjAx
NS0xMS0yMiAwMTo0OQ0K5pS25Lu25Lq677yaSGFvbWFpIFdhbmcNCuaKhOmAge+8mkxpYmluIFd1
LGNlcGgtZGV2ZWwNCuS4u+mimO+8mlJlOiB3aHkgbXkgY2x1c3RlciBiZWNvbWUgdW5hdmFpbGFi
bGUNCg0KT24gU3VuLCAyMiBOb3YgMjAxNSwgSGFvbWFpIFdhbmcgd3JvdGU6DQo+IE9uIFRodSwg
Tm92IDE5LCAyMDE1IGF0IDExOjI2IFBNLCBMaWJpbiBXdSA8aHp3dWxpYmluQGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4gSGksIGNlcGhlcg0KPiA+DQo+ID4gSSBoYXZlIGEgY2x1c3RlciBvZiA2IE9T
RCBzZXJ2ZXIsIGV2ZXJ5IHNlcnZlciBoYXMgOCBPU0RzLg0KPiA+DQo+ID4gSSBvdXQgNCBPU0Rz
IG9uIGV2ZXJ5IHNlcnZlciwgdGhlbiBteSBjbGllbnQgaW8gaXMgYmxvY2tpbmcuDQo+ID4NCj4g
PiBJIHJlYm9vdCBteSBjbGllbnQgYW5kIHRoZW4gY3JlYXRlIGEgbmV3IHJiZCBkZXZpY2UsIGJ1
dCB0aGUgbmV3DQo+ID4gZGV2aWNlIGFsc28gY2FuJ3Qgd3JpdGUgaW8uDQo+ID4NCj4gPiBZZWFo
LCBpIHVuZGVyc3RhbmQgdGhhdCBzb21lIGRhdGEgbWF5IGxvc3QgYXMgdGhyZWVlIHJlcGxpY2Fz
IG9mIHNvbWUNCj4gPiBvYmplY3Qgd2VyZSBsb3N0LCBidXQgd2h5IHRoZSBjbHVzdGVyIGJlY29t
ZSB1bmF2YWlsYWJsZT8NCj4gPg0KPiA+IFRoZXJlIDgwIGluY29tcGxldGUgcGcgYW5kIDQgZG93
bitpbmNvbXBsZXRlIHBnLg0KPiA+DQo+ID4gQW55IHNvbHV0aW9uIGkgY291bGQgc29sdmUgdGhl
IHByb2JsZW0/DQo+IA0KPiBZZXMsIGlmIHlvdSBkb2Vzbid0IGhhdmUgYSBzcGVjaWFsIGNydXNo
bWFwIHRvIGNvbnRyb2wgdGhlIGRhdGENCj4gcmVwbGNlbWVudCBwb2xpY3ksIHBnIHdpbGwgbGFj
ayBvZiBuZWNlc3NhcnkgbWV0YWRhdGEgdG8gYm9vdC4gSWYgbmVlZA0KPiB0byByZWFkZCBvdXRl
ZCBvc2RzIG9yIGZvcmNlIHJlbW92ZSBwZyB3aGljaCBpcyBpbmNvbXBsZXRlKGhvcGUgaXQncw0K
PiBqdXN0IGEgdGVzdCkuDQoNCklzIG1pbl9zaXplIDIgb3IgMT8gIFJlZHVjaW5nIGl0IHRvIDEg
d2lsbCBnZW5lcmFsbHkgY2xlYXIgc29tZSBvZiB0aGUgDQppbmNvbXBsZXRlIHBncy4gIEp1c3Qg
cmVtZW1iZXIgdG8gcmFpc2UgaXQgYmFjayB0byAyIGFmdGVyIHRoZSBjbHVzdGVyIA0KcmVjb3Zl
cnMuDQoNCnNhZ2UNCg0K

