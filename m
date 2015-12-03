From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: ceph encoding optimization
Date: Thu, 3 Dec 2015 09:29:00 +0000
Message-ID: <ec782072f07a418bb6d02b56253591f1@R01UKEXCASM111.r01.fujitsu.local>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
	<CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
	<34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
	<CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
	<CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
	<alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
	<CAJ4mKGbGSz_G-A=uEDSxSZrREWYu2CnoHMCjVS8tDW_Yd3HKXg@mail.gmail.com>
	<alpine.DEB.2.00.1511090719050.27153@cobra.newdream.net>
	<CANP1eJF+36VKM3difYJmXCfh=-fjHVAyd1VSoGGXbrNAUxYr7A@mail.gmail.com>
 <CANE=7sUj7_YgPS0w7Vx9-Es0u8avrMpcFdu4PRYok7G7r+0GMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.116]:10510 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757763AbbLCJgS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 04:36:18 -0500
In-Reply-To: <CANE=7sUj7_YgPS0w7Vx9-Es0u8avrMpcFdu4PRYok7G7r+0GMw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Milosz Tanski <milosz@adfin.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Dan Mick <dmick@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYaW56ZSBDaGkgKOS/oeazvSkg
W21haWx0bzp4bWR4Y3h6QGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDAz
LCAyMDE1IDEwOjE4IEFNDQo+IFRvOiBNaWxvc3ogVGFuc2tpDQo+IENjOiBTYWdlIFdlaWw7IEdy
ZWdvcnkgRmFybnVtOyBEYW4gTWljazsgSGFvbWFpIFdhbmc7IERhxYJlaywgUGlvdHI7IGNlcGgt
DQo+IGRldmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogY2VwaCBlbmNvZGluZyBv
cHRpbWl6YXRpb24NCj4gDQo+IEkgd3JpdGUgYSBuZXcgcGF0Y2ggYWJvdXQgdGhpcw0KPiBodHRw
czovL2dpdGh1Yi5jb20vWGluemVDaGkvY2VwaC9jb21taXQvMDZlYjQ3MWU0NjNhNDY4N2UyNTEy
NzNkMGI1DQo+IGRmZTE3MGFjYmVmMmQNCj4gDQo+IElmIHlvdSB1c2UgX19hdHRyaWJ1dGVfXyAo
KHBhY2tlZCkpIGFmdGVyIHN0cnVjdCwgd2UgY291bGQgZW5jb2RlIG1hbnkNCj4gc3RydWN0IG1l
bWJlciBpbiBhIGJhdGNoLiBUaGVyZSBpcyBub3QgY29tcGF0aWJpbGl0eSBwcm9ibGVtIGlmIHdl
IGtlZXAgdGhlDQo+IG9yZGVyIG9mIG1lbWJlcnMgZGVmaW5lZCBpbiBzdHJ1Y3QuDQo+IA0KPiBX
YWl0IGZvciB5b3VyIGNvbW1lbnQuDQoNCkZpZWxkcyBpbiBlbWJlZGRlZCBzdHJ1Y3RzIG1pZ2h0
IGJlIGFsaWduZWQsIHRoYXQgd2lsbCBpbmhpYml0IHBhY2tlZCBhdHRyaWJ1dGUuIEFsc28sIHlv
dSBjYW4ndCBqdXN0IHVzZSBwYWNrZWQgYXR0cmlidXRlIG9uIGV2ZXJ5IHN0cnVjdCB0aGF0IGlz
IGVuY29kZWQvZGVjb2RlZCBiZWNhdXNlIHRoYXQgd2lsbCBldmVudHVhbGx5IGluY3VyIGEgcGVy
Zm9ybWFuY2UgaGl0LiBXaGF0IEkgaGFkIGluIG1pbmQgd2l0aCBodHRwczovL2dpdGh1Yi5jb20v
WGluemVDaGkvY2VwaC9jb21taXQvMDZlYjQ3MWU0NjNhNDY4N2UyNTEyNzNkMGI1ZGZlMTcwYWNi
ZWYyZCNjb21taXRjb21tZW50LTE0NzU1NjE1IGlzIHRvIHVzZSB0ZW1wb3JhcnksIHBhY2tlZCBz
dHJ1Y3QsIGNvcHkgZGF0YSBmcm9tIG9yaWdpbmFsIHN0cnVjdC9jbGFzcyBpbnRvIGl0LCBhbmQg
dGhlbiBjb3B5IGRhdGEgZnJvbSBwYWNrZWQgc3RydWN0IGluIG9uZSBnby4NCg0KDQpXaXRoIGJl
c3QgcmVnYXJkcyAvIFBvemRyYXdpYW0NClBpb3RyIERhxYJlaw0KDQoNCg==
