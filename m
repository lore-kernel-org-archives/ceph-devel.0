From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] ceph: fix long stalls on sync/syncfs
Date: Thu,  2 Apr 2020 07:29:09 -0400
Message-ID: <20200402112911.17023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388049AbgDBL3N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:29:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com, jfajerski@suse.com, lhenriques@suse.com, gfarnum@redhat.com

This is v2 of the patch I sent the other day to fix the problem of long
stalls when calling sync or syncfs.

This set converts the mdsc->cap_dirty list to a per-session list, and
then has the only caller that looks at cap_dirty walk the list of
sessions and issue flushes for each session in turn.

With this, we can use an empty s_cap_dirty list as an indicator that the
cap flush is the last one going to the session and can mark that one as
one we're waiting on so the MDS can expedite it.

This also attempts to clarify some of the locking around s_cap_dirty,
and adds a FIXME comment to raise the question about locking around
s_cap_flushing.

Jeff Layton (2):
  ceph: convert mdsc->cap_dirty to a per-session list
  ceph: request expedited service on session's last cap flush

 fs/ceph/caps.c       | 72 +++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/mds_client.h |  5 +--
 fs/ceph/super.h      | 21 +++++++++++--
 4 files changed, 87 insertions(+), 13 deletions(-)

-- 
2.25.1
