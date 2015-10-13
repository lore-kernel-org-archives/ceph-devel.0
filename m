From: =?utf-8?B?RGHFgmVrLCBQaW90cg==?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: [ceph-users] Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 09:20:29 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB5683B8E9@ABGEX73E.FSC.NET>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F31740C2F@SACMBXIP02.sdcorp.global.sandisk.com>
 <CACJqLyZp=+c0BbHRW3JUdAXrT9nWPopE82GEAJUUFrPi5g1vnQ@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F31740E6B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:38446 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbJMHUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 03:20:33 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31740E6B@SACMBXIP02.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjZXBoLWRldmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZyBbbWFpbHRvOmNlcGgtZGV2ZWwtDQo+IG93bmVyQHZnZXIua2VybmVsLm9y
Z10gT24gQmVoYWxmIE9mIFNvbW5hdGggUm95DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTMs
IDIwMTUgODo0NiBBTQ0KPiANCj4gVGhhbmtzIEhhb21haS4uDQo+IFNpbmNlIEFzeW5jIG1lc3Nl
bmdlciBpcyBhbHdheXMgdXNpbmcgYSBjb25zdGFudCBudW1iZXIgb2YgdGhyZWFkcyAsIHRoZXJl
DQo+IGNvdWxkIGJlIGEgcG90ZW50aWFsIHBlcmZvcm1hbmNlIHByb2JsZW0gb2Ygc2NhbGluZyB1
cCB0aGUgY2xpZW50DQo+IGNvbm5lY3Rpb25zIGtlZXBpbmcgdGhlIGNvbnN0YW50IG51bWJlciBv
ZiBPU0RzID8NCj4gTWF5IGJlIGl0J3MgYSBnb29kIHRyYWRlb2ZmLi4NCg0KSXQncyBub3QgdGhh
dCBiaWcgaXNzdWUgd2hlbiB5b3UgbG9vayByZWFsaXN0aWNhbGx5IGF0IGl0LiBJbiBmYWN0LCBo
YXZpbmcgbW9yZSB0aHJlYWRzIHRoYW4gYXJvdW5kIDIgKiBhdmFpbGFibGVfbG9naWNhbF9jcHVz
IGlzIGdvaW5nIHRvIGRyYWcgcGVyZm9ybWFuY2UgZG93biwgc28gaXQncyBiZXR0ZXIgdG8gaGF2
ZSB0aHJlYWQgd2FpdCB0aGFuIG1ha2UgaXQgZm9yY2luZyBjb250ZXh0IHN3aXRjaGVzLiBUaGUg
cG9pbnQgb2YgdXNpbmcgbW9yZSB0aHJlYWRzIHBlciBwcm9jZXNzIGlzIHRvIGhhdmUgaXQgc3Bl
bmQgbGVzcyB0aW1lIHdhaXRpbmcgZm9yIEkvTyBhbmQgYmV0dGVyIHV0aWxpemUgY3VycmVudCBt
dWx0aS1jb3JlIENQVXMuIEhhdmluZyB0aHJlYWRzIGZpZ2h0aW5nIGZvciBDUFUgYW5kL29yIEkv
TyB0aW1lIGlzIHdvcnNlIHRoYW4gaGF2aW5nIHRoZW0gdW5kZXJ1dGlsaXplZCwgd2hpY2ggaXMg
cGFydGljdWxhcmx5IHRydWUgd2l0aCBzcGlubmluZyBkcml2ZXMgKHdoaWNoIGFyZW4ndCBnb2lu
ZyBhbnl3aGVyZSBhbnkgc29vbjsgbm90IGV2ZXJ5IGN1c3RvbWVyIGlzIGdvaW5nIHRvIGFjY2Vw
dCAkMTcwMCBwcmljZSB0YWcgcGVyIGRyaXZlIHRoYXQgaGFzIG9ubHkgODAwR0Igb2YgY2FwYWNp
dHkpIGFuZCBzbG93ZXIgQ1BVcyAoYWdhaW4sIG5vdCBldmVyeSBjdXN0b21lciBpcyBnb2luZyB0
byBhY2NlcHQgJDEyMDAgcHJpY2UgdGFnIHBlciBDUFUpLg0KDQpXaXRoIGJlc3QgcmVnYXJkcyAv
IFBvemRyYXdpYW0NClBpb3RyIERhxYJlaw0KDQo=
