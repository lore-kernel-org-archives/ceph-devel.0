From: Sage Weil <sweil@redhat.com>
Subject: RE: perf counters from a performance discrepancy
Date: Wed, 7 Oct 2015 19:47:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510071944370.8667@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com> <alpine.DEB.2.00.1509231116580.13265@cobra.newdream.net> <CAJ4mKGavY4ZdutpjnKduQ1AcpCpHDeWST8NyOa_RT19W+DvrNQ@mail.gmail.com> <5602F298.7060609@redhat.com>
 <BC97738F8E7C8742BABED7F06FB9DF919250DA8E@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbbJHCsA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Oct 2015 22:48:00 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF919250DA8E@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Mark Nelson <mnelson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I finally got around to looking at the dump_historic_ops output for the 
> 1-client and 2-client cases.
> As you recall these are all read-ops.  so the events in the dump are
>    initiated
>    reached_pg
>    started
>    done
> 
> The pattern I see for most of the slow ops recorded in the dump is:
> 
>    * In the 1-client case the typical slow op has duration between 50-65 ms
>      and usually most of this is the interval between reached_pg and started.
> 
>    * In the 2-client case the typical slow op has duration between 95-120 ms
>      and again usually most of this is the interval between reached_pg 
>      and started.
> 
> Could someone describe what the interval between reached_pg and started 
> means?

I think the slow part is probably find_object_context() (although to be 
fair tons of stuff happens here, see do_op()).  You could test this 
theory or otherwise narrow this down with additional event 
markers lke

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index d6f3084..6faccc2 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1691,10 +1691,12 @@ void ReplicatedPG::do_op(OpRequestRef& op)
     return;
   }
 
+  op->mark_event("about to find");
   int r = find_object_context(
     oid, &obc, can_create,
     m->has_flag(CEPH_OSD_FLAG_MAP_SNAP_CLONE),
     &missing_oid);
+  op->mark_event("found");
 
   if (r == -EAGAIN) {
     // If we're not the primary of this OSD, and we have


sage
