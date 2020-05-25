From: xiubli@redhat.com
Subject: [PATCH v2 0/2] ceph: fix dead lock and double lock
Date: Mon, 25 May 2020 07:16:23 -0400
Message-ID: <1590405385-27406-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389897AbgEYLQh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 25 May 2020 07:16:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- do not check the caps when reconnecting to mds
- switch ceph_async_check_caps() to ceph_async_put_cap_refs()


Xiubo Li (2):
  ceph: add ceph_async_put_cap_refs to avoid double lock and deadlock
  ceph: do not check the caps when reconnecting to mds

 fs/ceph/caps.c       | 45 +++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/dir.c        |  2 +-
 fs/ceph/file.c       |  2 +-
 fs/ceph/inode.c      |  3 +++
 fs/ceph/mds_client.c | 24 ++++++++++++++++--------
 fs/ceph/mds_client.h |  3 ++-
 fs/ceph/super.h      |  7 +++++++
 7 files changed, 73 insertions(+), 13 deletions(-)

-- 
1.8.3.1
