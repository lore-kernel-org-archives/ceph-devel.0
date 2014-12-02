From: Sage Weil <sage@newdream.net>
Subject: Re: LTTng tracing: hitting the message throttle
Date: Tue, 2 Dec 2014 10:05:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412021003050.2702@cobra.newdream.net>
References: <20141202190004.5c308f20@doppio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59980 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbaLBSFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 13:05:17 -0500
In-Reply-To: <20141202190004.5c308f20@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Andreas,

On Tue, 2 Dec 2014, Andreas Bluemle wrote:
> Hi,
> 
> while running tests to collect data using LTTng, I was hitting
> the message throttle in ceph-osd, which is controlled by configuration
> option osd_map_message_max, default 100.
> 
> If I am not mistaken, then this throttle hits when more than
> 100 messages received via SimpleMessenger are not yet destructed,
> i.e. are still under processing within the affected ceph-osd daemon.
> 
> I was running a fio test, random writes of 4 KByte with 16 parallel
> IO's. The storage cluster consists of 12 osds on 3 storage nodes,
> replication level 3.
> 
> I wonder why I hit that message throttle with my load profile:
> the 16 parallel IO's should at most generate 48 data messages and also
> 48 acknowledges across the cluster - so I would not expect anything
> even close to a 100 message limit on a single osd in my cluster.

I think the message may stay alive even after the client reply goes back 
because the op is written/committed to the journal but has not yet been 
written to the fs.  It may be that we can drop the reference at this 
point, although it may make the OpTracker output incomplete since the 
message is gone...

> Did anybody else experience such issues?
> 
> Are there other throttle values which I should look at?

There is a similar throttle for the number of bytes.

FWIW it may be that 100 is too low a default.  What value lets your 
workload run comfortably without throttling?

sage
