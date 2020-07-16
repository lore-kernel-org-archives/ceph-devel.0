From: xiubli@redhat.com
Subject: [PATCH v6 0/2] ceph: periodically send perf metrics to ceph
Date: Thu, 16 Jul 2020 10:05:56 -0400
Message-ID: <20200716140558.5185-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727044AbgGPOGj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:06:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This series is based the previous patches of the metrics in kceph[1]
and mds daemons record and forward client side metrics to manager[2][3].

This will send the caps/read/write/metadata metrics to any available
MDS only once per second, which will be the same as the userland client.
We could disable it via the disable_send_metrics module parameter.

In mdsc->metric we have one important member:
'metric.session': hold the available and valid session to send the metrics,
                  we will hold the session reference until its state is no
                  longer good or when doing the unmount to release the
                  resources.

And will also send the metric flags to MDS, currently it supports the
cap, read latency, write latency and metadata latency.

Also I have pushed this series to github [4].

[1] https://patchwork.kernel.org/project/ceph-devel/list/?series=238907 [Merged]
[2] https://github.com/ceph/ceph/pull/26004 [Merged]
[3] https://github.com/ceph/ceph/pull/35608 [Merged]
[4] https://github.com/lxbsz/ceph-client/commits/perf_metric6

Changed in V6:
- switch 'ceph_fsc_lock' to spin lock
- metric.mds --> metric.session, to hold the session reference instead until its state is no longer good to get rid of the mutex lock.

Changed in V5:
- rename enable_send_metrics --> disable_send_metrics
- switch back to a single workqueue job.
- 'list' --> 'metric_wakeup'

Changed in V4:
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






Xiubo Li (2):
  ceph: periodically send perf metrics to ceph
  ceph: send client provided metric flags in client metadata

 fs/ceph/mds_client.c         |  64 ++++++++++++++-
 fs/ceph/mds_client.h         |   4 +-
 fs/ceph/metric.c             | 151 +++++++++++++++++++++++++++++++++++
 fs/ceph/metric.h             |  90 +++++++++++++++++++++
 fs/ceph/super.c              |  42 ++++++++++
 fs/ceph/super.h              |   2 +
 include/linux/ceph/ceph_fs.h |   1 +
 7 files changed, 351 insertions(+), 3 deletions(-)

-- 
2.27.0.221.ga08a83d.dirty
