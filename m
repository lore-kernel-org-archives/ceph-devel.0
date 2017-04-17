From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v8 0/7] ceph: implement -ENOSPC handling in cephfs
Date: Mon, 17 Apr 2017 12:42:51 -0400
Message-ID: <20170417164258.31527-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754367AbdDQQnD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Apr 2017 12:43:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

v8: fix deadlock when releasing caps after a cancelled operation
    set epoch_barrier before cancelling operations on full conditions

v7: don't request a continuous sub when the epoch is not yet at the
    barrier. Don't set epoch barrier unless we aborted a call that
    may have already been sent. Use READ_ONCE in lockless ERROR_WRITE
    flag handling.

v6: reset barrier to current epoch when receiving map with full pool or
    at quota condition. Show epoch barrier in debugfs. Don't take osd->lock
    unnecessarily. Remove req->r_replay_version. Other cleanups and
    fixes suggested by Ilya.

v5: rebase onto ACK vs. commit changes

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

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

This is ai small update to the set I posted a couple of weeks ago.

We hit a deadlock in testing that was due to taking the osdc->lock
recursively. While diagnosing that, I realized that we can end up
releasing caps as a result of a cancelled operation.

In that case, we probably want to ensure that the cap release message
has an updated epoch barrier in it, so there's also a change to
ceph_osdc_abort_on_full to set the epoch barrier prior to cancelling the
operations.

So far this seems to do well with the re-enabled ENOSPC testing in
teuthology, though we do have to make a small change to the testsuite to
compensate for a difference between kcephfs and ceph-fuse.  ceph-fuse
returns errors on a close if there were writeback issues prior to
closing. The kernel does not do that currently.

For now, we're leaving the kcephfs behavior as-is. I think this is a
place where we need to have consistent behavior across Linux
filesystems, and that means a larger discussion about what userspace
consumers really want here.

Jeff Layton (7):
  libceph: remove req->r_replay_version
  libceph: allow requests to return immediately on full conditions if
    caller wishes
  libceph: abort already submitted but abortable requests when map or
    pool goes full
  libceph: add an epoch_barrier field to struct ceph_osd_client
  ceph: handle epoch barriers in cap messages
  Revert "ceph: SetPageError() for writeback pages if writepages fails"
  ceph: when seeing write errors on an inode, switch to sync writes

 fs/ceph/addr.c                  |  10 ++--
 fs/ceph/caps.c                  |  21 +++++--
 fs/ceph/file.c                  |  32 ++++++-----
 fs/ceph/mds_client.c            |  20 +++++++
 fs/ceph/mds_client.h            |   7 ++-
 fs/ceph/super.h                 |  26 +++++++++
 include/linux/ceph/osd_client.h |   4 +-
 net/ceph/debugfs.c              |   7 +--
 net/ceph/osd_client.c           | 118 +++++++++++++++++++++++++++++++++++++---
 9 files changed, 208 insertions(+), 37 deletions(-)

-- 
2.9.3

