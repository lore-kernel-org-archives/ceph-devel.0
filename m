From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 00/16] rbd: support for exclusive-lock + mpath remap bits
Date: Wed, 24 Aug 2016 15:18:24 +0200
Message-ID: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36743 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbcHXNcy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:32:54 -0400
Received: by mail-yb0-f194.google.com with SMTP id f60so453302ybi.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:32:53 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.51
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This series already has a general thumbs up from Mike and an ack on
sysfs interface additions from Sage, but, as wip-exclusive-lock branch
has been through quite a few rebases recently, I wanted to send what
hopefully is the final version for a wider review.

Thanks,

                Ilya


Douglas Fuller (5):
  libceph: support for CEPH_OSD_OP_LIST_WATCHERS
  libceph: add ceph_osdc_call() single-page helper
  libceph: support for advisory locking on RADOS objects
  libceph: support for lock.lock_info
  libceph: support for blacklisting clients

Ilya Dryomov (7):
  libceph: rename ceph_entity_name_encode() ->
    ceph_auth_entity_name_encode()
  libceph: rename ceph_client_id() -> ceph_client_gid()
  rbd: introduce a per-device ordered workqueue
  rbd: retry watch re-registration periodically
  rbd: support for exclusive-lock feature
  rbd: print capacity in decimal and features in hex
  rbd: add 'client_addr' sysfs rbd device attribute

Mike Christie (4):
  rbd: add 'cluster_fsid' sysfs rbd device attribute
  rbd: add 'snap_id' sysfs rbd device attribute
  rbd: add 'config_info' sysfs rbd device attribute
  rbd: add force close option

 Documentation/ABI/testing/sysfs-bus-rbd |   29 +-
 drivers/block/rbd.c                     | 1195 +++++++++++++++++++++++++++----
 drivers/block/rbd_types.h               |   11 +
 include/linux/ceph/auth.h               |    2 +-
 include/linux/ceph/ceph_fs.h            |   11 +
 include/linux/ceph/cls_lock_client.h    |   49 ++
 include/linux/ceph/libceph.h            |    3 +-
 include/linux/ceph/mon_client.h         |    3 +
 include/linux/ceph/osd_client.h         |   23 +-
 net/ceph/Makefile                       |    1 +
 net/ceph/auth.c                         |    7 +-
 net/ceph/auth_none.c                    |    2 +-
 net/ceph/ceph_common.c                  |   13 +-
 net/ceph/ceph_strings.c                 |    1 +
 net/ceph/cls_lock_client.c              |  325 +++++++++
 net/ceph/mon_client.c                   |   82 +++
 net/ceph/osd_client.c                   |  169 +++++
 17 files changed, 1777 insertions(+), 149 deletions(-)
 create mode 100644 include/linux/ceph/cls_lock_client.h
 create mode 100644 net/ceph/cls_lock_client.c

-- 
2.4.3

