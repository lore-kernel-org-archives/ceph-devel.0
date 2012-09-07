From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: locking, snapshot registration, snap_by_name()
Date: Fri, 07 Sep 2012 09:47:43 -0500
Message-ID: <504A090F.7000706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43621 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab2IGOrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 10:47:45 -0400
Received: by ieje11 with SMTP id e11so5141909iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 07:47:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The patches in this fourth series is not very well related to
each other.

The first two make the bulk of the initialization of an rbd_dev
occur while holding its semaphore.  It's done in two steps to
make review easier.

The third deletes some code that some analysis shows is not
necessary.

The fourth one is significant for version 2 images.  It changes
rbd_snap_by_name() so it uses the rbd_dev->snaps list in looking
up a snapshot id by name rather than using the snapshot context.
For version 2 images, having a snapshot context doesn't imply
the names for the snapshot ids in that context are readily available.
However all snapshots in the snaps list will already have a cached
copy of snapshot names (for both format 1 and 2) so this allows
this single lookup function to work efficiently for both formats.

It is available as branch "wip-rbd-review-4" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-3".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-4

					-Alex

[PATCH 1/4]  f3b3dfe rbd: move locking out of rbd_header_set_snap()
[PATCH 2/4]  aecdaf1 rbd: expand lock protection in rbd_add()
[PATCH 3/4]  9278d3a rbd: don't register snapshots in bus_add_dev()
[PATCH 4/4]  dcc54d7 rbd: use snaps list in rbd_snap_by_name()
