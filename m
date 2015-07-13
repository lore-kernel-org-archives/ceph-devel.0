From: John Spray <john.spray@redhat.com>
Subject: CephFS fsck tickets
Date: Mon, 13 Jul 2015 14:13:21 +0100
Message-ID: <55A3B971.3080700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbbGMNNW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 09:13:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id B96E8349E56
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 13:13:22 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>


Lots of new tickets in tracker related to forward scrub, this is a 
handly list (mainly for Greg and myself) that maps to the notes from our 
design discussion.  They're all under the 'fsck' category in tracker.

John



Tagging
prerequisite:
  - forward scrub (traverse tree, at least)

  #12255
  - create "scrub header" or "scrub map" in MDLog, like subtreemap, make
    scrub startup wait until this is written before going ahead

#12257
  - add recovery of scrub header during MDS replay, and re-start
    any scrubs that were ongoing

#12258
- add tagged-scrub command taking <path> <tag>

#12273
  - actually apply the tag during the RADOS op for reading something


#12274
  - start the process from all subtree roots on all MDSs, and skip 
non-auth regions
#12275
  - block migration during tagging scrub
  OR
  - when migrating, look up to parent subtree and send along info about
    the scrub if we haven't been scrubbed in this tag yet

  - handle MDS rank shutdown vs. ongoing scrub

Backtrace handling
#12277
- during backward scrub, tag our parent with the most recent
    backtrace seen, even if we already created it with a less
    recent backtrace (set_if_greater on a backtrace xattr) as
    a hint to a subsequent forward scrub step
    (ready for this now)
#12278
  - during forward scrub, look at these hints, and move folders
    around if we have more recent linkage information from the backtrace
    (maybe wait to do this later, it's a corner)

Backward scrub online
#12279
  - Add hooks to MDS to enable backward scrub to lookup_ino and work out
    if an "orphaned ino" is actually orphaned or just more recently
    created than the last scrub.
  - Add hooks to MDS to enable injection to be done online (i.e. inject
    linkage RPC)
#12280
  - Use hooks from backward scrub in a new mode that is readonly on the
    RADOS pools, and mediates all writes through running MDS.

Handling purged strays:
#12281
  * StrayManager needs to respect PIN_SCRUBQUEUE (remove it from the scrub
  stack before purging it) and the Locker locks that scrubstack uses (don't
  purge it until the ongoing scrub RADOS ops are done)
(added a note to #11950)
  * if/when we add purgequeue, #11950, backward scrub will also need to
  interrogate that to determine non-orphan-ness of an inode, or enforce
  that it gets flushed before doing anything.

#11859 - DamageTable

Status & scheduling
#12282
  - List/progress/abort/pause commands for ongoing scrub
#12283
  - Time of day scheduling for scrub
#12284
  - Deprioritise/pause scrub on highly loaded systems (loaded MDS, 
loaded RADOS)
