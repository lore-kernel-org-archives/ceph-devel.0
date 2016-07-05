From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 0/4] ceph: allow ceph_d_revalidate to handle some cases under LOOKUP_RCU
Date: Tue,  5 Jul 2016 12:27:45 -0400
Message-ID: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbcGEQ1w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2016 12:27:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, zyan@redhat.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

The basic idea with this set is to allow the kernel client to allow the
client to do more d_revalidate functionality under the rcu_read_lock.
The idea is basically to do what we can there while not blocking, and
then return -ECHILD for the rest.

The only really questionable bit is the part where we need to take the
d_lock in ceph_d_release. I think it should be largely uncontended, but
it's still less than ideal. Maybe there is some way to handle that
locklessly?

Also, it would be nice to not have to drop out of rcuwalk mode in order
to run the lease renewal. It seems like the kind of thing that would be
ideal to queue to a workqueue, but I don't see a way to do that without
introducing a potential deadlock.

My teuthology run with it passed all but one test, which seems to have
been an unrelated problem (though I could be wrong there).

Jeff Layton (4):
  ceph: remove ceph_mdsc_lease_release
  ceph: clear d_fsinfo pointer under d_lock
  ceph: allow dentry_lease_is_valid to work under RCU walk
  ceph: handle LOOKUP_RCU in ceph_d_revalidate

 fs/ceph/dir.c        | 67 +++++++++++++++++++++++++++++++++++-----------------
 fs/ceph/mds_client.c | 41 --------------------------------
 fs/ceph/mds_client.h |  4 ----
 3 files changed, 45 insertions(+), 67 deletions(-)

-- 
2.5.5

