From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Bluestore OSD support in ceph-disk
Date: Thu, 15 Sep 2016 18:23:32 +0000
Message-ID: <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
 <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
 <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:37665 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbcIOSXf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 14:23:35 -0400
In-Reply-To: <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com>
Content-Language: en-US
Content-ID: <BF9DFC51EDFB9B4E93C39E0745443E77@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Q2FuIEkgdXNlIGNlcGgtZGlzayB0byBwcmVwYXJlIGEgYmx1ZXN0b3JlIE9TRCBub3c/DQoNCkkg
d291bGQgbGlrZSB0byBrbm93IHByb3BlciBjb21tYW5kIGxpbmUgcGFyYW1ldGVycyBmb3IgY2Vw
aC1kaXNrIC4NCg0KVGhlIGZvbGxvd2luZyByZWxhdGVkIGlzc3VlIHRyYWNrZXIgaGFzIGNsb3Nl
ZCwgZG9lcyBpdCBtZWFuIGl0IGlzIHJlYWR5IHRvIHVzZSBmb3IgY3JlYXRpb24gb2YgYmx1ZXN0
b3JlIE9TRHM/DQoNCkZyb206IGh0dHA6Ly90cmFja2VyLmNlcGguY29tL2lzc3Vlcy8xMzk0Mg0K
DQo+DQo+IFVwZGF0ZWQgYnkgU2FnZSBXZWlsIDkgbW9udGhzIGFnbw0KPgnigKIgU3RhdHVzIGNo
YW5nZWQgZnJvbSBJbiBQcm9ncmVzcyB0byBWZXJpZmllZA0KPgnigKIgQXNzaWduZWUgZGVsZXRl
ZCAoTG9pYyBEYWNoYXJ5KQ0KPiBGb3IgdGhlICdjZXBoLWRpc2sgcHJlcGFyZScgcGFydCwgSSB0
aGluayB3ZSBzaG91bGQga2VlcCBpdCBzaW1wbGUgaW5pdGlhbGx5Og0KPg0KPiBjZXBoLWRpc2sg
LS1vc2Qtb2JqZWN0c3RvcmUgYmx1ZXN0b3JlIG1haW5kZXZbOmRiZGV2Wzp3YWxkZXZdXQ0KPiBh
bmQgdGVhY2ggY2VwaC1kaXNrIGhvdyB0byBkbyB0aGUgcGFydGl0aW9uaW5nIGZvciBibHVlc3Rv
cmUgKG5vIGdlbmVyaWMgd2F5IHRvIGFzayBjZXBoLW9zZCB0aGF0KS4gV2UgY2FuIGxlYXZlIG9m
ZiB0aGUgZGIvd2FsIGRldmljZXMgaW5pdGlhbGx5LCBhbmQgdGhlbiBtYWtlIGFjdGl2YXRlIHdv
cmssIHNvIHRoYXQgdGhlcmUgaXMgc29tZXRoaW5nIGZ1bmN0aW9uYWwuIFRoZW4gYWRkIGRiZGV2
IGFuZCB3YWxkZXYgc3VwcG9ydCBsYXN0Lg0KPg0KDQpUaGFua3MsDQpOaXRpbg0KDQo=
