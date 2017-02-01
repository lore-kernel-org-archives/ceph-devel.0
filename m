From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 00/13] ceph: fix performance regression due to ceph_d_revalidate fixes
Date: Wed,  1 Feb 2017 06:49:01 -0500
Message-ID: <20170201114914.20808-1-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBALtS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:18 -0500
In-Reply-To: <20170130161942.16537-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

v2: fix a hang that would occasionally occur under fsstress

This is the second version of this patchset, and is a bit more of an
overhaul. I revised the set because I was seeing fsstress hangs.

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
of bools also shrinks the request size slightly. If everyone hates
that, I can just plop in another bool, but I think this gives us
more room to expand with other flags as needed.

Jeff Layton (13):
  ceph: add new r_req_flags field to ceph_mds_request
  ceph: move r_aborted flag into r_req_flags
  ceph: move r_got_unsafe flag into r_req_flags
  ceph: move r_got_safe flag into r_req_flags
  ceph: move r_got_result into r_req_flags
  ceph: move r_did_prepopulate into r_req_flags
  ceph: remove "Debugging hook" from ceph_fill_trace
  ceph: don't need session pointer to ceph_fill_trace
  ceph: add a new flag to indicate whether parent is locked
  ceph: don't update_dentry_lease unless we actually got one
  ceph: vet the parent inode before updating dentry lease
  ceph: call update_dentry_lease even when r_locked dir is not set
  ceph: do a LOOKUP in d_revalidate instead of GETATTR

 fs/ceph/debugfs.c    |   2 +-
 fs/ceph/dir.c        |  30 +++++++++------
 fs/ceph/export.c     |   3 +-
 fs/ceph/file.c       |   3 +-
 fs/ceph/inode.c      | 104 ++++++++++++++++++++++-----------------------------
 fs/ceph/mds_client.c |  73 +++++++++++++++++++-----------------
 fs/ceph/mds_client.h |  15 +++++---
 fs/ceph/super.h      |   3 +-
 8 files changed, 118 insertions(+), 115 deletions(-)

-- 
2.9.3

