From: Dan Van Der Ster <daniel.vanderster@cern.ch>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Fri, 19 Sep 2014 08:41:56 +0000
Message-ID: <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
 <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
 <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
 <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
 <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:25779 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561AbaISImA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Sep 2014 04:42:00 -0400
In-Reply-To: <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
Content-Language: en-US
Content-ID: <00558AD63C494046B7BE1000DE5C3E98@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

PiBPbiAxOSBTZXAgMjAxNCwgYXQgMDg6MTIsIEZsb3JpYW4gSGFhcyA8ZmxvcmlhbkBoYXN0ZXhv
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIFNlcCAxOSwgMjAxNCBhdCAxMjoyNyBBTSwgU2Fn
ZSBXZWlsIDxzd2VpbEByZWRoYXQuY29tPiB3cm90ZToNCj4+IE9uIEZyaSwgMTkgU2VwIDIwMTQs
IEZsb3JpYW4gSGFhcyB3cm90ZToNCj4+PiBIaSBTYWdlLA0KPj4+IA0KPj4+IHdhcyB0aGUgb2Zm
LWxpc3QgcmVwbHkgaW50ZW50aW9uYWw/DQo+PiANCj4+IFdob29wcyEgIE5vcGUgOikNCj4+IA0K
Pj4+IE9uIFRodSwgU2VwIDE4LCAyMDE0IGF0IDExOjQ3IFBNLCBTYWdlIFdlaWwgPHN3ZWlsQHJl
ZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4gU28sIGRpc2FzdGVyIGlzIGEgcHJldHR5IGdvb2QgZGVz
Y3JpcHRpb24uIFdvdWxkIGFueW9uZSBmcm9tIHRoZSBjb3JlDQo+Pj4+PiB0ZWFtIGxpa2UgdG8g
c3VnZ2VzdCBhbm90aGVyIGNvdXJzZSBvZiBhY3Rpb24gb3Igd29ya2Fyb3VuZCwgb3IgYXJlDQo+
Pj4+PiBEYW4gYW5kIEkgZ2VuZXJhbGx5IG9uIHRoZSByaWdodCB0cmFjayB0byBtYWtlIHRoZSBi
ZXN0IG91dCBvZiBhDQo+Pj4+PiBwcmV0dHkgYmFkIHNpdHVhdGlvbj8NCj4+Pj4gDQo+Pj4+IFRo
ZSBzaG9ydCB0ZXJtIGZpeCB3b3VsZCBwcm9iYWJseSBiZSB0byBqdXN0IHByZXZlbnQgYmFja2Zp
bGwgZm9yIHRoZSB0aW1lDQo+Pj4+IGJlaW5nIHVudGlsIHRoZSBidWcgaXMgZml4ZWQuDQo+Pj4g
DQo+Pj4gQXMgaW4sIG9zZCBtYXggYmFja2ZpbGxzID0gMD8NCj4+IA0KPj4gWWVhaCA6KQ0KPj4g
DQo+PiBKdXN0IG1hbmFnZWQgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtLi4uDQo+PiANCj4+IHNh
Z2UNCj4gDQo+IFNhdyB0aGUgd2lwIGJyYW5jaC4gQ29sb3IgbWUgZnJlYWtpc2hseSBpbXByZXNz
ZWQgb24gdGhlIHR1cm5hcm91bmQuIDopIFRoYW5rcyENCg0KSW5kZWVkIDopIFRoYW5rcyBTYWdl
IQ0Kd2lwLTk0ODctZHVtcGxpbmcgZml4ZXMgdGhlIHByb2JsZW0gb24gbXkgdGVzdCBjbHVzdGVy
LiBUcnlpbmcgaW4gcHJvZCBub3figKYNCkNoZWVycywgRGFu
