From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 0/6] Rados pool namespace support
Date: Fri,  5 Feb 2016 22:31:31 +0800
Message-ID: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45523 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbcBEObx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 09:31:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This series adds pool namespae support for libceph and cephfs. I also pushed
the code to https://github.com/ceph/ceph-client/tree/wip-fs-filelayout2.


Yan, Zheng (6):
  libceph: define new ceph_file_layout structure
  libceph: introduce pool namespace cache
  libceph: rados pool namesapce support
  libceph: make sure redirect does not change namespace
  libceph: calculate request message size according to namespace
  ceph: rados pool namesapce support

 drivers/block/rbd.c                |  17 ++---
 fs/ceph/addr.c                     |  78 +++++++++++++++++-----
 fs/ceph/caps.c                     |  47 +++++++++----
 fs/ceph/file.c                     |  15 +++--
 fs/ceph/inode.c                    |  15 ++++-
 fs/ceph/ioctl.c                    |  22 +++---
 fs/ceph/mds_client.c               |  11 +++
 fs/ceph/mds_client.h               |   6 +-
 fs/ceph/xattr.c                    |  90 ++++++++++++++++---------
 include/linux/ceph/ceph_features.h |   1 +
 include/linux/ceph/ceph_fs.h       |  53 +++++++--------
 include/linux/ceph/libceph.h       |   1 +
 include/linux/ceph/osd_client.h    |   2 +
 include/linux/ceph/osdmap.h        |   1 +
 include/linux/ceph/pool_ns.h       |  47 +++++++++++++
 net/ceph/Makefile                  |   2 +-
 net/ceph/ceph_common.c             |   2 +
 net/ceph/ceph_fs.c                 |  33 ++++++++-
 net/ceph/osd_client.c              |  73 +++++++++++++++-----
 net/ceph/osdmap.c                  |  39 ++++++++---
 net/ceph/pool_ns.c                 | 133 +++++++++++++++++++++++++++++++++++++
 21 files changed, 539 insertions(+), 149 deletions(-)
 create mode 100644 include/linux/ceph/pool_ns.h
 create mode 100644 net/ceph/pool_ns.c

-- 
2.5.0

