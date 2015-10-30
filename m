From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: why we should use two Mutex in OSD ShardData?
Date: Fri, 30 Oct 2015 14:59:33 +0000
Message-ID: <CO1PR02MB208FE1E509A92D5D5E47B00F42F0@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CANE=7sWr3c3pa7ZkbJ2NvZPppiXsF=n6maeMQ2=BZQXdoNx_0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0075.outbound.protection.outlook.com ([157.56.110.75]:18688
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756629AbbJ3O7f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Oct 2015 10:59:35 -0400
In-Reply-To: <CANE=7sWr3c3pa7ZkbJ2NvZPppiXsF=n6maeMQ2=BZQXdoNx_0Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

SGkgeGluemUsDQpUaGlzIGlzIG1haW5seSBmb3IgcmVkdWNpbmcgbG9jayBjb250ZW50aW9uIG9u
IGEgc2luZ2xlIG11dGV4LiBDb25kaXRpb25hbCB3YWtldXAgb24gYSBtdXRleCBpcyBleHBlbnNp
dmUgYW5kIHRoYXQncyB3aHkgd2Ugd2FudGVkIHRvIG1ha2UgaXQgc2VwYXJhdGUgZnJvbSB0aGUg
bXV0ZXggcHJvdGVjdGluZyBTaGFyZGRhdGEgcHJpb3JpdHkgcXVldWUgYW5kIHBnX2Zvcl9wcm9j
ZXNzaW5nIG1hcC4NCkFyZSB5b3Ugc2VlaW5nIGFueSBpbXByb3ZlbWVudCBieSBtb3ZpbmcgdG8g
c2luZ2xlIG11dGV4ID8NCg0KVGhhbmtzICYgUmVnYXJkcw0KU29tbmF0aA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2VwaC1kZXZlbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
W21haWx0bzpjZXBoLWRldmVsLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mID8/
Pw0KU2VudDogRnJpZGF5LCBPY3RvYmVyIDMwLCAyMDE1IDY6MzUgQU0NClRvOiBjZXBoLWRldmVs
QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogd2h5IHdlIHNob3VsZCB1c2UgdHdvIE11dGV4IGlu
IE9TRCBTaGFyZERhdGE/DQoNCmhpLCBhbGw6DQoNCiAgIFRoZXJlIGFyZSB0d28gTXV0ZXggaW4g
U2hhcmREYXRhLCBvbmUgaXMgc2RhdGFfbG9jayBhbmQgdGhlIG90aGVyIG9uZSBpcyBzZGF0YV9v
cF9vcmRlcmluZ19sb2NrLg0KDQogICAgSSB3b25kZXIgY291bGQgd2UgcmVwbGFjZSBzZGF0YV9s
b2NrIHdpdGggc2RhdGFfb3Bfb3JkZXJpbmdfbG9jaz8NCg0KLS0NClJlZ2FyZHMsDQp4aW56ZQ0K
LS0NClRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNj
cmliZSBjZXBoLWRldmVsIiBpbiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZn
ZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwu
b3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
