From: Sage Weil <sweil@redhat.com>
Subject: removed_snaps
Date: Wed, 11 Oct 2017 16:13:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710111556410.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757528AbdJKQNY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 11 Oct 2017 12:13:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 342583561
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 16:13:24 +0000 (UTC)
Received: from ovpn-112-51.rdu2.redhat.com (ovpn-112-51.rdu2.redhat.com [10.10.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C625762940
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 16:13:23 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm working on removing the removed_snaps field from pg_pool_t (and 
thus the OSDMap) as this can get very large for clusters that have aged 
and use snapshots.

	https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L1320

The short version of the plan is only include recently removed snaps in 
the map.  Once all PGs in a pool have reported that the snap has been 
trimmed, we can safely retire the snapid from that set.

There are a couple of possible problems related to the fact that the 
OSD currently santizes the SnapContext with every write by removing 
snapids that appear in removed_snaps.  This is meant to deal with race 
conditions where the IO was submitted before the snap was removed, but the 
OSD has already logically removed it (or scheduled it for removal).

I see two categories of problems:

1. The IO was prepared at the librados client before the snap was removed, 
the IO is delayed (e.g., client can't connect, or PG is inactive, etc.) 
until after the snap is deleted and retired from removed_snaps, and then 
the IO is processed.  This could trigger a clone on the OSD that will 
then never get cleaned up.

Specifically, a librbd example:

 a. librbd prepares a IOContext that includes snap S
 b. librbd initiates a librados IO with on that ioc.  That request is 
    delayed.
 c. Snap S is removed (someone tells the mon to delete it)
    - either our librbd client did it, or another one did and we get a 
      notify telling us to refresh our header; doesn't matter which.
 d. S is included in OSDMap removed_snaps.
 e. all OSDs prune S
 f. S is removed from removed_snaps some time later
 g. The request from (b) finally reaches the OSD and triggers a clone S
    (which will never get cleaned up)

I think we can fix this problem by making Objecter slightly smarter: it 
can watch OSDMaps it receives and prune snapc's for in-flight requests.  
In the above scenario, sometime between d and g, when it finally 
gets a recent OSDMap, it will have pruned S from the request's snapc.  If 
it didn't get the map, and the request is still tagged with an old 
OSDMap, the OSD can kill the OSD session to force a reconnect/resend. It 
can do this for any incoming client request tagged with an OSDMap prior to 
a low-water-mark epoch in the OSDMap for which older removed_snaps 
have been proved (e.g. removed_snaps_pruned_epoch, or some better name).

In the extreme case where a client is disconnected for so long that they 
can't advance their map to the current one due to the mon having trimmed 
maps, and they have outstanding writes with snapcs, the client 
can choose to fail the requests with EIO or ESTALE or something, or crash 
itself, or otherwise behave as if it has been blacklisted/fenced (if it's 
RBD, it probably has anyway).

2. There is a bug, and the librbd image is out of sync: it thinks that 
snap S still exists but in reality it has been pruned.  If this happens, 
then the librbd client may use S and it may trigger a clone.  However, 
that snap still is referenced from the image, so it will presumably 
eventually get deleted and cleaned up.

Greg suggested the possibility of a similar CephFS bug, where for example 
a CephFS client gets confused and continues sending snapcs with removed 
snaps.  I think we can catch this category of bug (and probably #2 as 
well) if we make the OSD log an error/warning to the cluster log if it 
gets an incoming request including a deleted snapid when the request is 
marked with an epoch after when the snap was deleted.  This would 
would mean adding the deleted_epoch for each removed snapid to pg_pool_t 
to do properly; maybe worth it, maybe not?

Thoughts?
sage
