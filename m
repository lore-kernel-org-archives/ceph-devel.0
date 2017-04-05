From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v7 0/7] ceph: implement -ENOSPC handling in cephfs
Date: Wed,  5 Apr 2017 13:14:10 -0400
Message-ID: <20170405171417.25187-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933744AbdDERO0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Apr 2017 13:14:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

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

Ok, with this set, I think we have proper -ENOSPC handling for all
different write types (direct, sync, async buffered, etc...). -ENOSPC
conditions.

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

I this this should address all of Ilya's comments. Let me know if
I missed anything.

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

 fs/ceph/addr.c                  | 10 +++--
 fs/ceph/caps.c                  | 17 ++++++--
 fs/ceph/file.c                  | 32 ++++++++------
 fs/ceph/mds_client.c            | 20 +++++++++
 fs/ceph/mds_client.h            |  7 +++-
 fs/ceph/super.h                 | 26 ++++++++++++
 include/linux/ceph/osd_client.h |  4 +-
 net/ceph/debugfs.c              |  7 ++--
 net/ceph/osd_client.c           | 92 +++++++++++++++++++++++++++++++++++++----
 9 files changed, 179 insertions(+), 36 deletions(-)

-- 
2.9.3

