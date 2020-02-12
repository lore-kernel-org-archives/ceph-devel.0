From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/9] ceph: add support for asynchronous directory operations
Date: Wed, 12 Feb 2020 12:27:20 -0500
Message-ID: <20200212172729.260752-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBLR1c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:27:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idridryomov@gmail.com, sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com

I've dropped the async unlink patch from testing branch and am
resubmitting it here along with the rest of the create patches.

Zheng had pointed out that DIR_* caps should be cleared when the session
is reconnected. The underlying submission code needed changes to
handle that so it needed a bit of rework (along with the create code).

Since v3:
- rework async request submission to never queue the request when the
  session isn't open
- clean out DIR_* caps, layouts and delegated inodes when session goes down
- better ordering for dependent requests
- new mount options (wsync/nowsync) instead of module option
- more comprehensive error handling

Jeff Layton (9):
  ceph: add flag to designate that a request is asynchronous
  ceph: perform asynchronous unlink if we have sufficient caps
  ceph: make ceph_fill_inode non-static
  ceph: make __take_cap_refs non-static
  ceph: decode interval_sets for delegated inos
  ceph: add infrastructure for waiting for async create to complete
  ceph: add new MDS req field to hold delegated inode number
  ceph: cache layout in parent dir on first sync create
  ceph: attempt to do async create when possible

 fs/ceph/caps.c               |  73 +++++++---
 fs/ceph/dir.c                | 101 +++++++++++++-
 fs/ceph/file.c               | 253 +++++++++++++++++++++++++++++++++--
 fs/ceph/inode.c              |  58 ++++----
 fs/ceph/mds_client.c         | 156 +++++++++++++++++++--
 fs/ceph/mds_client.h         |  17 ++-
 fs/ceph/super.c              |  20 +++
 fs/ceph/super.h              |  21 ++-
 include/linux/ceph/ceph_fs.h |  17 ++-
 9 files changed, 637 insertions(+), 79 deletions(-)

-- 
2.24.1
