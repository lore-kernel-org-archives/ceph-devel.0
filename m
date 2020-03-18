From: xiubli@redhat.com
Subject: [PATCH v4 0/4] ceph: add min/max/stdev latency support
Date: Wed, 18 Mar 2020 01:45:51 -0400
Message-ID: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59050 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRFqJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:46:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Changed in V4:
- fix the 32-bit arches div errors by using DIV64_U64_ROUND_CLOSEST instead. [1/4]
- rebase and combine the stdev patch series [3/4][4/4]
- remove the sum latency showing, which makes no sense for debugging, if it
  is really needed in some case then just do (avg * total) in userland. [4/4]
- switch {read/write/metadata}_latency_sum to atomic type since it will be
  readed very time when updating the latencies to calculate the stdev. [4/4]

Changed in V2:
- switch spin lock to cmpxchg [1/4]

Changed in V3:
- add the __update_min/max_latency helpers [1/4]



# cat /sys/kernel/debug/ceph/0f923fe5-00e6-4866-bf01-2027cb75e94b.client4150/metrics
item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
-----------------------------------------------------------------------------------
read          2312        9000            1000            100000          607.4
write         21777       925000          2000            44551000        29700.3
metadata      6           4179000         1000            21414000        19590.8

item          total           miss            hit
-------------------------------------------------
d_lease       2               0               11
caps          2               14              398418



Xiubo Li (4):
  ceph: switch to DIV64_U64_ROUND_CLOSEST to support 32-bit arches
  ceph: add min/max latency support for read/write/metadata metrics
  ceph: move the metric helpers into one separate file
  ceph: add standard deviation support for read/write/metadata perf
    metric

 fs/ceph/Makefile     |   2 +-
 fs/ceph/debugfs.c    |  89 ++++++++++++++++++------
 fs/ceph/mds_client.c |  83 +---------------------
 fs/ceph/metric.c     | 190 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h     |  79 +++++++++++----------
 5 files changed, 297 insertions(+), 146 deletions(-)
 create mode 100644 fs/ceph/metric.c

-- 
1.8.3.1
