From: Sage Weil <sage@inktank.com>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 08:46:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302210845080.26699@cobra.newdream.net>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56756 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab3BUQqM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 11:46:12 -0500
In-Reply-To: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 21 Feb 2013, Gandalf Corvotempesta wrote:
> Hi
> I have some trouble on a test cluster.
> Many PGs are stuck in "peering" state from yesterday:
> 
> pg 1.2 is peering, acting [3,4]
> pg 0.3 is peering, acting [3,4]
> pg 2.1 is peering, acting [3,4]
> pg 3.0 is peering, acting [3,4]
> pg 1.3 is peering, acting [1,4]
> pg 0.2 is peering, acting [3,4]
> pg 2.0 is peering, acting [3,4]
> pg 3.1 is peering, acting [1,4]
> pg 4.6 is down+peering, acting [4,0]
> pg 5.7 is peering, acting [3,1]
> pg 6.4 is down+peering, acting [4,0]
> pg 7.5 is peering, acting [3,1]
> pg 0.1 is active+degraded, acting [4,0]
> pg 2.3 is peering, acting [3,4]
> pg 3.2 is peering, acting [3,4]
> pg 4.5 is down+peering, acting [2,4]
> pg 5.4 is down+peering, acting [2,4]
> pg 6.7 is peering, acting [0,4]
> pg 7.6 is peering, acting [0,4]
> pg 1.1 is peering, acting [3,4]
> pg 0.0 is active+degraded, acting [4,0]
> pg 2.2 is peering, acting [1,4]
> pg 3.3 is peering, acting [2,4]
> pg 4.4 is peering, acting [1,4]
> pg 5.5 is down+peering, acting [4,0]
> pg 6.6 is peering, acting [3,1]
> pg 7.7 is down+peering, acting [2,4]

You can 'ceph pg <pgid> query' on the individual pgid's above to see why 
it is blocked.. look near the end of the json dump.  This kind of 
diagnosis is documented under the section on handling common failures.  It 
should tell you which specific OSD needs to be started (or possibly marked 
'lost').

sage


> 
> HEALTH_WARN 332 pgs degraded; 316 pgs down; 316 pgs peering; 93 pgs
> stale; 316 pgs stuck inactive; 93 pgs stuck stale; 764 pgs stuck
> unclean
> 
> 
> 
> any advice ? I think that a not healthy cluster prevent me to run RGW
> due to some timeout.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
