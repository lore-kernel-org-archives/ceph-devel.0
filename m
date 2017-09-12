From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 0/5] ceph: file lock related fixes
Date: Tue, 12 Sep 2017 10:53:46 +0800
Message-ID: <20170912025351.42147-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdILCyF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Sep 2017 22:54:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

Yan, Zheng (5):
  ceph: keep auth cap when inode has flocks or posix locks
  ceph: make lock_to_ceph_filelock() 'static'
  ceph: optimize flock encoding during reconnect
  ceph: handle 'session get evicted while there are file locks'
  ceph: avoid null pointer derefernece in case of utsname() return NULL

 fs/ceph/inode.c      |   1 +
 fs/ceph/locks.c      | 177 ++++++++++++++++++++++++++++++++++++---------------
 fs/ceph/mds_client.c |  61 ++++++++++++------
 fs/ceph/mds_client.h |   3 +
 fs/ceph/super.h      |   4 +-
 5 files changed, 174 insertions(+), 72 deletions(-)

-- 
2.13.5

