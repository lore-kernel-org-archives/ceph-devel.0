From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: [Questions]Can client know which OSDs are storing the data?
Date: Tue, 27 Jan 2015 07:51:44 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C90FD3D@SHSMSX101.ccr.corp.intel.com>
References: <CA+U0gViDOis_9-46kp1GjED5Gq6NN98WeDpdJF2pbB9FOa3CzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24404 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbbA0HwA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Jan 2015 02:52:00 -0500
In-Reply-To: <CA+U0gViDOis_9-46kp1GjED5Gq6NN98WeDpdJF2pbB9FOa3CzA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <kernel.org.gnu@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjZXBoLWRldmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmNlcGgtZGV2ZWwtb3duZXJAdmdlci5rZXJuZWwub3Jn
XSBPbiBCZWhhbGYgT2YgRGVubmlzIENoZW4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyNywg
MjAxNSAzOjA3IFBNDQo+IFRvOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZzsgRGVubmlzIENo
ZW4NCj4gU3ViamVjdDogW1F1ZXN0aW9uc11DYW4gY2xpZW50IGtub3cgd2hpY2ggT1NEcyBhcmUg
c3RvcmluZyB0aGUgZGF0YT8NCj4gDQo+IEhlbGxvIEd1eXMsDQo+IA0KPiBNeSBxdWVzdGlvbiBp
cyB2ZXJ5IHJ1ZGUgYW5kIGRpcmVjdCwgYSBsaXR0bGUgYml0IHN0dXBpZCBtYXliZSA7LSkNCj4g
DQo+IFF1ZXN0aW9uIGE6IGEgY2xpZW50IHdyaXRlIGEgZmlsZSB0byB0aGUgY2x1c3RlciAoc3Vw
cG9zaW5nIHJlcGxpY2EgPSAzKSwgc28gdGhlDQo+IGRhdGEgd2lsbCBiZSBzdG9yZWQgaW4gMyBP
U0RzIHdpdGhpbiB0aGUgY2x1c3RlciwgY2FuIEkgZ2V0IHRoZSBpbmZvcm1hdGlvbiBvZg0KPiB3
aGljaCBPU0RzIHN0b3JpbmcgdGhlIGZpbGUgZGF0YSBpbiBjbGllbnQgc2lkZT8NCj4gDQpDZXBo
IG9zZCBtYXAgPHBvb2xuYW1lPiA8b2JqZWN0bmFtZT4NCkRpc3BsYXkgdGhlIG9zZCBhbmQgcGcg
d2hpY2ggc3RvcmUgb2JqZWN0Lg0KDQo+IFF1ZXN0aW9uIGI6IGNhbiB0aGUgb2JqZWN0IGRhdGEg
c3RpbGwgYmUgcmVwbGljYXRlZCBpZiBJIHN0b3JlIGEgb2JqZWN0IGZyb20gY2xpZW50DQo+IHdp
dGggUkFET1MgQVBJPw0KWWVzLCByYWRvcyBhcGkgaXMgYWxzbyBhIGNsaWVudC4NCj4gDQo+IFRo
YW5rIHlvdSBndXlzICENCj4gLS0NCj4gRGVuDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20g
dGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBjZXBoLWRldmVsIiBpbiB0aGUg
Ym9keQ0KPiBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1h
am9yZG9tbyBpbmZvIGF0DQo+IGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8u
aHRtbA0K
