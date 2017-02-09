From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 0/6] ceph: implement new-style ENOSPC handling in kcephfs
Date: Thu,  9 Feb 2017 09:48:30 -0500
Message-ID: <20170209144836.12525-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbdBIOsx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 09:48:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

v4: eliminate map_cb and just call ceph_osdc_abort_on_full directly
Revert earlier patch flagging individual pages with error on writeback
failure. Add mechanism to force synchronous writes when writes start
failing, and reallowing async writes when they succeed.

v3: track "abort_on_full" behavior with a new bool in osd request
instead of a protocol flag. Remove some extraneous arguments from
various functions. Don't export have_pool_full, call it from the
abort_on_full callback instead.

v2: teach libcephfs how to hold on to requests until the right map
epoch appears, instead of delaying cap handling in the cephfs layer.

Ok, with this set, I think we have proper -ENOSPC handling for all
different write types (direct, sync, async buffered, etc...). -ENOSPC
conditions.

First I trimmed down the original set to have less tendrils in ceph.ko
when we hit a full condition. Most of the machinery for that is now in
libceph.ko, and cephfs just sets the r_abort_on_full flag on the
appropriate calls.

For buffered, synchronous writes, it also reverts a patch that flags
individual pages with the PG_error bit on writeback failure. I don't
think we want that for the reasons described in the patch.

Finally, this also adds a new mechanism that forces synchronous writes
on an inode when write requests start failing.

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

This version incorporates changes based on Ilya's cursory review
yesterday. It also cleans up the handling of requests that should
be aborted on a full condition. The patch that exports have_pool_full
has also been dropped since it's no longer needed.

Jeff Layton (6):
  libceph: allow requests to return immediately on full conditions if
    caller wishes
  libceph: abort already submitted but abortable requests when map or
    pool goes full
  libceph: add an epoch_barrier field to struct ceph_osd_client
  ceph: handle epoch barriers in cap messages
  Revert "ceph: SetPageError() for writeback pages if writepages fails"
  ceph: when seeing write errors on an inode, switch to sync writes

 fs/ceph/addr.c                  | 14 ++++--
 fs/ceph/caps.c                  | 17 ++++++--
 fs/ceph/file.c                  | 50 ++++++++++++++++------
 fs/ceph/mds_client.c            | 20 +++++++++
 fs/ceph/mds_client.h            |  7 ++-
 fs/ceph/super.h                 | 26 +++++++++++
 include/linux/ceph/osd_client.h |  3 ++
 net/ceph/osd_client.c           | 95 +++++++++++++++++++++++++++++++++++++----
 8 files changed, 201 insertions(+), 31 deletions(-)

-- 
2.9.3

