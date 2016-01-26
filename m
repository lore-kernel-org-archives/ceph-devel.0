From: Sage Weil <sage@newdream.net>
Subject: Re: pg rebalancing after taking osds out
Date: Tue, 26 Jan 2016 17:44:10 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601261743440.6524@cpach.fuggernut.com>
References: <DM2PR12MB0556E3531B9E94EAF8131BCB9BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbcAZWn7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:59 -0500
In-Reply-To: <DM2PR12MB0556E3531B9E94EAF8131BCB9BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 26 Jan 2016, Deneau, Tom wrote:
> I have a replicated x2 pool with the crush step of host.
> When the pool was created there were 3 hosts with 7 osds each,
> and looking at the pg-by-pool for that pool I can see that
> every pg has  copies on two different hosts.
> 
> Now I want to take 2 osds out of each node, which I did using
> the osd out command. (So there are then 5 osds per host node).
> 
> Now I rerun ceph pg ls-by-pool for that pool and it shows that
> some pgs have both their copies on the same node.
> 
> Is this normal?  My expectation was that each pg still
> had its two copies on two different hosts.

There those PGs in the 'remapped' state?  What does the tree look like 
('ceph osd tree')?

sage
