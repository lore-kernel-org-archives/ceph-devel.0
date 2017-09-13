From: Sage Weil <sweil@redhat.com>
Subject: recovery priority preemption
Date: Wed, 13 Sep 2017 15:03:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709131458410.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdIMPDY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Sep 2017 11:03:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: piotr.dalek@corp.ovh.com

I recently observed a problem on the lab cluster while doing a log of 
rebalancing (filestore->bluestore conversion):

 - lots of pgs in backfill_wait
 - a few pgs that need pg log recovery, but these appear after backfills 
are already in progress, so they end up in backfill_wait too (confusing 
state name!)
 - ongoing write activity extents pg logs for those pgs, but they cannot 
trim
 - pg logs reach 5x-10x the max
 - OSDs OOM

I think what is needed is for the recovery priority scheduling to allow 
preemption.  If we are currently working on recovery/backfill for PG X, 
but PG Y appears with a higher priority, we should suspend work on X and 
switch to Y.

Piotr, I didn't look too closely at forced recovery changes you folks 
recently did, but I'm guessing that it was added to address this sort of 
situation, right?  Would a general solution that preempts and always works 
on the highest priority PG resolve the problem you've observed?

Thanks-
sage
