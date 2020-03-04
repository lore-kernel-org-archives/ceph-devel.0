From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v4 0/6] ceph: don't request caps for idle open files
Date: Thu,  5 Mar 2020 01:32:52 +0800
Message-ID: <20200304173258.48377-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgCDRdH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 12:33:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

This series make cephfs client not request caps for open files that
idle for a long time. For the case that one active client and multiple
standby clients open the same file, this increase the possibility that
mds issues exclusive caps to the active client.

Yan, Zheng (6):
  ceph: always renew caps if mds_wanted is insufficient
  ceph: consider inode's last read/write when calculating wanted caps
  ceph: remove delay check logic from ceph_check_caps()
  ceph: simplify calling of ceph_get_fmode()
  ceph: update i_requested_max_size only when sending cap msg to auth mds
  ceph: check all mds' caps after page writeback

 fs/ceph/caps.c               | 338 ++++++++++++++++-------------------
 fs/ceph/file.c               |  45 ++---
 fs/ceph/inode.c              |  21 +--
 fs/ceph/ioctl.c              |   2 +
 fs/ceph/mds_client.c         |   5 -
 fs/ceph/super.h              |  37 ++--
 include/linux/ceph/ceph_fs.h |   1 +
 7 files changed, 202 insertions(+), 247 deletions(-)

changes since v2
 - make __ceph_caps_file_wanted() more readable
 - add patch 5 and 6, which fix hung write during testing patch 1~4

changes since v3
 - don't queue delayed cap check for snap inode
 - initialize ci->{last_rd,last_wr} to jiffies - 3600 * HZ
 - make __ceph_caps_file_wanted() check inode type

--=20
2.21.1
