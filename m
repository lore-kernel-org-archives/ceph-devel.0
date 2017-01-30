From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 0/5] ceph: fix performance regression due to ceph_d_revalidate fixes
Date: Mon, 30 Jan 2017 11:19:37 -0500
Message-ID: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbdA3QTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 11:19:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Zheng mentioned that he had gotten a report that testing with vdbench on
a v4.8 kernel showed a large increase in the number of GETATTR calls
being made. Since we had changed the d_revalidate code to use a GETATTR
call and not set r_locked_dir in the request, the dentry lease wasn't
getting updated from the traces, even when the MDS had granted one.

This set does a bit of cleanup and bugfixing in ceph_fill_trace, and
sets it up to update the dentry lease even when r_locked_dir isn't set
in the request.

I was able to reproduce this by hand, and this seems to fix the issue.

Jeff Layton (5):
  ceph: don't update_dentry_lease unless we actually got one
  ceph: vet the parent inode before updating dentry lease
  ceph: clean up r_aborted handling in ceph_fill_trace
  ceph: call update_dentry_lease even when r_locked dir is not set
  ceph: do a LOOKUP in d_revalidate instead of GETATTR

 fs/ceph/dir.c   |  4 ++--
 fs/ceph/inode.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 19 deletions(-)

-- 
2.9.3

