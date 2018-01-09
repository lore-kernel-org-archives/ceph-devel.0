From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: set max_segments to USHRT_MAX
Date: Tue, 9 Jan 2018 17:37:48 +0100
Message-ID: <CAOi1vP_H2wSg4ojY1pMMp7Vm13ktk48dm2iDbcdmYJTVtq3w5g@mail.gmail.com>
References: <1515437475-25789-1-git-send-email-idryomov@gmail.com> <adc1a943-2532-d878-6706-cddb4adebc1f@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:44528 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934243AbeAIQht (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jan 2018 11:37:49 -0500
Received: by mail-io0-f170.google.com with SMTP id k18so19180117ioc.11
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jan 2018 08:37:48 -0800 (PST)
In-Reply-To: <adc1a943-2532-d878-6706-cddb4adebc1f@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 9, 2018 at 12:35 AM, Alex Elder <elder@ieee.org> wrote:
> On 01/08/2018 12:51 PM, Ilya Dryomov wrote:
>> Commit d3834fefcfe5 ("rbd: bump queue_max_segments") bumped
>> max_segments (unsigned short) to max_hw_sectors (unsigned int).
>> max_hw_sectors is set to the number of 512-byte sectors in an object
>> and overflows unsigned short for 32M (largest possible) objects, making
>> the block layer resort to handing us single segment (i.e. single page
>> or even smaller) bios in that case.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d3834fefcfe5 ("rbd: bump queue_max_segments")
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
> Is it OK for max_segments to be bigger than max_hw_sectors?

I think so.  max_hw_sectors (or rather max_sectors -- a soft limit
capped by max_hw_sectors hard limit) limits the size of the request.
max_segments limits the number of segments (~ bvecs) and rbd is fine
with any number.

>
> I didn't investigate but the question occurred to me, since you're
> fixing max_segments regardless of segment size, but not doing that
> to the other limits being set.

Yeah, queue_max_segment_size could be UINT_MAX and we could probably
disable SG merging (BLK_MQ_F_SG_MERGE) which we don't benefit from.
This is a small fix intended for stable though.

Thanks for the review!

                Ilya
