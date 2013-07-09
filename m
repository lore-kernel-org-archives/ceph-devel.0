From: "Myklebust, Trond" <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 9 Jul 2013 12:26:52 +0000
Message-ID: <1373372811.3641.6.camel@leira.trondhjem.org>
References: <CANP1eJG1=58P70-j0GH=iS_0a6_0mWDFeg0e4batRN9_caYz_w@mail.gmail.com>
	 <20130629035155.GA7975@gmail.com>
	 <CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com>
	 <CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
	 <11954.1372792498@warthog.procyon.org.uk>
	 <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com>
	 <12577.1372793962@warthog.procyon.org.uk>
	 <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com>
	 <1074.1372798161@warthog.procyon.org.uk>
	 <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com>
	 <3869.1372808417@warthog.procyon.org.uk>
	 <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
	 <6424.1373366024@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [216.240.18.77] ([216.240.18.77]:7898 "EHLO mx12.netapp.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab3GIM1Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jul 2013 08:27:24 -0400
In-Reply-To: <6424.1373366024@warthog.procyon.org.uk>
Content-Language: en-US
Content-ID: <D82FCB867FBF8A499DB0028302467697@hq.netapp.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>

T24gVHVlLCAyMDEzLTA3LTA5IGF0IDExOjMzICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBNaWxvc3ogVGFuc2tpIDxtaWxvc3pAYWRmaW4uY29tPiB3cm90ZToNCj4gDQo+ID4gSXQgbG9v
a3MgbGlrZSBib3RoIHRoZSBjaWZzIGFuZCBORlMgY29kZSBkbyBub3QgYm90aGVyIHdpdGggYW55
DQo+ID4gbG9ja2luZyBhcm91bmQgY2lmc19mc2NhY2hlX3NldF9pbm9kZV9jb29raWUuIElzIHRo
ZXJlIG5vIGNvbmNlcm4gb3Zlcg0KPiA+IG11bHRpcGxlIG9wZW4oKSBjYWxscyByYWNpbmcgdG8g
Y3JlYXRlIHRoZSBjb29raWUgaW4gdGhvc2UNCj4gPiBmaWxlc3lzdGVtcz8NCj4gDQo+IFllYWgu
Li4gIFRoYXQncyBwcm9iYWJseSB3cm9uZy4gIEFGUyBvYnZpYXRlcyB0aGUgbmVlZCBmb3Igc3Bl
Y2lhbCBsb2NraW5nIGJ5DQo+IGRvaW5nIGl0IGluIGFmc19pZ2V0KCkuDQo+IA0KPiBIbW1tLi4u
ICBJIHRoaW5rIEkndmUganVzdCBzcG90dGVkIHdoYXQgbWlnaHQgYmUgdGhlIGNhdXNlIG9mIHBh
Z2VzIGdldHRpbmcNCj4gbWFya2VkIFBHX2ZzY2FjaGUgd2hpbHN0IGJlbG9uZ2luZyB0byB0aGUg
YWxsb2NhdG9yLg0KPiANCj4gCXZvaWQgbmZzX2ZzY2FjaGVfc2V0X2lub2RlX2Nvb2tpZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkNCj4gCXsNCj4gCQlpZiAoTkZTX0ZT
Q0FDSEUoaW5vZGUpKSB7DQo+IAkJCW5mc19mc2NhY2hlX2lub2RlX2xvY2soaW5vZGUpOw0KPiAJ
CQlpZiAoKGZpbHAtPmZfZmxhZ3MgJiBPX0FDQ01PREUpICE9IE9fUkRPTkxZKQ0KPiAJCQkJbmZz
X2ZzY2FjaGVfZGlzYWJsZV9pbm9kZV9jb29raWUoaW5vZGUpOw0KPiAJCQllbHNlDQo+IAkJCQlu
ZnNfZnNjYWNoZV9lbmFibGVfaW5vZGVfY29va2llKGlub2RlKTsNCj4gCQkJbmZzX2ZzY2FjaGVf
aW5vZGVfdW5sb2NrKGlub2RlKTsNCj4gCQl9DQo+IAl9DQo+IA0KPiBjYW4gcmVsZWFzZSB0aGUg
Y29va2llIHdoaWxzdCByZWFkcyBhcmUgaW4gcHJvZ3Jlc3Mgb24gaXQgd2hlbiBhbiBpbm9kZSBi
ZWluZw0KPiByZWFkIHN1ZGRlbmx5IGNoYW5nZXMgdG8gYW4gaW5vZGUgYmVpbmcgd3JpdHRlbi4g
IFdlIG5lZWQgc29tZSBzb3J0IG9mDQo+IHN5bmNocm9uaXNhdGlvbiBvbiB0aGF0IHRoZXJlLg0K
DQpDaGFuZ2UgZnNjYWNoZV91bmNhY2hlX2FsbF9pbm9kZV9wYWdlcyB0byBhbHdheXMgdGFrZSB0
aGUgcGFnZSBsb2NrLA0KY2hlY2sgdGhlIHZhbHVlIG9mIHBhZ2UtPm1hcHBpbmcsIGFuZCB3YWl0
IGZvciBvdXRzdGFuZGluZyB3cml0ZXMgdG8NCmZpbmlzaCBiZWZvcmUgdHJ5aW5nIHRvIHJlbGVh
c2UgUEdfZnNjYWNoZT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lcg0KDQpOZXRBcHANClRyb25kLk15a2xlYnVzdEBuZXRhcHAuY29tDQp3d3cubmV0
YXBwLmNvbQ0K
