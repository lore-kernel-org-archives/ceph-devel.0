From: xiubli@redhat.com
Subject: [PATCH v3 0/2] ceph: fix dead lock and double lock
Date: Tue, 26 May 2020 21:42:34 -0400
Message-ID: <1590543756-26773-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbgE0Bms (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 26 May 2020 21:42:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- do not check the caps when reconnecting to mds
- switch ceph_async_check_caps() to ceph_async_put_cap_refs()

Changed in V3:
- fix putting the cap refs leak

By adding the put_cap_refs's queue work we can avoid the 'mdsc->mutex' and
'session->s_mutex' double lock issue and also the dead lock issue of them.
There at least 10+ places have the above issues and most of them are caused
by calling the ceph_mdsc_put_request() when releasing the 'req'.

Xiubo Li (2):
  ceph: add ceph_async_put_cap_refs to avoid double lock and deadlock
  ceph: do not check the caps when reconnecting to mds

 fs/ceph/caps.c       | 98 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/ceph/dir.c        |  2 +-
 fs/ceph/file.c       |  2 +-
 fs/ceph/inode.c      |  3 ++
 fs/ceph/mds_client.c | 14 +++++---
 fs/ceph/mds_client.h |  3 +-
 fs/ceph/super.h      |  7 ++++
 7 files changed, 110 insertions(+), 19 deletions(-)

-- 
1.8.3.1
