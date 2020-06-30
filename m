From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v5 0/5] ceph: periodically send perf metrics to ceph
Date: Tue, 30 Jun 2020 21:09:21 +0800
Message-ID: <1f86621e-206d-8e8a-79b6-eb64447c9480@redhat.com>
References: <1593503539-1209-1-git-send-email-xiubli@redhat.com>
 <ace7fb8b8caf88dd9dcdb9341fa6d3f396a42222.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgF3NJt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2020 09:09:49 -0400
In-Reply-To: <ace7fb8b8caf88dd9dcdb9341fa6d3f396a42222.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com, ceph-devel@vger.kernel.org

On 2020/6/30 21:02, Jeff Layton wrote:
> On Tue, 2020-06-30 at 03:52 -0400, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This series is based the previous patches of the metrics in kceph[1]
>> and mds daemons record and forward client side metrics to manager[2][3].
>>
>> This will send the caps/read/write/metadata metrics to any available
>> MDS only once per second, which will be the same as the userland client.
>> We could disable it via the disable_send_metrics module parameter.
>>
>> In mdsc->metric we have two new members:
>> 'metric.mds': save the available and valid MDS rank number to send the
>>                metrics to.
>> 'metric.mds_cnt: how many MDSs support the metric collection feature.
>>
>> Only when '!disable_send_metric && metric.mds_cnt > 0' will the workqueue
>> job keep alive.
>>
>>
>> And will also send the metric flags to MDS, currently it supports the
>> cap, read latency, write latency and metadata latency.
>>
>> Also have pushed this series to github [4].
>>
>> [1] https://patchwork.kernel.org/project/ceph-devel/list/?series=238907 [Merged]
>> [2] https://github.com/ceph/ceph/pull/26004 [Merged]
>> [3] https://github.com/ceph/ceph/pull/35608 [Merged]
>> [4] https://github.com/lxbsz/ceph-client/commits/perf_metric5
>>
>> Changes in V5:
>> - rename enable_send_metrics --> disable_send_metrics
>> - switch back to a single workqueue job.
>> - 'list' --> 'metric_wakeup'
>>
>> Changes in V4:
>> - WARN_ON --> WARN_ON_ONCE
>> - do not send metrics when no mds suppor the metric collection.
>> - add global total_caps in mdsc->metric
>> - add the delayed work for each session and choose one to send the metrics to get rid of the mdsc->mutex lock
>>
>> Changed in V3:
>> - fold "check the METRIC_COLLECT feature before sending metrics" into previous one
>> - use `enable_send_metrics` on/off switch instead
>>
>> Changed in V2:
>> - split the patches into small ones as possible.
>> - check the METRIC_COLLECT feature before sending metrics
>> - switch to WARN_ON and bubble up errnos to the callers
>>
>>
>>
>>
>> Xiubo Li (5):
>>    ceph: add check_session_state helper and make it global
>>    ceph: add global total_caps to count the mdsc's total caps number
>>    ceph: periodically send perf metrics to ceph
>>    ceph: switch to WARN_ON_ONCE and bubble up errnos to the callers
>>    ceph: send client provided metric flags in client metadata
>>
>>   fs/ceph/caps.c               |   2 +
>>   fs/ceph/debugfs.c            |  14 +---
>>   fs/ceph/mds_client.c         | 166 ++++++++++++++++++++++++++++++++++---------
>>   fs/ceph/mds_client.h         |   7 +-
>>   fs/ceph/metric.c             | 158 ++++++++++++++++++++++++++++++++++++++++
>>   fs/ceph/metric.h             |  96 +++++++++++++++++++++++++
>>   fs/ceph/super.c              |  42 +++++++++++
>>   fs/ceph/super.h              |   2 +
>>   include/linux/ceph/ceph_fs.h |   1 +
>>   9 files changed, 442 insertions(+), 46 deletions(-)
>>
> Hi Xiubo,
>
> I'm going to go ahead and merge patches 1,2 and 4 out of this series.
> They look like they should stand just fine on their own, and we can
> focus on the last two stats patches in the series that way.
>
> Let me know if you'd rather I not.

Sure, go ahead.

Thanks Jeff.


>
> Thanks,
