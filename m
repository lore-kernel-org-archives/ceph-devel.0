From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 00/11] tiering support
Date: Mon, 27 Jan 2014 17:58:42 +0200
Message-ID: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34983 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaA0P7y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 10:59:54 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so4635795lab.15
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 07:59:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Hello,

This series adds (limited, see 10/11 for more explanation) tiering
support to the kernel client.  Patches 01-05/11 prepare the ground,
06-08/11 implement basic tiering, 09-10/11 handle redirect replies,
11/11 announces tiering support to the server side.

Thanks,

                Ilya


Ilya Dryomov (11):
  libceph: start using oloc abstraction
  libceph: move ceph_file_layout helpers to ceph_fs.h
  libceph: rename MAX_OBJ_NAME_SIZE to CEPH_MAX_OID_NAME_LEN
  libceph: introduce and start using oid abstraction
  libceph: replace ceph_calc_ceph_pg() with ceph_oloc_oid_to_pg()
  libceph: CEPH_OSD_FLAG_* enum update
  libceph: add ceph_pg_pool_by_id()
  libceph: follow {read,write}_tier fields on osd request submission
  libceph: rename ceph_osd_request::r_{oloc,oid} to r_base_{oloc,oid}
  libceph: follow redirect replies from osds
  libceph: support CEPH_FEATURE_OSD_CACHEPOOL feature

 drivers/block/rbd.c                |   20 ++--
 fs/ceph/ioctl.c                    |    8 +-
 include/linux/ceph/ceph_features.h |    1 +
 include/linux/ceph/ceph_fs.h       |   23 ++++
 include/linux/ceph/osd_client.h    |   18 ++--
 include/linux/ceph/osdmap.h        |   66 +++++++-----
 include/linux/ceph/rados.h         |    4 +
 net/ceph/debugfs.c                 |    3 +-
 net/ceph/osd_client.c              |  206 +++++++++++++++++++++++++++++++++---
 net/ceph/osdmap.c                  |   62 ++++++++---
 10 files changed, 332 insertions(+), 79 deletions(-)

-- 
1.7.10.4

