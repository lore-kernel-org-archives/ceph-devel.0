From: xiubli@redhat.com
Subject: [PATCH v2 0/5] ceph: periodically send perf metrics to ceph
Date: Thu, 18 Jun 2020 07:59:54 -0400
Message-ID: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728085AbgFRMBE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2020 08:01:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This series is based the previous patches of the metrics in kceph[1]
and mds daemons record and forward client side metrics to manager[2][3].

This will send the caps/read/write/metadata metrics to any available
MDS only once per second as default, which will be the same as the
userland client, or every metric_send_interval seconds, which is a
module parameter, the valid values for metric_send_interval will be
0~5 seconds, 0 means disabled.

And will also send the metric flags to MDS, currently it supports the
cap, read latency, write latency and metadata latency.

Also have pushed this series to github [4].

[1] https://patchwork.kernel.org/project/ceph-devel/list/?series=238907 [Merged]
[2] https://github.com/ceph/ceph/pull/26004 [Merged]
[3] https://github.com/ceph/ceph/pull/35608 [Merged]
[4] https://github.com/lxbsz/ceph-client/commits/perf_metric2


Changed in V2:
- split the patches into small ones as possible.
- check the METRIC_COLLECT feature before sending metrics
- switch to WARN_ON and bubble up errnos to the callers

Xiubo Li (5):
  ceph: add check_session_state helper and make it global
  ceph: periodically send perf metrics to ceph
  ceph: check the METRIC_COLLECT feature before sending metrics
  ceph: switch to WARN_ON and bubble up errnos to the callers
  ceph: send client provided metric flags in client metadata

 fs/ceph/mds_client.c         | 147 ++++++++++++++++++++++++++++++++++---------
 fs/ceph/mds_client.h         |   8 ++-
 fs/ceph/metric.c             | 142 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h             |  91 +++++++++++++++++++++++++++
 fs/ceph/super.c              |  49 +++++++++++++++
 fs/ceph/super.h              |   2 +
 include/linux/ceph/ceph_fs.h |   1 +
 7 files changed, 410 insertions(+), 30 deletions(-)

-- 
1.8.3.1
