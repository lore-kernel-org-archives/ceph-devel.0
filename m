From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v5 0/10] ceph: add perf metrics support
Date: Wed, 29 Jan 2020 16:23:39 +0800
Message-ID: <9305ac55-3436-6f66-bd7b-7f107323e1dd@redhat.com>
References: <20200128130248.4266-1-xiubli@redhat.com>
 <CAOi1vP-o+mNPprtFKjD-=ifEzHS6uMva2ZDf=LM6PCT4CJuPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbgA2IXx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jan 2020 03:23:53 -0500
In-Reply-To: <CAOi1vP-o+mNPprtFKjD-=ifEzHS6uMva2ZDf=LM6PCT4CJuPoA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/1/28 22:16, Ilya Dryomov wrote:
> On Tue, Jan 28, 2020 at 2:03 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Changed in V2:
>> - add read/write/metadata latency metric support.
>> - add and send client provided metric flags in client metadata
>> - addressed the comments from Ilya and merged the 4/4 patch into 3/4.
>> - addressed all the other comments in v1 series.
>>
>> Changed in V3:
>> - addressed Jeff's comments and let's the callers do the metric
>> counting.
>> - with some small fixes for the read/write latency
>> - tested based on the latest testing branch
>>
>> Changed in V4:
>> - fix the lock issue
>>
>> Changed in V5:
>> - add r_end_stamp for the osdc request
>> - delete reset metric and move it to metric sysfs
>> - move ceph_osdc_{read,write}pages to ceph.ko
>> - use percpu counters instead for read/write/metadata latencies
>>
>> It will send the metrics to the MDSs every second if sending_metrics is enabled, disable as default.
> Hi Xiubo,
>
> What is this series based on?  "[PATCH v5 01/10] ceph: add caps perf
> metric for each session" changes metric_show() in fs/ceph/debugfs.c,
> but there is no such function upstream or in the testing branch.

There actually 11 patches, I missed the first one, will resend it.

Thanks.


> Thanks,
>
>                  Ilya
>
