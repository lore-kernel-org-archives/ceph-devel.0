From: Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
Subject: radosgw: stale/leaked bucket index entries
Date: Mon, 19 Jun 2017 17:37:05 +0000
Message-ID: <6B335CE5-2828-47E7-A993-2D5ACC302AC1@walmartlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppes-mail-e6.wal-mart.com ([161.165.133.168]:38148 "EHLO
        ppes-mail-e6.wal-mart.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFSRhN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 13:37:13 -0400
Received: from pps.filterd (ppes-mail-e6.wal-mart.com [127.0.0.1])
        by ppes-mail-e6.wal-mart.com (8.16.0.20/8.16.0.20) with SMTP id v5JHYv8L043634
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 12:37:12 -0500
Received: from honts35006.homeoffice.wal-mart.com (oser500425.wal-mart.com [10.24.131.24])
        by ppes-mail-e6.wal-mart.com with ESMTP id 2b4yyytbqq-7
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 12:37:12 -0500
Content-Language: en-GB
Content-ID: <EC84385F67A2A840B0ECD0C1A95502B8@NAMP100.PROD.OUTLOOK.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

T24gbWFueSBvZiBvdXIgY2x1c3RlcnMgcnVubmluZyBKZXdlbCAoMTAuMi41KyksIGFtIHJ1bm5p
bmcgaW50byBhIHN0cmFuZ2UgcHJvYmxlbSBvZiBoYXZpbmcgc3RhbGUgYnVja2V0IGluZGV4IGVu
dHJpZXMgbGVmdCBvdmVyIGZvciAoc29tZSBvZiB0aGUpIG9iamVjdHMgZGVsZXRlZC4gVGhvdWdo
IGl0IGlzIG5vdCByZXByb2R1Y2libGUgYXQgd2lsbCwgaXQgaGFzIGJlZW4gcHJldHR5IGNvbnNp
c3RlbnQgb2YgbGF0ZSBhbmQgYW0gY2x1ZWxlc3MgYXQgdGhpcyBwb2ludCBmb3IgdGhlIHBvc3Np
YmxlIHJlYXNvbnMgdG8gaGFwcGVuIHNvLiANCg0KVGhlIHN5bXB0b21zIGFyZSB0aGF0IHRoZSBh
Y3R1YWwgZGVsZXRlIG9wZXJhdGlvbiBvZiBhbiBvYmplY3QgaXMgcmVwb3J0ZWQgc3VjY2Vzc2Z1
bCBpbiB0aGUgUkdXIGxvZ3MsIGJ1dCBhIGJ1Y2tldCBsaXN0IG9uIHRoZSBjb250YWluZXIgd291
bGQgc3RpbGwgc2hvdyB0aGUgZGVsZXRlZCBvYmplY3QuIEFuIGF0dGVtcHQgdG8gZG93bmxvYWQv
c3RhdCBvZiB0aGUgb2JqZWN0IGFwcHJvcHJpYXRlbHkgcmVzdWx0cyBpbiBhIGZhaWx1cmUuIE5v
IGZhaWx1cmVzIGFyZSBzZWVuIGluIHRoZSByZXNwZWN0aXZlIE9TRHMgd2hlcmUgdGhlIGJ1Y2tl
dCBpbmRleCBvYmplY3QgaXMgbG9jYXRlZC4gQW5kIHJlYnVpbGRpbmcgdGhlIGJ1Y2tldCBpbmRl
eCBieSBydW5uaW5nIOKAmHJhZG9zZ3ctYWRtaW4gYnVja2V0IGNoZWNrIOKAk2ZpeOKAmSB3b3Vs
ZCBmaXggdGhlIGlzc3VlLg0KDQpUaG91Z2ggSSBjb3VsZCBzaW11bGF0ZSB0aGUgcHJvYmxlbSBi
eSBpbnN0cnVtZW50aW5nIHRoZSBjb2RlLCB0byBub3QgdG8gaGF2ZSBpbnZva2VkIGBjb21wbGV0
ZV9kZWxgIG9uIHRoZSBidWNrZXQgaW5kZXggb3AgaHR0cHM6Ly9naXRodWIuY29tL2NlcGgvY2Vw
aC9ibG9iL21hc3Rlci9zcmMvcmd3L3Jnd19yYWRvcy5jYyNMODc5MywgYnV0IHRoYXQgY2FsbCBp
cyBhbHdheXMgc2VlbSB0byBiZSBtYWRlIHVubGVzcyB0aGVyZSBpcyBhIGNhc2NhZGluZyBlcnJv
ciBmcm9tIHRoZSBhY3R1YWwgZGVsZXRlIG9wZXJhdGlvbiBvZiB0aGUgb2JqZWN0LCB3aGljaCBk
b2VzbuKAmXQgc2VlbSB0byBiZSB0aGUgY2FzZSBoZXJlLg0KDQpJIHdhbnRlZCB0byBrbm93IHRo
ZSBwb3NzaWJsZSByZWFzb25zIHdoZXJlIHRoZSBidWNrZXQgaW5kZXggd291bGQgYmUgbGVmdCBp
biBzdWNoIGxpbWJvLCBhbnkgcG9pbnRlcnMgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4gRldJ
Vywgd2UgYXJlIG5vdCBzaGFyZGluZyB0aGUgYnVja2V0cyBhbmQgdmVyeSByZWNlbnRseSBJ4oCZ
dmUgc2VlbiB0aGlzIGhhcHBlbiB3aXRoIGJ1Y2tldHMgaGF2aW5nIGFzIGxvdyBhcyANCjwgMTAg
b2JqZWN0cywgYW5kIHdlIGFyZSB1c2luZyBzd2lmdCBmb3IgYWxsIHRoZSBvcGVyYXRpb25zLg0K
DQpUaGFua3MsDQotUGF2YW4uDQoNCg==
