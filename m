From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 0/6] ceph: implement new-style ENOSPC handling in kcephfs
Date: Mon,  6 Feb 2017 08:29:21 -0500
Message-ID: <20170206132927.9219-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdBFN33 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 08:29:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

v2: teach libcephfs how to hold on to requests until the right map
epoch appears, instead of delaying cap handling in the cephfs layer.

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

The patchset has undergone a number of changes since the original
submission, and now more closely resembles the approach taken by the
userland cephfs code. When it sees a new epoch barrier, it communicates
that to libcephfs which then uses the normal request target pausing
mechanism to hold them until the right map comes in.

With this, xfstests seems to work as well as before, and we get timely
-ENOSPC returns under these conditions with O_DIRECT writes. I still
need to plumb in a way to throttle the dirtying of new pages in buffered
I/O when we are getting errors during writeback. Still, I figure this is
a good place to pause to make sure that things look ok in the set before
I implement that part.

Jeff Layton (5):
  libceph: add an epoch_barrier field to struct ceph_osd_client
  libceph: rename and export have_pool_full
  ceph: register map callback to handle ENOSPC conditions
  ceph: handle epoch barriers in cap messages
  libceph: allow requests to return immediately on full conditions if
    caller wishes

John Spray (1):
  libceph: add ceph_osdc_complete_writes

 fs/ceph/addr.c                  |  14 ++++--
 fs/ceph/caps.c                  |  17 +++++--
 fs/ceph/file.c                  |   8 +--
 fs/ceph/mds_client.c            |  38 +++++++++++++++
 fs/ceph/mds_client.h            |   7 ++-
 include/linux/ceph/osd_client.h |  15 ++++++
 include/linux/ceph/rados.h      |   1 +
 net/ceph/osd_client.c           | 105 +++++++++++++++++++++++++++++++++++-----
 8 files changed, 180 insertions(+), 25 deletions(-)

-- 
2.9.3

