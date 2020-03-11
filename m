From: xiubli@redhat.com
Subject: [PATCH 0/2] add standard deviation support
Date: Tue, 10 Mar 2020 22:54:05 -0400
Message-ID: <1583895247-17312-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727506AbgCKCyU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:54:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

The idea came from Jeff's comment in previous patch series:

#  cat /sys/kernel/debug/ceph/81b62c25-7c41-4345-9140-201730bfdde0.client4333/metrics 
item          total       sum_lat(us)     avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
---------------------------------------------------------------------------------------------------
read          492         20817000        24000           3000            1027000         2571
write         400         1184122000      2994000         16000           5613000         53949
metadata      4           22000           5000            1000            16000           207

item          total           miss            hit
-------------------------------------------------
d_lease       2               0               1
caps          2               6               102140


Xiubo Li (2):
  ceph: move all the metric helpers into one separate file
  ceph: add standard deviation support for read/write/metadata perf
    metric

 fs/ceph/Makefile     |   2 +-
 fs/ceph/debugfs.c    |  70 +++++++++++------
 fs/ceph/mds_client.c |  95 +----------------------
 fs/ceph/metric.c     | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h     | 102 ++++++------------------
 5 files changed, 286 insertions(+), 197 deletions(-)
 create mode 100644 fs/ceph/metric.c

-- 
1.8.3.1
