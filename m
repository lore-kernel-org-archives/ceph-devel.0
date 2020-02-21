From: xiubli@redhat.com
Subject: [PATCH v8 0/5] ceph: add perf metrics support
Date: Fri, 21 Feb 2020 02:05:51 -0500
Message-ID: <20200221070556.18922-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726244AbgBUHGt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2020 02:06:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V8:
- address the comments for cap patch from Jeff.

We can get the metrics from the debugfs:

$ cat /sys/kernel/debug/ceph/0c93a60d-5645-4c46-8568-4c8f63db4c7f.client4=
267/metrics=20
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
 fs/ceph/addr.c                  |  13 ++++
 fs/ceph/caps.c                  |  19 ++++++
 fs/ceph/debugfs.c               |  71 ++++++++++++++++++++--
 fs/ceph/dir.c                   |  21 +++++--
 fs/ceph/file.c                  |  20 +++++++
 fs/ceph/inode.c                 |   4 +-
 fs/ceph/mds_client.c            | 103 +++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h            |   4 ++
 fs/ceph/metric.h                |  81 +++++++++++++++++++++++++
 fs/ceph/super.h                 |   9 ++-
 fs/ceph/xattr.c                 |   4 +-
 include/linux/ceph/osd_client.h |   1 +
 net/ceph/osd_client.c           |   2 +
 14 files changed, 336 insertions(+), 18 deletions(-)
 create mode 100644 fs/ceph/metric.h

--=20
2.21.0
