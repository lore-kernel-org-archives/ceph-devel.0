From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Wed, 6 Apr 2016 18:06:25 +0000
Message-ID: <BLUPR0201MB18903C5D060F326FEC75F81FE89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
References: <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
 <20160405151030.GA20891@onthe.net.au> <20160406063849.GA5139@onthe.net.au>
 <BLUPR0201MB18900E0ADCEA8C22D67DF444E89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <20160406171702.GA5847@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0095.outbound.protection.outlook.com ([157.56.110.95]:2816
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751722AbcDFSGk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Apr 2016 14:06:40 -0400
In-Reply-To: <20160406171702.GA5847@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

PHNuaXA+DQoNCj4gSS5lLiB3ZSd2ZSBpbmRlcGVuZGVudGx5IGFycml2ZWQgYXQgdGhlIHNhbWUg
cGxhY2UuIFlheSENCj4gDQoNCllheSENCg0KPiBJdCBqdXN0IHRvb2sgbWUgYSBsb3QgbG9uZ2Vy
Li4uIDotKQ0KPiANCj4gPj4gT24gdGhlIGJyaWdodCBzaWRlLCBpZiB0aGUgMTBeLTkgZm9ybXVs
YSAoQ2hyaXMgIzEsIENocmlzICMyLCBTYWdlKQ0KPiA+PiBhcmUgYW55d2hlcmUgbmVhciBjb3Jy
ZWN0LCB0aGV5IGluZGljYXRlIHdpdGggYSBibG9jayBzaXplIG9mIDRLIGFuZA0KPiA+PiAzMi1i
aXQgY2hlY2tzdW0sIHlvdSdkIG5lZWQgdG8gcmVhZCA1ICogMTBeMjEgYml0cywgb3IgMC41IFpC
LCB0byBnZXQNCj4gPj4gdG8gYSAxJSBjaGFuY2Ugb2Ygc2VlaW5nIHVuZmxhZ2dlZCBiYWQgZGF0
YSwgZS5nLjoNCj4gPj4NCj4gPj4gQ2hyaXMgIzIgQCBVPTEwXi0xNSwgQz0zMiwgRD0oNCAqIDEw
MjQpLCBOPSg1ICogOCAqIDEwXjIxKQ0KPiA+PiAgID0gMSAtICgoKDJeLTMyKSAqICgoMS0oMTBe
LTE1KSleKDQgKiAxMDI0KS0xKSsxKSBeICgoNSAqIDggKiAxMF4yMSkgLyAoNCAqDQo+IDEwMjQp
KSkNCj4gPj4gICA9IDAuMDA5MjY5OTkxOTc4NjE1NDM5Njg5MzgxMDYyNDAwNDQ4ODgxMzgwMjAy
MTU4MjMxNjE1Njg1NDYwDQo+ID4+ICAgPSAwLjkyJQ0KPiANCj4gSnVzdCBmb3IgY29tcGxldGVu
ZXNzLCB1c2luZyB0aGUgY29ycmVjdGVkIEQgPSAoNCAqIDggKiAxMDI0KToNCj4gDQo+IFAoYmFk
IGRhdGEpIEAgVT0xMF4tMTUsIEM9MzIsIEQ9KDQgKiA4ICogMTAyNCksIE49KDUgKiA4ICogMTBe
MjEpDQo+ICAgPSAxIC0gKDJeLUMgKiAoMS1VKV5EIC0gMl4tQyArIDEpIF4gKE4gLyBEKQ0KPiAg
ID0gMSAtICgyXi0zMiAqICgxLSgxMF4tMTUpKV4oNCAqIDggKiAxMDI0KSAtIDJeLTMyICsgMSkg
XiAoKDUgKiA4ICogMTBeMjEpIC8gKDQgKg0KPiA4ICogMTAyNCkpDQo+ICAgPSAwLjAwOTI2OTk5
MTk3ODQ4MzE2Mjk2MjU3MzQ2MzU3OTY2MDc5MTQ3MDA2NTEwMjUyMDcyNzEwNzEwNg0KPiAgID0g
MC45MiUNCj4gDQo+IEkuZS4gdGhlIHNhbWUgYXMgYmVmb3JlLCB1cCB0byAxMF4tMTIuIE5vdCBz
dXJwcmlzaW5nIGFzIHRoZSBwcmV2aW91cyBEID0NCj4gKDEwMjQgKiAxMDI0KSBleGFtcGxlIGRl
bW9uc3RyYXRlZCBpdCdzIHJlbGF0aXZlbHkgaW5zZW5zaXRpdmUgdG8gdGhlIGJsb2NrDQo+IHNp
emUuDQoNCldoZXJlIGRvZXMgMTBeMjEgY29tZSBpbnRvIHRoZSBlcXVhdGlvbj8gSSB0aG91Z2h0
IHdlIHdlcmUgZGVhbGluZyB3aXRoIDVQQi4gDQoNCj4gDQo+IENocmlzDQo=
