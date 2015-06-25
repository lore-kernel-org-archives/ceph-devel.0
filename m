From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 3/3] rbd: queue_depth map option
Date: Thu, 25 Jun 2015 17:31:23 +0300
Message-ID: <CAOi1vP9xxbe0ig1t==FnsR_uPxG+-s6NQbF8Q6mCb5Z0mvS7bg@mail.gmail.com>
References: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
	<1435223480-35238-4-git-send-email-idryomov@gmail.com>
	<558C0F30.6050907@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35562 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbFYObY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:31:24 -0400
Received: by wgbhy7 with SMTP id hy7so64254963wgb.2
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:31:23 -0700 (PDT)
In-Reply-To: <558C0F30.6050907@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 25, 2015 at 5:24 PM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2015 04:11 AM, Ilya Dryomov wrote:
>>
>> nr_requests (/sys/block/rbd<id>/queue/nr_requests) is pretty much
>> irrelevant in blk-mq case because each driver sets its own max depth
>> that it can handle and that's the number of tags that gets preallocated
>> on setup.  Users can't increase queue depth beyond that value via
>> writing to nr_requests.
>>
>> For rbd we are happy with the default BLKDEV_MAX_RQ (128) for most
>> cases but we want to give users the opportunity to increase it.
>> Introduce a new per-device queue_depth option to do just that:
>>
>>      $ sudo rbd map -o queue_depth=1024 ...
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
>
> I haven't gone to follow through what happens with this
> but I assume a value that's too large will be caught when
> it's attempted to be used or something.
>
> In any case this looks good to me.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Yeah, blk-mq core will cap it at BLK_MQ_MAX_DEPTH (10240).

Thanks for the review,

                Ilya
