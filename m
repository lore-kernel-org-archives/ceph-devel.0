From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: pg rebalancing after taking osds out
Date: Tue, 26 Jan 2016 22:26:02 +0000
Message-ID: <DM2PR12MB0556E3531B9E94EAF8131BCB9BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0064.outbound.protection.outlook.com ([157.56.111.64]:13680
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751110AbcAZWkq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:40:46 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have a replicated x2 pool with the crush step of host.
When the pool was created there were 3 hosts with 7 osds each,
and looking at the pg-by-pool for that pool I can see that
every pg has  copies on two different hosts.

Now I want to take 2 osds out of each node, which I did using
the osd out command. (So there are then 5 osds per host node).

Now I rerun ceph pg ls-by-pool for that pool and it shows that
some pgs have both their copies on the same node.

Is this normal?  My expectation was that each pg still
had its two copies on two different hosts.

-- Tom Deneau

