From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: Re: [ceph-users] OSD state flipping when cluster-network in high
 utilization
Date: Wed, 15 May 2013 15:12:44 +0000
Message-ID: <1D3D7B6A-7C8B-4D7B-8B4E-8355F8512F47@intel.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>,
 <519259C5.3000109@inktank.com>
 <6AC1548D-DE2C-4E71-AC73-3903B57C76C6@intel.com>
 <alpine.DEB.2.00.1305141620410.12954@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC0145F746@SHSMSX102.ccr.corp.intel.com>,<5193A44F.1060509@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49361 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab3EOPNA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 May 2013 11:13:00 -0400
In-Reply-To: <5193A44F.1060509@sandia.gov>
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

VGhhbmtzo6wgYnV0IGkgYW0gbm90IHF1aXRlIHVuZGVyc3RhbmQgaG93IHRvIGRldGVybWluZSB3
ZWF0aGVyIG1vbml0b3Igb3ZlcmxvYWRlZKO/IGFuZCBpZiB5ZXOjrHdpbGwgc3RhcnQgc2V2ZXJh
bCBtb25pdG9yIGhlbHCjvw0KDQq3otfUztK1xCBpUGhvbmUNCg0K1NogMjAxMy01LTE1o6wyMzow
N6OsIkppbSBTY2h1dHQiIDxqYXNjaHV0QHNhbmRpYS5nb3Y+INC0tcCjug0KDQo+IE9uIDA1LzE0
LzIwMTMgMDk6MjMgUE0sIENoZW4sIFhpYW94aSB3cm90ZToNCj4+PiBIb3cgcmVzcG9uc2l2ZSBn
ZW5lcmFsbHkgaXMgdGhlIG1hY2hpbmUgdW5kZXIgbG9hZD8gIElzIHRoZXJlIGF2YWlsYWJsZSBD
UFU/DQo+PiAgICBUaGUgbWFjaGluZSB3b3JrcyB3ZWxsLCBhbmQgdGhlIGlzc3VlZCBPU0RzIGFy
ZSBsaWtlbHkgdGhlIHNhbWUsIHNlZW1zIGJlY2F1c2UgdGhleSBoYXZlIHJlbGF0aXZlIHNsb3dl
ciBkaXNrKCBkaXNrIHR5cGUgYXJlIHRoZSBzYW1lIGJ1dCB0aGUgbGF0ZW5jeSBpcyBhIGJpdCBo
aWdoZXIgLDhtcyAtPiAxMG1zKS4NCj4+ICAgIA0KPj4gICAgVG9wIHNob3cgbm8gaWRsZSAlIGJ1
dCBzdGlsbCBoYXZlIDMwKyUgb2YgaW9fd2FpdCwgIG15IGNvbGxlYWd1ZSBlZHVjYXRlIG1lIHRo
YXQgaW9fd2FpdCBjYW4gYmUgdHJlYXRlZCBhcyBmcmVlLg0KPj4gDQo+PiBBbm90aGVyIGluZm9y
bWF0aW9uIGlzIG9mZmxvYWQgdGhlIGhlYXJ0YmVhdCB0byAxR2IgbmljIGRvZXNuJ3Qgc29sdmUg
dGhlIHByb2JsZW0sIHdoYXQncyBtb3JlLCB3aGVuIHdlIGRvaW5nIHJhbmRvbSB3cml0ZSB0ZXN0
LCB3ZSBjYW4gc3RpbGwgc2VlIHRoaXMgZmxpcHBpbmcgaGFwcGVuLiBTbyBJIHdvdWxkIGxpa2Ug
dG8gc2F5IGl0IG1heSByZWxhdGVkIHdpdGggQ1BVIHNjaGVkdWxlciA/IFRoZSBoZWFydGJlYXQg
dGhyZWFkIChpbiBidXN5IE9TRCApIGZhaWxlZCB0byBnZXQgZW5vdWdoIGNwdSBjeWNsZS4NCj4+
IA0KPiANCj4gRldJVywgYWxzbyB0YWtlIGEgY2xvc2UgbG9vayBhdCB5b3VyIG1vbml0b3IgZGFl
bW9ucywgYW5kDQo+IHdoZXRoZXIgdGhleSBzaG93IGFueSBzaWducyBvZiBiZWluZyBvdmVybG9h
ZGVkLg0KPiANCj4gSSBmcmVxdWVudGx5IHNlZSBPU0RzIHdyb25nbHkgbWFya2VkIGRvd24gd2hl
biBteQ0KPiBtb25zIGNhbm5vdCBrZWVwIHVwIHdpdGggdGhlaXIgd29ya2xvYWQuDQo+IA0KPiAt
LSBKaW0NCj4gDQo+IA0K
