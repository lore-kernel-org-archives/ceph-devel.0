From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: keyvaluestore speed up?
Date: Fri, 20 Mar 2015 02:22:55 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D0150C211@shsmsx102.ccr.corp.intel.com>
References: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65349 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbCTCXY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Mar 2015 22:23:24 -0400
In-Reply-To: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>, Sage Weil <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

SSB0aGluayByb2Nrc2RiIGNhbiBzdXBwb3J0IHRoaXMgY29uZmlndXJhdGlvbi4NCg0KQ2hlZXJz
LA0KeGlueGluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBjZXBoLWRldmVs
LW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmNlcGgtZGV2ZWwtb3duZXJAdmdlci5rZXJu
ZWwub3JnXSBPbiBCZWhhbGYgT2YgWGluemUgQ2hpDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMTks
IDIwMTUgNToyMyBQTQ0KVG86IFNhZ2UgV2VpbDsgc2p1c3RAcmVkaGF0LmNvbTsgSGFvbWFpIFdh
bmc7IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBrZXl2YWx1ZXN0b3JlIHNw
ZWVkIHVwPw0KDQpoaSwgYWxsOg0KDQogICAgQ3VycmVudGx5IGF0IGtleXZhbHVlc3RvcmUsIG9z
ZCBzZW5kIHN5bmMNCnJlcXVlc3Qoc3VibWl0X3RyYW5zYWN0aW9uX3N5bmMpIHRvIGZpbGVzdG9y
ZSB3aGVuIGl0IGZpbmlzaGVzIGEgdHJhbnNhY3Rpb24uIEJ1dCBzYXRhIGRpc2sgaXMgbm90IHN1
aXRhYmxlIGZvciBkb2luZyBzeW5jIHJlcXVlc3QuIHNzZCBkaXNrIGlzIG1vcmUgc3VpdGFibGUu
DQoNCiAgICBTbyBJIHRoaW5rIHdoZXRoZXIgd2UgY291bGQgc2VwYXJhdGUgbGV2ZWxkYiAqLmxv
ZyBmaWxlIHdpdGggKi5zc3QgZmlsZSBhbmQgbW92ZSAqLmxvZyB0byBzc2QgZGlzaywgd2hpY2gg
aXMgc2ltaWxhciB3aXRoIGpvdXJuYWwgZmlsZSBpbiBjZXBoLg0KDQogICAgQnV0IG5vdywgdGhl
IG9yaWdpbmFsIGxldmVsZGIgZG8gbm90IHN1cHBvcnQgdG8gc2VwYXJhdGUgbG9nIGZpbGUgYW5k
IHNzdCBmaWxlLg0KDQogICAgV2FpdCBmb3IgeW91ciBjb21tZW50Lg0KDQogICAgVGhhbmtzLg0K
LS0NClRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNj
cmliZSBjZXBoLWRldmVsIiBpbiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZn
ZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwu
b3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
