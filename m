From: Bassam Tabbara <Bassam.Tabbara@quantum.com>
Subject: Announcing: Embedded Ceph and Rook
Date: Thu, 1 Dec 2016 03:09:19 +0000
Message-ID: <61EA8A10-88D8-4E76-B710-64B928C28B0A@Quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126]:44731 "EHLO
        mx04-000ceb01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752054AbcLADZA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 22:25:00 -0500
Received: from pps.filterd (m0078707.ppops.net [127.0.0.1])
        by mx0a-000ceb01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB13543X002372
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 19:09:22 -0800
Received: from ppoxedge1.quantum.com ([146.174.252.27])
        by mx0a-000ceb01.pphosted.com with ESMTP id 271ku4u8wk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 19:09:22 -0800
Content-Language: en-US
Content-ID: <F4B0DCD57BC9F44B9E3A5F2E414F760E@QUANTUM.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

SGVsbG8gQ2VwaGVycywNCg0KSSB3YW50ZWQgdG8gbGV0IHlvdSBrbm93IGFib3V0IGEgbmV3IGxp
YnJhcnkgdGhhdCBpcyBub3cgYXZhaWxhYmxlIGluIG1hc3Rlci4gSXQncyBjYWxsZWQg4oCcbGli
Y2VwaGTigJ0gYW5kIGl0IGVuYWJsZXMgdGhlIGVtYmVkZGluZyBvZiBDZXBoIGRhZW1vbnMgbGlr
ZSBNT04gYW5kIE9TRCAoYW5kIHNvb24gTURTIGFuZCBSR1cpIGludG8gb3RoZXIgYXBwbGljYXRp
b25zLiBVc2luZyBsaWJjZXBoZCBpdCdzIHBvc3NpYmxlIHRvIGNyZWF0ZSBuZXcgYXBwbGljYXRp
b25zIHRoYXQgY2xvc2VseSBpbnRlZ3JhdGUgQ2VwaCBzdG9yYWdlIHdpdGhvdXQgYnJpbmdpbmcg
aW4gdGhlIGZ1bGwgZGlzdHJpYnV0aW9uIG9mIENlcGggYW5kIGl0cyBkZXBlbmRlbmNpZXMuIEZv
ciBleGFtcGxlLCB5b3UgY2FuIGJ1aWxkIHN0b3JhZ2UgYXBwbGljYXRpb24gdGhhdCBydW5zIHRo
ZSBDZXBoIGRhZW1vbnMgb24gbGltaXRlZCBkaXN0cmlidXRpb25zIGxpa2UgQ29yZU9TIG5hdGl2
ZWx5IG9yIGFsb25nIHNpZGUgYSBoeXBlcnZpc29yIGZvciBoeXBlcmNvbnZlcmdlZCBzY2VuYXJp
b3MuIFRoZSBnb2FsIGlzIHRvIGVuYWJsZSBhIGJyb2FkZXIgZWNvc3lzdGVtIG9mIHNvbHV0aW9u
cyBidWlsdCBhcm91bmQgQ2VwaCBhbmQgcmVkdWNlIHNvbWUgb2YgdGhlIGZyaWN0aW9uIGZvciBh
ZG9wdGluZyBDZXBoIHRvZGF5LiBTZWUgaHR0cDovL3BhZC5jZXBoLmNvbS9wL2VtYmVkZGVkLWNl
cGggZm9yIHRoZSBibHVlcHJpbnQuDQoNCldlIChRdWFudHVtKSBhcmUgdXNpbmcgZW1iZWRkZWQg
Q2VwaCBpbiBhIG5ldyBvcGVuLXNvdXJjZSBwcm9qZWN0IGNhbGxlZCBSb29rIChodHRwczovL2dp
dGh1Yi5jb20vcm9vay9yb29rIGFuZCBodHRwczovL3Jvb2suaW8pLiBSb29rIGludGVncmF0ZXMg
ZW1iZWRkZWQgQ2VwaCBpbiBhIGRlcGxveW1lbnQgdGhhdCBpcyB0YXJnZXRpbmcgY2xvdWQtbmF0
aXZlIGFwcGxpY2F0aW9ucy4NCg0KUGxlYXNlIGZlZWwgZnJlZSB0byByZXNwb25kIHdpdGggZmVl
ZGJhY2suIEFsc28gaWYgeW914oCZcmUgaW4gdGhlIFNlYXR0bGUgYXJlYSBuZXh0IHdlZWsgc3Rv
cCBieSBmb3IgYSBtZWV0dXAgb24gZW1iZWRkZWQgQ2VwaCBhbmQgaXRzIHVzZSBpbiBSb29rIGh0
dHBzOi8vd3d3Lm1lZXR1cC5jb20vUGFjaWZpYy1Ob3J0aHdlc3QtQ2VwaC1NZWV0dXAvZXZlbnRz
LzIzNTYzMjEwNi8NCg0KVGhhbmtzIQ0KQmFzc2FtDQoNCg==
