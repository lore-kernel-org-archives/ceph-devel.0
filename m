From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: throttles
Date: Mon, 12 Oct 2015 23:08:58 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0094.outbound.protection.outlook.com ([207.46.100.94]:12800
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751902AbbJLXXV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 19:23:21 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2508CBD88F1
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 19:08:59 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looking at the perf counters on my osds, I see wait counts for the following
throttle related perf counters:  (This is from trying to benchmark using
multiple rados bench client processes).

   throttle-filestore_bytes
   throttle-msgr_dispatch_throttler-client
   throttle-osd_client_bytes
   throttle-osd_client_messages

What are the config variables that would allow me to experiment with these throttle limits?
(When I look at the output from --admin-daemon osd.xx.asok config show, it's
not clear which items these correspond to).

-- Tom Deneau


