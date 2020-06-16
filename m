From: xiubli@redhat.com
Subject: [PATCH 0/2] ceph: periodically send perf metrics to ceph
Date: Tue, 16 Jun 2020 08:52:28 -0400
Message-ID: <1592311950-17623-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728160AbgFPMwv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 08:52:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This series is based the previous patches of the metrics in kceph[1]
and mds daemons record and forward client side metrics to manager[2].

This will send the caps/read/write/metadata metrics to any available
MDS only once per second as default, which will be the same as the
userland client, or every metric_send_interval seconds, which is a
module parameter, the valid values for metric_send_interval will be
1~5 seconds.

And will also send the metric flags to MDS, currently it supports the
cap, read latency, write latency and metadata latency.

[1] https://patchwork.kernel.org/project/ceph-devel/list/?series=238907 [Merged]
[2] https://github.com/ceph/ceph/pull/26004 [Merged]

Xiubo Li (2):
  ceph: periodically send perf metrics to ceph
  ceph: send client provided metric flags in client metadata

 fs/ceph/mds_client.c         |  93 +++++++++++++++++++++++-------
 fs/ceph/mds_client.h         |   4 ++
 fs/ceph/metric.c             | 133 +++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h             |  91 +++++++++++++++++++++++++++++
 fs/ceph/super.c              |  29 ++++++++++
 include/linux/ceph/ceph_fs.h |   1 +
 6 files changed, 332 insertions(+), 19 deletions(-)

-- 
1.8.3.1
