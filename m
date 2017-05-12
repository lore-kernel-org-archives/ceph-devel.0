From: Sage Weil <sweil@redhat.com>
Subject: global backfill reservation?
Date: Fri, 12 May 2017 18:53:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757121AbdELSxj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 May 2017 14:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54B1A3DBEE
        for <ceph-devel@vger.kernel.org>; Fri, 12 May 2017 18:53:38 +0000 (UTC)
Received: from ovpn-112-4.rdu2.redhat.com (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F087C7F38D
        for <ceph-devel@vger.kernel.org>; Fri, 12 May 2017 18:53:37 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A common complaint is that recovery/backfill/rebalancing has a high 
impact.  That isn't news.  What I realized this week after hearing more 
operators describe their workaround is that everybody's workaround is 
roughly the same: make small changes to the crush map so that only a small 
number of PGs are backfilling at a time.  In retrospect it seems obvious, 
but the problem is that our backfill throttling is per-OSD: the "slowest" 
we can go is 1 backfilling PG per OSD.  (Actually, 2.. one primary and one 
replica due to separate reservation thresholds to avoid deadlock.)  That 
means that every OSD is impacted.  Doing fewer PGs doesn't make the 
recovery vs client scheduling better, but it means it affects fewer PGs 
and fewer client IOs and the net observed impact is smaller.

Anyway, in short, I think we need to be able to set a *global* threshold 
of "no more than X % of OSDs should be backfilling at a time," which is 
impossible given the current reservation appoach.

This could be done naively by having OSDs reserve a slot via the mon or 
mgr.  If we only did it for backfill the impact should be minimal (those 
are big slow long-running operations already).

I think you can *almost* do it cleverly by inferring the set of PGs that 
have to backfill by pg_temp.  However, that doesn't take any priority or 
stuck PGs into consideration.

Anyway, the naive thing probably isn't so bad...

1) PGMap counts backfilling PGs per OSD (and then the number of OSDs with 
one or more backfilling PGs).

2) For the first step of the backfill (recovery?) reservation, OSDs ask 
the mgr for a reservation slot.  The reservation is (pgid,interval epoch) 
so that the mgr can throw out the reservation require without needing an 
explicit cancellation if there is an interval change.

3) mgr grants as many reservations as it can without (backfilling + 
grants) > whatever the max is.

We can set the max with a global tunable like

 max_osd_backfilling_ratio = .3

so that only 30% of the osds can be backfilling at once?

sage
