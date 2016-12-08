From: "Gohad, Tushar" <tushar.gohad@intel.com>
Subject: Re: Ceph master latency breakdown
Date: Thu, 8 Dec 2016 02:44:43 +0000
Message-ID: <C70576EC-FE96-4287-B2BA-81AC43B6011F@intel.com>
References: <6C767E85-9C45-469B-A4F7-3B5D38E8B0B6@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:32649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbcLHCoo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Dec 2016 21:44:44 -0500
In-Reply-To: <6C767E85-9C45-469B-A4F7-3B5D38E8B0B6@alibaba-inc.com>
Content-Language: en-US
Content-ID: <A01774744ED431419FD540B08E3711E7@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "Chagam, Anjaneya" <anjaneya.chagam@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

SGkgSmFtZXMsIHRoYXTigJlzIGNvcnJlY3QuICBodHRwczovL2dpdGh1Yi5jb20vY2VwaC9jZXBo
L3B1bGwvMTIzMzAgaXMgdGhlIFBSIGZvciB0cmFjZXBvaW50cyB1c2VkIGZvciBnZW5lcmF0aW5n
IGRhdGEgcHJlc2VudGVkIHRoaXMgbW9ybmluZy4gIEFzIFJlZGR5IG1lbnRpb25lZCBkdXJpbmcg
dGhlIGNhbGwsIHBvc3QtcHJvY2Vzc2luZyBzY3JpcHRzIHdpbGwgYmUgdXBzdHJlYW1lZCBzZXBh
cmF0ZWx5LiAgVGhhbmtzLg0KDQoNCk9uIDEyLzcvMTYsIDc6MzEgUE0sICJjZXBoLWRldmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2YgTElVLCBGZWkiIDxjZXBoLWRldmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2YgamFtZXMubGl1QGFsaWJhYmEtaW5jLmNv
bT4gd3JvdGU6DQoNCiAgICBIaSBTYWdlIGFuZCBJbnRlbCBmb2xrcywNCiAgICANCiAgICAgICBX
b3VsZCB5b3UgbWluZCBjb25maXJtaW5nIHRoZSB0aGUgcHVsbCByZXF1ZXN0IGZvciBsYXRlbmN5
IGJyZWFrZG93biB3aXRoIGJlbG93IGxpbms/DQogICAgICBodHRwczovL2dpdGh1Yi5jb20vY2Vw
aC9jZXBoL3B1bGwvMTIzMzANCiAgICAgIA0KICAgICAgSXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2
ZSB0aGUgbGF0ZW5jeSBicmVha2Rvd24gcHJlc2VudGF0aW9uIGluIHRoZSBtZWV0aW5nLg0KICAg
ICAgDQogICAgICBUaGFua3MsDQogICAgICBKYW1lcw0KICAgIA0KICAgIA0KICAgIC0tDQogICAg
VG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJl
IGNlcGgtZGV2ZWwiIGluDQogICAgdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2
Z2VyLmtlcm5lbC5vcmcNCiAgICBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5r
ZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCiAgICANCg0K
