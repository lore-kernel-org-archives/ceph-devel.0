From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: hashing variation in rados bench runs
Date: Mon, 20 Apr 2015 12:37:24 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166429CD5@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0137.outbound.protection.outlook.com ([65.55.169.137]:46176
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754577AbbDTMhb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 08:37:31 -0400
Received: from satlvexedge02.amd.com (satlvexedge02.amd.com [10.177.96.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 235DDBD879F
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2015 07:37:22 -0500 (CDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have been trying to run rados bench runs and I've noticed a lot of variations from run to run.
The runs generally write data with --no-cleanup then read it back (seq), dropping the caches in between
I admit this is on a single node "cluster" with 5 data disks so maybe not realistic but...

In my runs I also collect disk activity traces.  When I look at the seq read scores, I've noticed
the low scoring runs always have a "hot" disk which maxes out while others might be at 30% to 40% usage.
Whereas in the high scoring runs the disk activity is much more evenly distributed.
I realize the hashing of objects to primary osds depends on the object names which are different for each run
(in rados bench, the object names include the pid).  But I was surprised at the sometimes marked unevenness
in the hashing.

Have others seen this and is there a good workaround?

-- Tom Deneau, AMD
