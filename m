From: Sage Weil <sage@inktank.com>
Subject: Re: Rolling upgrades possible?
Date: Fri, 22 Jun 2012 12:53:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206221248500.4218@cobra.newdream.net>
References: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab2FVTxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 15:53:08 -0400
In-Reply-To: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

A rolling upgrade to 0.48 will be possible, provided the old version is 
reasonably recent (0.45ish or later; I need to confirm that).

The upgrade will be a bit awkward because of teh disk format upgrade, 
however.  Each ceph-osd will need to do a conversion on startup which can 
take a while, so you will want to restart them on a per-host basis or 
per-rack basis (depending on how your CRUSH map is structured).

The monitors are also doing an ncoding change, but will only make the 
transition after all members of the quorum run the new code.  If you start 
the upgrade with a degraded cluster and have another failure, you'll need 
to make sure the recovering node(s) run new code.

The goal is to make all future upgrades possible using rolling upgrades.  
It will be tricky with some of the OSD changes coming, but that is the 
goal.

sage


On Fri, 22 Jun 2012, John Axel Eriksson wrote:

> I guess this has been asked before, I'm just new to the list and
> wondered whether it's possible to do
> rolling upgrades of mons, osds and radosgw? We will soon be in the
> process of migrating from our current
> storage solution to Ceph/RGW. We will only use the object storage,
> actually mainly the S3-interface radosgw
> supplies.
> 
> Right now we have a very small test-installation - 1 mon, 2 osds where
> the mon also runs rgw. Next week I've
> heard that 0.48 might be released, if we upgrade to that, do we have
> to shut down the cluster during the upgrade
> or can we do a rolling upgrade while still responding to PUTs and
> GETs? If not possible yet, is this in the pipeline?
> 
> Best,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
