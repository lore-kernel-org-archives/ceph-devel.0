From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v2 0/4] ceph: don't request caps for idle open files
Date: Fri, 21 Feb 2020 21:16:55 +0800
Message-ID: <20200221131659.87777-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgBUNRJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:17:09 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

This series make cephfs client not request caps for open files that
idle for a long time. For the case that one active client and multiple
standby clients open the same file, this increase the possibility that
mds issues exclusive caps to the active client.

Yan, Zheng (4):
  ceph: always renew caps if mds_wanted is insufficient
  ceph: consider inode's last read/write when calculating wanted caps
  ceph: simplify calling of ceph_get_fmode()
  ceph: remove delay check logic from ceph_check_caps()

 fs/ceph/caps.c               | 324 +++++++++++++++--------------------
 fs/ceph/file.c               |  39 ++---
 fs/ceph/inode.c              |  19 +-
 fs/ceph/ioctl.c              |   2 +
 fs/ceph/mds_client.c         |   5 -
 fs/ceph/super.h              |  35 ++--
 include/linux/ceph/ceph_fs.h |   1 +
 7 files changed, 188 insertions(+), 237 deletions(-)

--=20
2.21.1
