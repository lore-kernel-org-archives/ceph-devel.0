From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 08:25:48 +0000
Message-ID: <D2683AC6.8AB2%evgeniy.firsov@sandisk.com>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
 <CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0071.outbound.protection.outlook.com ([157.56.110.71]:10759
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750915AbbKKIkz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Nov 2015 03:40:55 -0500
In-Reply-To: <CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <615BEF72F283D14B8AB38FF2031B169E@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

UmItdHJlZSBjb25zdHJ1Y3Rpb24sIGluc2VydGlvbiwgd2hpY2ggbmVlZHMgbWVtb3J5IGFsbG9j
YXRpb24sIG11dGV4DQpsb2NrLCB1bmxvY2sgaXMgbW9yZSBDUFUgZXhwZW5zaXZlIHRoZW4gc3Ry
ZWFtbGluZWQgY3JjIGNhbGN1bGF0aW9uIG9mDQpzb21ldGltZXMgMTAwIGJ5dGVzIG9yIGxlc3Mu
DQoNCk9uIDExLzExLzE1LCAxMjowMyBBTSwgIuaxoOS/oeazvSIgPHhtZHhjeHpAZ21haWwuY29t
PiB3cm90ZToNCg0KPkFoLCBJIGNvbmZ1c2UgdGhhdCB3aHkgdGhlIGNyYyBjYWNoZSBsb2dpYyB3
b3VsZCBleGhhdXN0IHNvIG11Y2ggY3B1Lg0KPg0KPjIwMTUtMTEtMTEgMTU6MjcgR01UKzA4OjAw
IEV2Z2VuaXkgRmlyc292IDxFdmdlbml5LkZpcnNvdkBzYW5kaXNrLmNvbT46DQo+PiBIZWxsbywg
R3V5cyENCj4+DQo+PiBXaGlsZSBydW5uaW5nIENQVSBib3VuZCA0ayBibG9jayB3b3JrbG9hZCwg
SSBmb3VuZCB0aGF0IGRpc2FibGluZyBjcmMNCj4+IGNhY2hlIGluIHRoZSBidWZmZXI6OnJhdyBn
aXZlcyBhcm91bmQgNyUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQuDQo+Pg0KPj4gSWYgdGhlcmUg
aXMgbm8gc3Ryb25nIHVzZSBjYXNlIHdoaWNoIGJlbmVmaXQgZnJvbSB0aGF0IGNhY2hlLCB3ZSB3
b3VsZA0KPj4gcmVtb3ZlIGl0IGVudGlyZWx5LCBvdGhlcndpc2UgY29uZGl0aW9uYWxseSBlbmFi
bGUgaXQgYmFzZWQgb24gdGhlDQo+Pm9iamVjdA0KPj4gc2l6ZS4NCj4+DQo+PiDigLkNCj4+IEV2
Z2VuaXkNCj4+DQo+PiAtLQ0KPj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQg
dGhlIGxpbmUgInVuc3Vic2NyaWJlIGNlcGgtZGV2ZWwiIGluDQo+PiB0aGUgYm9keSBvZiBhIG1l
c3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPj4gTW9yZSBtYWpvcmRvbW8gaW5m
byBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQo+DQo+DQo+
DQo+LS0gDQo+UmVnYXJkcywNCj54aW56ZQ0KDQo=
