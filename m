From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] ceph: fix long stalls on sync/syncfs
Date: Mon,  6 Apr 2020 15:42:26 -0400
Message-ID: <20200406194228.52418-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFTmc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:42:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com, jfajerski@suse.com, lhenriques@suse.com, gfarnum@redhat.com

Just a small update from the last version. This adds a new helper
function to handle moving the inode to the appropriate lists when
auth caps change.

Also, remove a FIXME comment I had added as I think I've answered
the question on that for now (and a later patch will fix it).

Jeff Layton (2):
  ceph: convert mdsc->cap_dirty to a per-session list
  ceph: request expedited service on session's last cap flush

 fs/ceph/caps.c       | 86 ++++++++++++++++++++++++++++++++++++--------
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/mds_client.h |  5 +--
 fs/ceph/super.h      | 19 ++++++++--
 4 files changed, 91 insertions(+), 21 deletions(-)

-- 
2.25.1
