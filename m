From: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>
Subject: Rados Bench Scaling question from today's Ceph Perf Call
Date: Thu, 6 Jul 2017 18:49:47 +0000
Message-ID: <364F3336-51D4-44CF-99CD-B4075392C1EE@teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33155 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753057AbdGFSty (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 14:49:54 -0400
Received: from rpc7292.td.teradata.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F7C25802E
        for <ceph-devel@vger.kernel.org>; Thu,  6 Jul 2017 14:50:09 -0400 (EDT)
Received: from RPC4168.td.teradata.com (unknown [153.65.10.242])
        by rpc7292.td.teradata.com (Postfix) with ESMTP id 5648D25801E
        for <ceph-devel@vger.kernel.org>; Thu,  6 Jul 2017 14:50:09 -0400 (EDT)
Received: from SUSHDC8440.TD.TERADATA.COM (unknown [153.65.10.253])
        by Websense Email Security Gateway with ESMTPS id 1894E844B0B19
        for <ceph-devel@vger.kernel.org>; Thu,  6 Jul 2017 14:49:51 -0400 (EDT)
Content-Language: en-US
Content-ID: <7BE404E17A0FD048B8B1F047AB81D2E3@namprd13.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

TWFyaywNCkluIHRvZGF54oCZcyBwZXJmIGNhbGwgeW91IHNob3dlZCBmaWxlc3RvcmUgYW5kIGJs
dWVzdG9yZSB3cml0ZSBjbGlmZnMuIFdoYXQsIGluIHlvdXIgb3BpbmlvbiwgaXMgdGhlIGNhdXNl
IG9mIHRoZSBibHVlc3RvcmUgd3JpdGUgY2xpZmY/IElzIHRoYXQgdGhlIHNpemUgb2YgdGhlIGJs
dWVmcyBhbmQvb3Igcm9ja3NkYiBjYWNoZT8gWW91IG1lbnRpb25lZCBpdCBjb3VsZCBiZSBzb2x2
ZWQgYnkgbW9yZSBIVyB3aGljaCBJIHRvb2sgdG8gbWVhbiBiaWdnZXIgY2FjaGUuIElzIHRoYXQg
YSBjb3JyZWN0IGFzc3VtcHRpb24/DQpUaGFua3MgZm9yIHRoZSBwcmVzZW50YXRpb24uDQpCcnVj
ZQ0KDQoNCg0K
