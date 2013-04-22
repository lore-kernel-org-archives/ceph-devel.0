From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: enforce parent overlap
Date: Mon, 22 Apr 2013 13:33:41 -0700
Message-ID: <51759EA5.9060404@inktank.com>
References: <51737A55.7040602@inktank.com> <517582C1.2020809@inktank.com> <5175909F.6020307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49571 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab3DVUe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 16:34:26 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so3831887pdj.20
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 13:34:25 -0700 (PDT)
In-Reply-To: <5175909F.6020307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/22/2013 12:33 PM, Alex Elder wrote:
> On 04/22/2013 01:34 PM, Josh Durgin wrote:
>> Alex Elder <elder@inktank.com> wrote:
>>
>>> (This patch is available in branch "review/wip-overlap" of
>>> the ceph-client git repository.)
>>>
>>>
>>>
>>> A clone image has a defined overlap point with its parent image.
>>> That is the byte offset beyond which the parent image has no
>>> defined data to back the clone, and anything thereafter can be
>>> viewed as being zero-filled by the clone image.
>
> . . .
>
>>> @@ -2166,6 +2166,16 @@ static int rbd_img_obj_parent_read_full(struct
>>> rbd_obj_request *obj_request)
>>>      length = (u64)1 << rbd_dev->header.obj_order;
>>>
>>>      /*
>>> +     * There is no defined parent data beyond the parent
>>> +     * overlap, so limit what we read at that boundary if
>>> +     * necessary.
>>> +     */
>>> +    if (img_offset + length > rbd_dev->parent_overlap) {
>>> +        rbd_assert(img_offset < rbd_dev->parent_overlap);
>>> +        length = obj_request->offset - obj_request->img_offset;
>>
>> This doesn't look right. I think we want the length to be
>> rbd_dev->parent_overlap - img_offset.
>
> You are correct.  I'm glad you spotted that.
>
> The assertion above it was right, I must have forgotten
> to fix the actual assignment.
>
> Is that the only problem you see?  I can repost, but if
> I agree to fix it as you describe, is that sufficient?

There's the > vs >= later too. If we agree on both, there's
no need to repost.

Josh
