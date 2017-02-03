From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 0/8] ceph: fix performance regression due to ceph_d_revalidate fixes
Date: Fri,  3 Feb 2017 13:03:56 -0500
Message-ID: <20170203180404.31930-1-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbdBCSEG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:06 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

v3: Squash bool to flag change patches, and better explain why we need
to use atomic *_bit calls. Vet target and parent inodes when updating
lease. Update lease properly on negative dentries (when is_target is 0).
Also, update dentry leases even when call that triggered the request
is cancelled.

v2: Fix a hang that would occasionally occur under fsstress

Zheng mentioned that he had gotten a report that testing with vdbench on
a v4.8 kernel showed a large increase in the number of GETATTR calls
being made. Since we had changed the d_revalidate code to use a GETATTR
call and not set r_locked_dir in the request, the dentry lease wasn't
getting updated from the traces, even when the MDS had granted one.

We need to use a LOOKUP when revalidating dentries so we can update
the dentry lease if things look ok. That currently depends however on
having r_locked_dir set to the parent directory.

In d_revalidate though, we may very well not hold the parent's i_rwsem.
Manipulating the dcache is not allowed without it, but we can update the
inode and the dentry leases.

The basic approach here is to separate r_locked_dir into an inode
pointer representing the parent, and a flag indicating whether we
know that it's locked (note that it _may_ still be locked even if
that flag isn't set).

In ceph_fill_trace, we can then do all of the parts that don't require a
locked parent whenever the parent pointer is set, but avoid the
dcache manipulation when it isn't.

With this, dentry leases are again being updated as a result of
d_revalidate lookups. The switch to using a flags fields instead
of bools also shrinks the request size slightly. 

Jeff Layton (8):
  ceph: remove "Debugging hook" from ceph_fill_trace
  ceph: drop session argument to ceph_fill_trace
  ceph: convert bools in ceph_mds_request to a new r_req_flags field
  ceph: add a new flag to indicate whether parent is locked
  ceph: don't update_dentry_lease unless we actually got one
  ceph: vet the target and parent inodes before updating dentry lease
  ceph: call update_dentry_lease even when r_locked dir is not set
  ceph: do a LOOKUP in d_revalidate instead of GETATTR

 fs/ceph/debugfs.c    |   2 +-
 fs/ceph/dir.c        |  30 ++++++----
 fs/ceph/export.c     |   3 +-
 fs/ceph/file.c       |   3 +-
 fs/ceph/inode.c      | 164 ++++++++++++++++++++++++++++-----------------------
 fs/ceph/mds_client.c |  73 ++++++++++++-----------
 fs/ceph/mds_client.h |  15 +++--
 fs/ceph/super.h      |   3 +-
 8 files changed, 162 insertions(+), 131 deletions(-)

-- 
2.9.3

