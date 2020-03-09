From: xiubli@redhat.com
Subject: [PATCH v9 0/5] ceph: add perf metrics support
Date: Mon,  9 Mar 2020 03:37:05 -0400
Message-ID: <1583739430-4928-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIHhX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2020 03:37:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V9:
- add an r_ended field to the mds request struct and use that to calculate the metric
- fix some commit comments

We can get the metrics from the debugfs:

$ cat /sys/kernel/debug/ceph/0c93a60d-5645-4c46-8568-4c8f63db4c7f.client4267/metrics 
item          total       sum_lat(us)     avg_lat(us)
-----------------------------------------------------
read          13          417000          32076
write         42          131205000       3123928
metadata      104         493000          4740

item          total           miss            hit
-------------------------------------------------
d_lease       204             0               918
caps          204             213             368218


Xiubo Li (5):
  ceph: add global dentry lease metric support
  ceph: add caps perf metric for each session
  ceph: add global read latency metric support
  ceph: add global write latency metric support
  ceph: add global metadata perf metric support

 fs/ceph/acl.c                   |   2 +-
 fs/ceph/addr.c                  |  18 +++++++
 fs/ceph/caps.c                  |  19 ++++++++
 fs/ceph/debugfs.c               |  71 ++++++++++++++++++++++++++--
 fs/ceph/dir.c                   |  17 ++++++-
 fs/ceph/file.c                  |  26 ++++++++++
 fs/ceph/inode.c                 |   4 +-
 fs/ceph/mds_client.c            | 102 +++++++++++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h            |   7 ++-
 fs/ceph/metric.h                |  69 +++++++++++++++++++++++++++
 fs/ceph/super.h                 |   9 ++--
 fs/ceph/xattr.c                 |   4 +-
 include/linux/ceph/osd_client.h |   1 +
 net/ceph/osd_client.c           |   2 +
 14 files changed, 334 insertions(+), 17 deletions(-)
 create mode 100644 fs/ceph/metric.h

-- 
1.8.3.1
