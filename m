From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Question about how rebuild works.
Date: Fri, 6 Nov 2015 05:59:34 +0000
Message-ID: <BY1PR0201MB09044CA844EFDC46E6DA589EE8280@BY1PR0201MB0904.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0086.outbound.protection.outlook.com ([157.56.110.86]:13152
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751002AbbKFGOm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 01:14:42 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have a question about rebuild in the following situation:

I have a pool with 3x replication.
For one particular PG we'll designate the active OSD set as [1,2,3] with 1 as the primary.
Assume 2 and 3 crash with a TOTAL loss of local data.
2 restarts, fiddles about and then start the backfill process.
<A little time passes, here little means enough to make some progress in the rebuild process but nowhere near enough to complete it.
3 restarts, fiddles about then starts the backfill process.

My question: Is there any optimization of the fact that we're rebuilding 2 OSDs at the same time (even though the rebuilds didn't start in lock step) OR do the two rebuilds continue independently??


