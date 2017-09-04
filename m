From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 00/13] ceph: snapshot and multimds fixes
Date: Mon,  4 Sep 2017 17:38:55 +0800
Message-ID: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbdIDJjU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:39:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

Yan, Zheng (13):
  ceph: fix null pointer dereference in ceph_flush_snaps()
  ceph: fix message order check in handle_cap_export()
  ceph: handle race between vmtruncate and queuing cap snap
  ceph: queue cap snap only when snap realm's context changes
  ceph: remove stale check in ceph_invalidatepage()
  ceph: properly get capsnap's size in get_oldest_context()
  ceph: make writepage_nounlock() invalidate page that beyonds EOF
  ceph: optimize pagevec iterating in ceph_writepages_start()
  ceph: cleanup local varibles in ceph_writepages_start()
  ceph: fix "range cyclic" mode writepages
  ceph: ignore wbc->range_{start,end} when write back snapshot data
  ceph: fix capsnap dirty pages accounting
  ceph: wait on writeback after writing snapshot data

 fs/ceph/addr.c  | 362 +++++++++++++++++++++++++++++++++-----------------------
 fs/ceph/caps.c  |   4 +-
 fs/ceph/inode.c |  13 +-
 fs/ceph/snap.c  |  37 +++---
 4 files changed, 244 insertions(+), 172 deletions(-)

-- 
2.13.5

