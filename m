From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v1 0/7] ceph: implement new-style ENOSPC handling in kcephfs
Date: Fri, 20 Jan 2017 10:17:31 -0500
Message-ID: <20170120151738.9584-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdATPRj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 10:17:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

The patchset has undergone a number of changes since the original
submission:

- updated for final version of CAPRELEASE message changes
- protect delayed cap list with spinlock instead of mutex/rwsem
- no need to allocate a new object to track delayed cap requests
- rerunning delayed caps is now shuffled off to a workqueue
- properly handle requests that come in after the "full" map comes in
- clean out delayed cap requests on last session put

With this, xfstests seems to work as well as before, and we get timely
-ENOSPC returns under these conditions with O_DIRECTi writes.

I still need to plumb in a way to throttle the dirtying of new pages in
buffered I/O when we are getting errors during writeback. Still, I
figure this is a good place to pause and post the set before I implement
that part.

Jeff Layton (7):
  libceph: add ceph_osdc_cancel_writes
  libceph: rename and export have_pool_full
  libceph: rename and export maybe_request_map
  ceph: handle new osdmap epoch updates in CLIENT_CAPS and WRITE
    codepaths
  ceph: update CAPRELEASE message format
  ceph: clean out delayed caps when destroying session
  libceph: allow requests to return immediately on full conditions if
    caller wishes

 fs/ceph/addr.c                  |  14 ++++--
 fs/ceph/caps.c                  |  43 ++++++++++++++--
 fs/ceph/debugfs.c               |   3 ++
 fs/ceph/file.c                  |   8 +--
 fs/ceph/mds_client.c            | 108 ++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h            |  10 +++-
 include/linux/ceph/osd_client.h |  22 +++++++-
 include/linux/ceph/rados.h      |   1 +
 net/ceph/osd_client.c           |  88 +++++++++++++++++++++++++-------
 9 files changed, 263 insertions(+), 34 deletions(-)

-- 
2.9.3

