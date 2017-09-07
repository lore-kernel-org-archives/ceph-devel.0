From: Sage Weil <sweil@redhat.com>
Subject: distributed point-in-time consistency report
Date: Thu, 7 Sep 2017 01:34:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709070119530.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdIGBed (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 6 Sep 2017 21:34:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Xuehan,

Thanks for presenting during CDM!  The final report I mentioned for the 
Red Hat / Harvey Mudd clinic that looked at the point-in-time consistency 
and time sync problem is at

	http://newdream.net/~sage/RedHatFinalReport%2014-15.pdf

If I understood correctly, this is essentially what you are proposing, 
except that the delay is done on the OSD instead of the client.  I think 
this improves a few things:

 - fewer OSDs, fewer clocks to sync
 - in most deployments, OSD to OSD latency will be lower
 - clock error bound will be smaller
 - fewer nodes whose clocks might jitter at the wrong time and invalidate 
the checkpoint

Also, I *think* we can simply delay the OSD replies, preventing any causal 
link with a subsequent operation; new requests can still be 
processed, and hopefully the impact on overall workload will be 
very small.

Does that simplify your approach or make it more complex?  I couldn't tell 
if there were other reasons or advantages to doing it on the client.

Thanks!
sage
