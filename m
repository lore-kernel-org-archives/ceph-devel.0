From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 0/2] fs, ceph filesystem refcount conversions
Date: Thu, 20 Apr 2017 10:28:22 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C8D7AE@IRSMSX102.ger.corp.intel.com>
References: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
 <CAOi1vP-wZL9yW=_MkhU0x6fGn=9=xEYP1T03ikL2p6g49Vandw@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612B41C8D6E8@IRSMSX102.ger.corp.intel.com>
 <CAOi1vP-cVj19gU4yi8z0wssokT8oTM1n-cKRURDdL0t2ztxJ6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53003 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941992AbdDTK20 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Apr 2017 06:28:26 -0400
In-Reply-To: <CAOi1vP-cVj19gU4yi8z0wssokT8oTM1n-cKRURDdL0t2ztxJ6w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

DQoNCj4gT24gVGh1LCBBcHIgMjAsIDIwMTcgYXQgOTo0MCBBTSwgUmVzaGV0b3ZhLCBFbGVuYQ0K
PiA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gT24gRnJpLCBN
YXIgMywgMjAxNyBhdCAxMDoxNSBBTSwgRWxlbmEgUmVzaGV0b3ZhDQo+ID4+IDxlbGVuYS5yZXNo
ZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPj4gPiBOb3cgd2hlbiBuZXcgcmVmY291bnRfdCB0
eXBlIGFuZCBBUEkgYXJlIGZpbmFsbHkgbWVyZ2VkDQo+ID4+ID4gKHNlZSBpbmNsdWRlL2xpbnV4
L3JlZmNvdW50LmgpLCB0aGUgZm9sbG93aW5nDQo+ID4+ID4gcGF0Y2hlcyBjb252ZXJ0IHZhcmlv
dXMgcmVmY291bnRlcnMgaW4gdGhlIGNlcGggZmlsZXN5c3RlbSBmcm9tIGF0b21pY190DQo+ID4+
ID4gdG8gcmVmY291bnRfdC4gQnkgZG9pbmcgdGhpcyB3ZSBwcmV2ZW50IGludGVudGlvbmFsIG9y
IGFjY2lkZW50YWwNCj4gPj4gPiB1bmRlcmZsb3dzIG9yIG92ZXJmbG93cyB0aGF0IGNhbiBsZWQg
dG8gdXNlLWFmdGVyLWZyZWUgdnVsbmVyYWJpbGl0aWVzLg0KPiA+PiA+DQo+ID4+ID4gVGhlIGJl
bG93IHBhdGNoZXMgYXJlIGZ1bGx5IGluZGVwZW5kZW50IGFuZCBjYW4gYmUgY2hlcnJ5LXBpY2tl
ZA0KPiBzZXBhcmF0ZWx5Lg0KPiA+PiA+IFNpbmNlIHdlIGNvbnZlcnQgYWxsIGtlcm5lbCBzdWJz
eXN0ZW1zIGluIHRoZSBzYW1lIGZhc2hpb24sIHJlc3VsdGluZw0KPiA+PiA+IGluIGFib3V0IDMw
MCBwYXRjaGVzLCB3ZSBoYXZlIHRvIGdyb3VwIHRoZW0gZm9yIHNlbmRpbmcgYXQgbGVhc3QgaW4g
c29tZQ0KPiA+PiA+IGZhc2hpb24gdG8gYmUgbWFuYWdlYWJsZS4gUGxlYXNlIGV4Y3VzZSB0aGUg
bG9uZyBjYyBsaXN0Lg0KPiA+PiA+DQo+ID4+ID4gTm90IHJ1bnRpbWUgdGVzdGVkLCBzaW5jZSBJ
IGFtIG5vdCBzdXJlIGhvdyB0byBkbyBpdCBmb3IgY2VwaC4NCj4gPj4gPiBIb3dldmVyIGNoYW5n
ZXMgYXJlIHByZXR0eSB0cml2aWFsIGluIHRoaXMgY2FzZS4NCj4gPj4gPg0KPiA+PiA+IEVsZW5h
IFJlc2hldG92YSAoMik6DQo+ID4+ID4gICBmcywgY2VwaDogY29udmVydCBjZXBoX21kc19zZXNz
aW9uLnNfcmVmIGZyb20gYXRvbWljX3QgdG8gcmVmY291bnRfdA0KPiA+PiA+ICAgZnMsIGNlcGg6
IGNvbnZlcnQgY2VwaF9jYXBfc25hcC5ucmVmIGZyb20gYXRvbWljX3QgdG8gcmVmY291bnRfdA0K
PiA+PiA+DQo+ID4+ID4gIGZzL2NlcGgvY2Fwcy5jICAgICAgIHwgIDQgKystLQ0KPiA+PiA+ICBm
cy9jZXBoL21kc19jbGllbnQuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiA+PiA+ICBmcy9j
ZXBoL21kc19jbGllbnQuaCB8ICA1ICsrKy0tDQo+ID4+ID4gIGZzL2NlcGgvc25hcC5jICAgICAg
IHwgIDIgKy0NCj4gPj4gPiAgZnMvY2VwaC9zdXBlci5oICAgICAgfCAgNSArKystLQ0KPiA+PiA+
ICA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+
Pg0KPiA+PiBJJ2xsIHB1bGwgdGhlc2UgaW50byB0ZXN0aW5nLg0KPiA+DQo+ID4gSnVzdCBhIGNo
ZWNrOiBob3cgZGlkIHRlc3Rpbmcgd2VudCBvbiB0aGlzPw0KPiA+IElmIGV2ZXJ5dGhpbmcgaXMg
Z29vZCwgY2FuIHlvdSBtZXJnZSB0aGUgY2hhbmdlcz8NCj4gDQo+IFllcCwgSSdsbCBtZXJnZSB0
aGVzZSBpbnRvIDQuMTIuDQoNCkdyZWF0LCB0aGFuayB5b3UhDQoNCkJlc3QgUmVnYXJkcywNCkVs
ZW5hLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gICAgICAgICAgICAgICAgIElseWENCg==
