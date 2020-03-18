From: xiubli@redhat.com
Subject: [PATCH v10 0/6] ceph: add perf metrics support
Date: Wed, 18 Mar 2020 10:05:50 -0400
Message-ID: <1584540356-5885-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56720 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgCROGU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:06:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V10:
- rebase to the latest testing branch
- merge all the metric related patches into one
- [1/6] move metric helpers into a new file metric.c
- [2/6] move metric helpers into metric.c
- [3/6] merge the read/write patches into a signal patch and move metric helpers to metric.c
- [4/6] move metric helpers to metric.c
- [5/6] min/max latency support
- [6/6] standard deviation support

Changed in V9:
- add an r_ended field to the mds request struct and use that to calculate the metric
- fix some commit comments

# cat /sys/kernel/debug/ceph/9a972bfc-68cb-4d52-a610-7cd9a9adbbdd.client52904/metrics
item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
-----------------------------------------------------------------------------------
read          798         32000           4000            196000          560.3
write         2394        588000          28000           4812000         36673.9
metadata      7           116000          2000            707000          8282.8

item          total           miss            hit
-------------------------------------------------
d_lease       2               0               0
caps          2               14              546500




Xiubo Li (6):
  ceph: add dentry lease metric support
  ceph: add caps perf metric for each session
  ceph: add read/write latency metric support
  ceph: add metadata perf metric support
  ceph: add min/max latency support for read/write/metadata metrics
  ceph: add standard deviation support for read/write/metadata perf
    metric

 fs/ceph/Makefile                |   2 +-
 fs/ceph/acl.c                   |   2 +-
 fs/ceph/addr.c                  |  18 ++++
 fs/ceph/caps.c                  |  19 ++++
 fs/ceph/debugfs.c               | 116 +++++++++++++++++++++++-
 fs/ceph/dir.c                   |  17 +++-
 fs/ceph/file.c                  |  26 ++++++
 fs/ceph/inode.c                 |   4 +-
 fs/ceph/mds_client.c            |  21 ++++-
 fs/ceph/mds_client.h            |   7 +-
 fs/ceph/metric.c                | 193 ++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h                |  64 +++++++++++++
 fs/ceph/super.h                 |   9 +-
 fs/ceph/xattr.c                 |   4 +-
 include/linux/ceph/osd_client.h |   1 +
 net/ceph/osd_client.c           |   2 +
 16 files changed, 487 insertions(+), 18 deletions(-)
 create mode 100644 fs/ceph/metric.c
 create mode 100644 fs/ceph/metric.h

-- 
1.8.3.1
