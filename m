From: majianpeng <majianpeng@gmail.com>
Subject: Re: Re: [PATCH] ceph:Update the file time after mmap-write.
Date: Fri, 12 Jul 2013 10:26:26 +0800
Message-ID: <201307121026243710713@gmail.com>
References: <201307110917146231510@gmail.com> <CAAM7YA=3stCqYppd6YAwk9tC_rHMzraqge_L6gGZkzaG8LH6Ag@mail.gmail.com> <201307111553503594177@gmail.com>,
	<CAAM7YAmAwNEX4x2sbTocZTtP01GwW62UD5m9JDWBsRUuf7i1gQ@mail.gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56769 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512Ab3GLC1d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 22:27:33 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so8472848pab.3
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 19:27:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?gb2312?B?WWFuLCBaaGVuZw==?= <ukernel@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Pk9uIFRodSwgSnVsIDExLCAyMDEzIGF0IDM6NTMgUE0sIG1hamlhbnBlbmcgPG1hamlhbnBlbmdA
Z21haWwuY29tPiB3cm90ZToNCj4+Pk9uIFRodSwgSnVsIDExLCAyMDEzIGF0IDk6MTcgQU0sIG1h
amlhbnBlbmcgPG1hamlhbnBlbmdAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gQWx0aG91Z2gsIG1t
YXAtd3JpdGUgb2YgY2VwaCB1cGRhdGUgdGhlIHRpbWUgb2YgZmlsZSB1c2luZw0KPj4+PiBmaWxl
X3VwZGF0ZV90aW1lLkJlY2F1c2UgaXQgZG9uJ3QgbWFyayB0aGUgcmVsYXRpdmUgY2FwIHNvIHRo
ZSB0aW1lDQo+Pj4+IGNhbid0IHNhdmUuDQo+Pj4NCj4+PkkgdGhpbmsgY2VwaGZzJyBtbWFwIElP
IHN1cHBvcnQgaXMgc3RpbGwgYnJva2VuLiBtbWFwIElPIGRvZXMgbm90IHJlc3BlY3QNCj4+PmNl
cGggY2FwYWJpbGl0aWVzIGF0IGFsbC4gSXQncyBwb3NzaWJsZSB0aGF0IHRoZSBrY2xpZW50IGhh
cyBubyBGdyBjYXAgd2hlbg0KPj4+Y2VwaF9wYWdlX21rd3JpdGUgaXMgY2FsbGVkLg0KPj4+DQo+
Pj5ZYW4sIFpoZW5nDQo+Pj4NCj4+Pg0KPj4gSGkgWWFuLA0KPj4gICAgICAgICBGb3IgdGhlIHJl
YWQgb2YgbW1hcCwgaSB0aGluayB3ZSBhbHNvIGFkZCBjYXAtY2hlY2suDQo+PiBBbmQgaSB0aGlu
ayB3ZSBjYW4gcmV3cml0ZSB0aGUgZmlsZW1hcF9mYXVsdCBlY3QgY2VwaF9maWxlbWFwX2ZhdWx0
Lg0KPj4gSW4gY2VwaF9maWxlbWFwX2ZhdWx0LCBtb3N0IGNvZGUgZnJvbSBmaWxlbWFwX2ZhdWx0
LCB3ZSBvbmx5IGFkZCBjYXAtY2hlY2sgZm9yIHJlYWQtb3BlcmF0aW9uLg0KPj4gSG93IGFib3V0
IHRoaXMgb3IgY2FuIHlvdSBzdWdnZXN0IGFudGhvciBtZXRob2Q/DQo+Pg0KPg0KPlRoaXMgZG9l
c24ndCB3b3JrLiBpZiBhIGZpbGUgaXMgb3BlbmVkIGJ5IG11bHRpcGxlIGNsaWVudHMsIHRoZSBN
RFMNCj5kb2Vzbid0IGlzc3VlIEZjYiBjYXBzIHRvIHRoZSBjbGllbnQuDQo+SWYgd2UgYWRkIGNh
cCBjaGVjayB0byBmaWxlbWFwX2ZhdWx0IGFuZCBwYWdlX21rd3JpdGUsIHRoZXkgY2FuIGJsb2Nr
DQo+Zm9yZXZlci4gVG8gbWFrZSBtbWFwIElPIHdvcmsNCj5wcm9wZXJseSwgSSB0aGluayB0aGUg
b25seSBzb2x1dGlvbiBpcyBpbnRyb2R1Y2luZyBhIG5ldyBjYWNoZQ0KPmNvaGVyZW5jZSBwcm90
b2NvbCBmb3IgbW1hcCBJTw0KPg0KVGhhbmtzIHlvdXIgc3VnZ2VzdGlvbi4NClVubGVzcyB3ZSBn
ZXQgdGhlIEZjYiBjYXAsIHdlIGNhbiBkbyB0aGUgbW1hcC1pby5Ib3cgYWJvdXQgdGhpcz8NCkJl
Y2F1c2UgdGhlIGNhcCBjYW4gY2hhbmdlLHNvIHdlIGNhbiB1c2luZyBGeCB0byBsb2NrIHRoZSBm
aWxlLCBzbyBjYXAgY2FuJ3QgY2hhbmdlLg0KDQo+DQo+PiBUaGFua3MhDQo+PiBKaWFucGVuZyBN
YQ==

