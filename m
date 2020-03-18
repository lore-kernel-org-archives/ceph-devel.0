From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v10 0/6] ceph: add perf metrics support
Date: Thu, 19 Mar 2020 07:28:28 +0800
Message-ID: <c74eee4c-110e-9402-bc18-8aec48cb9abb@redhat.com>
References: <1584540356-5885-1-git-send-email-xiubli@redhat.com>
 <ea5551cf7c7e18b5baf6ec990ae1eddedc62ddce.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35847 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCRX2p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:28:45 -0400
In-Reply-To: <ea5551cf7c7e18b5baf6ec990ae1eddedc62ddce.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/3/19 0:01, Jeff Layton wrote:
> On Wed, 2020-03-18 at 10:05 -0400, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Changed in V10:
>> - rebase to the latest testing branch
>> - merge all the metric related patches into one
>> - [1/6] move metric helpers into a new file metric.c
>> - [2/6] move metric helpers into metric.c
>> - [3/6] merge the read/write patches into a signal patch and move metric helpers to metric.c
>> - [4/6] move metric helpers to metric.c
>> - [5/6] min/max latency support
>> - [6/6] standard deviation support
>>
>> Changed in V9:
>> - add an r_ended field to the mds request struct and use that to calculate the metric
>> - fix some commit comments
>>
>> # cat /sys/kernel/debug/ceph/9a972bfc-68cb-4d52-a610-7cd9a9adbbdd.client52904/metrics
>> item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
>> -----------------------------------------------------------------------------------
>> read          798         32000           4000            196000          560.3
>> write         2394        588000          28000           4812000         36673.9
>> metadata      7           116000          2000            707000          8282.8
>>
>> item          total           miss            hit
>> -------------------------------------------------
>> d_lease       2               0               0
>> caps          2               14              546500
>>
>>
>>
> The code all looks reasonable to me.
>
> Ilya mentioned refactoring the set to add the infrastructure up front
> first. I too think that would be nice, especially since this will
> probably end up being backported to various distros and that would make
> that task simpler.
>
> It might also be nice to merge the add in the min/max/stddev support at
> the same time you add each latency metric too, rather than adding them
> after the fact.
>
>> Xiubo Li (6):
>>    ceph: add dentry lease metric support
>>    ceph: add caps perf metric for each session
>>    ceph: add read/write latency metric support
> Can you fold the min/max/stddev changes for read/write into the above
> patch? I think that would be cleaner, rather than bolting it on after
> the fact.

Sure, will do it.

Thanks.

BRs


>
>>    ceph: add metadata perf metric support
> Same here. That should just leave us with a 4 patch series, I think.
>   
>>    ceph: add min/max latency support for read/write/metadata metrics
>>    ceph: add standard deviation support for read/write/metadata perf
>>      metric
>>
>>   fs/ceph/Makefile                |   2 +-
>>   fs/ceph/acl.c                   |   2 +-
>>   fs/ceph/addr.c                  |  18 ++++
>>   fs/ceph/caps.c                  |  19 ++++
>>   fs/ceph/debugfs.c               | 116 +++++++++++++++++++++++-
>>   fs/ceph/dir.c                   |  17 +++-
>>   fs/ceph/file.c                  |  26 ++++++
>>   fs/ceph/inode.c                 |   4 +-
>>   fs/ceph/mds_client.c            |  21 ++++-
>>   fs/ceph/mds_client.h            |   7 +-
>>   fs/ceph/metric.c                | 193 ++++++++++++++++++++++++++++++++++++++++
>>   fs/ceph/metric.h                |  64 +++++++++++++
>>   fs/ceph/super.h                 |   9 +-
>>   fs/ceph/xattr.c                 |   4 +-
>>   include/linux/ceph/osd_client.h |   1 +
>>   net/ceph/osd_client.c           |   2 +
>>   16 files changed, 487 insertions(+), 18 deletions(-)
>>   create mode 100644 fs/ceph/metric.c
>>   create mode 100644 fs/ceph/metric.h
>>
>
>
> Thanks,
