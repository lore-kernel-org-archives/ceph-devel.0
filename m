From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 0/6] scattered page writeback
Date: Tue, 19 Jan 2016 16:27:13 +0800
Message-ID: <CAAM7YAmd0X0oDs07jsYy6175sYCSg4xNXReHKpR4xr+y9XKwNA@mail.gmail.com>
References: <1452175528-20751-1-git-send-email-zyan@redhat.com>
	<CAOi1vP8n924tgUL1tr_R6LaQzFphjZzWUOauKao9z3iRLdo7Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34757 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbcASI1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 03:27:15 -0500
Received: by mail-lb0-f195.google.com with SMTP id oe3so8904880lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 00:27:14 -0800 (PST)
In-Reply-To: <CAOi1vP8n924tgUL1tr_R6LaQzFphjZzWUOauKao9z3iRLdo7Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 19, 2016 at 8:12 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Jan 7, 2016 at 3:05 PM, Yan, Zheng <zyan@redhat.com> wrote:
>> This series adds scattered page writeback, which uses one OSD request
>> to writeback nonconsecutive dirty page within single strip. Scattered
>> page writeback can increase performance of buffered random writes.
>
> Hi Zheng,
>
> I took a cursory look at this and I really wonder if turning an OSD
> request with its two messages into an ad-hoc dynamic array and using it
> like that is a good idea.  ceph_writepages_start() is one easy to
> follow function - is there no way to pre-calculate the number of dirty
> pages we'd want to stuff into a single request, or at least estimate
> it?  With the geometric expansion you've got in there, you'd go 3 ->
> 6 -> 12 -> 16 for a 16 page strip?  That seems suboptimal...
>
> A couple of implementation details in libceph that stood out:
>
> - Why use ceph_kvmalloc() for r_ops array?  It's at most ~2k, so you'd
>   only be using vmalloc() as a fallback and we don't want to do that.
>
> - Moving reply_op_{len,result} into ceph_osd_req_op to save memory is
>   the right thing, but, continuing on that, why waste r_inline_ops in
>   the >CEPH_OSD_INITIAL_OP case?  That's almost a quarter of r_ops max
>   capacity - ~500 bytes for each "fat" request.
>
> - Why is it that request message's front is enlarged proportionally to
>   max_ops, while reply message's front is always enlarged by
>   (MAX-INITIAL)*foo?  Shouldn't it be proportional to max_ops as well?
>   It definitely deserves a comment, if not.
>
> - The "4" in (sizeof(struct ceph_osd_op) + 4) also deserves a comment.
>   I had to go and look to figure out that it's for reply_op_result.
>
> Thanks,
>
>                 Ilya

Hi,

I have send V2 patches which address most of your comments. For
simplicity, the code still does not use r_inline_ops when num_ops >
CEPH_OSD_INITIAL_OP.  I assume the kernel slab allocator is efficient
in allocating memory < 4k. The difference between allocating 2k memory
and 1.5k memory can be negligible.

Regards
Yan, Zheng

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
