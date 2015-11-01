From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: why we use two ObjectStore::Transaction in
 ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 16:58:38 +0000
Message-ID: <CO1PR02MB208329F13F442DA7093C4CAF42D0@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
 <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
 <CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com>
 <alpine.DEB.2.00.1510311340560.19081@cobra.newdream.net>
 <CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com>
 <alpine.DEB.2.00.1511010639440.19081@cobra.newdream.net>
 <alpine.DEB.2.00.1511010646540.19081@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0090.outbound.protection.outlook.com ([157.56.111.90]:14975
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751123AbbKAQ6m (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 Nov 2015 11:58:42 -0500
In-Reply-To: <alpine.DEB.2.00.1511010646540.19081@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, =?gb2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: Ning Yao <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

U2FnZSwNCklzIGl0IHBvc3NpYmxlIHRoYXQgd2UgY2FuJ3QgcmV1c2UgdGhlIG9wX3QgYmVjYXVz
ZSBpdCBjb3VsZCBiZSBzdGlsbCB0aGVyZSBpbiB0aGUgbWVzc2VuZ2VyIHF1ZXVlIGJlZm9yZSBj
YWxsaW5nIHBhcmVudC0+bG9nX29wZXJhdGlvbigpID8NCg0KDQpUaGFua3MgJiBSZWdhcmRzDQpT
b21uYXRoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjZXBoLWRldmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmNlcGgtZGV2ZWwtb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgU2FnZSBXZWlsDQpTZW50OiBTdW5kYXksIE5vdmVtYmVyIDAxLCAy
MDE1IDY6NDcgQU0NClRvOiCz2NDF1PMNCkNjOiBOaW5nIFlhbzsgY2VwaC1kZXZlbEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiB3aHkgd2UgdXNlIHR3byBPYmplY3RTdG9yZTo6VHJhbnNh
Y3Rpb24gaW4gUmVwbGljYXRlZEJhY2tlbmQ6OnN1Ym1pdF90cmFuc2FjdGlvbj8NCg0KT24gU3Vu
LCAxIE5vdiAyMDE1LCBTYWdlIFdlaWwgd3JvdGU6DQo+IE9uIFN1biwgMSBOb3YgMjAxNSwgPz8/
IHdyb3RlOg0KPiA+IFllcywgSSB0aGluayBzby4NCj4gPiBrZWVwaW5nIHRoZW0gc2VwYXJhdGUg
YW5kIHBhc3MgdGhlbSB0bw0KPiA+IE9iamVjdFN0b3JlOjpxdWV1ZV90cmFuc2FjdGlvbnMoKSB3
b3VsZCBpbmNyZWFzZSB0aGUgdGltZSBvbiANCj4gPiB0cmFuc2FjdGlvbiBlbmNvZGUgcHJvY2Vz
cyBhbmQgZXhoYXVzdCBtb3JlIGNwdS4NCj4gPiANCj4gPiBUaGUgdHJhbnNhY3Rpb246OmFwcGVu
ZCBob2xkcyAwLjglIGNwdSBvbiBteSBlbnZpcm9ubWVudC4NCj4gPiBUaGUgdHJhbnNhY3Rpb24g
ZW5jb2RpbmcgaXMgYWxzbyByZWFsbHkgYSBib3R0bGVuZWNrIHdoaWNoIHByb2Nlc3MgDQo+ID4g
aG9sZHMgMS44JSBjcHUgb24gbXkgZW52aXJvbm1lbnQuDQo+IA0KPiBXaGVyZSBpcyB0aGUgYXBw
ZW5kKCkgY2FsbGVyIHlvdSdyZSBsb29raW5nIGF0PyAgSSdtIG5vdCBzZWVpbmcgaXQuDQoNCk9o
LCBJIHNlZTogIGh0dHBzOi8vZ2l0aHViLmNvbS9jZXBoL2NlcGgvcHVsbC82NDM5DQoNClRoaXMg
bWFrZXMgc2Vuc2UgdG8gbWUuDQpzYWdlDQoNCi0tDQpUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMg
bGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgY2VwaC1kZXZlbCIgaW4gdGhlIGJvZHkg
b2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcgTW9yZSBtYWpvcmRvbW8g
aW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQo=
