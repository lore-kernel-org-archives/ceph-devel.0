From: xiubli@redhat.com
Subject: [PATCH v4 0/5] ceph: periodically send perf metrics to ceph
Date: Sun, 28 Jun 2020 04:42:09 -0400
Message-ID: <1593333734-27480-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgF1Im3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:42:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This series is based the previous patches of the metrics in kceph[1]
and mds daemons record and forward client side metrics to manager[2][3].

This will send the caps/read/write/metadata metrics to any available
MDS only once per second, which will be the same as the userland client.
We could disable it via the enable_send_metrics module parameter.

And will also send the metric flags to MDS, currently it supports the
cap, read latency, write latency and metadata latency.

Also have pushed this series to github [4].

[1] https://patchwork.kernel.org/project/ceph-devel/list/?series=238907 [Merged]
[2] https://github.com/ceph/ceph/pull/26004 [Merged]
[3] https://github.com/ceph/ceph/pull/35608 [Merged]
[4] https://github.com/lxbsz/ceph-client/commits/perf_metric4

Changes in V4:
- WARN_ON --> WARN_ON_ONCE
- do not send metrics when no mds suppor the metric collection.
- add global total_caps in mdsc->metric
- add the delayed work for each session and choose one to send the metrics to get rid of the mdsc->mutex lock

Changed in V3:
- fold "check the METRIC_COLLECT feature before sending metrics" into previous one
- use `enable_send_metrics` on/off switch instead

Changed in V2:
- split the patches into small ones as possible.
- check the METRIC_COLLECT feature before sending metrics
- switch to WARN_ON and bubble up errnos to the callers



Xiubo Li (5):
  ceph: add check_session_state helper and make it global
  ceph: add global total_caps to count the mdsc's caps number
  ceph: periodically send perf metrics to ceph
  ceph: switch to WARN_ON_ONCE and bubble up errnos to the callers
  ceph: send client provided metric flags in client metadata

 fs/ceph/caps.c               |   2 +
 fs/ceph/mds_client.c         | 158 +++++++++++++++++++++++++++++++++++--------
 fs/ceph/mds_client.h         |   8 ++-
 fs/ceph/metric.c             | 156 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h             |  96 ++++++++++++++++++++++++++
 fs/ceph/super.c              |  42 ++++++++++++
 fs/ceph/super.h              |   2 +
 include/linux/ceph/ceph_fs.h |   1 +
 8 files changed, 434 insertions(+), 31 deletions(-)

-- 
1.8.3.1
