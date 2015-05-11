From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 14:18:21 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0136.outbound.protection.outlook.com ([207.46.100.136]:51904
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751693AbbEKOS0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 10:18:26 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2E217CAE7DA
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 10:18:22 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have noticed the following while running rados bench seq read tests with a 40M object size

    single rados bench, 4 concurrent ops,                     bandwidth = 190 MB/s
    4 copies of rados bench, 1 concurrent op each,  aggregate bandwidth = 310 MB/s

and in fact the single rados bench seems limited to 190, no matter how many concurrent ops.

I don't see this kind of behavior with a 4M object size.

(The above are with caches dropped on the osd targets)

It doesn't seem to be related to the total number of bytes being processed by the single 
because if I don't drop the caches, both the single rados bench and the 4-copy rados bench
get much higher numbers (600 vs. 900) but still the single rados bench appears limited, no matter
how many concurrent ops are used.

Is there kind of throttling going on by design here?

-- Tom Deneau, AMD
