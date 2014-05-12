From: Alex Elder <elder@ieee.org>
Subject: Re: crash in rbd_img_request_create
Date: Sun, 11 May 2014 23:34:56 -0500
Message-ID: <53704F70.3090800@ieee.org>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>	<536EEA5C.70503@ieee.org> <CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44176 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaELEer (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 May 2014 00:34:47 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so6017029iec.8
        for <ceph-devel@vger.kernel.org>; Sun, 11 May 2014 21:34:47 -0700 (PDT)
In-Reply-To: <CALFYKtBXLKhm1HvwK=FGQpJdx_TMaWE_7a0s6Qo7=9vdcsjkkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Hannes Landeholm <hannes@jumpstarter.io>, Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

On 05/11/2014 04:33 AM, Ilya Dryomov wrote:
> On Sun, May 11, 2014 at 7:11 AM, Alex Elder <elder@ieee.org> wrote:
>> On 05/10/2014 05:18 PM, Hannes Landeholm wrote:
>>> Hello,
>>>
>>> I have a development machine that I have been running stress tests on
>>> for a week as I'm trying to reproduce some hard to reproduce failures.
>>> I've mentioned the same machine previously in the thread "rbd unmap
>>> deadlock". I just now noticed that some processes had completely
>>> stalled. I looked in the system log and saw this crash about 9 hours
>>> ago:
>>
>> Are you still running kernel rbd as a client of ceph
>> services running on the same physical machine?
>>
>> I personally believe that scenario may be at risk of
>> deadlock in any case--we haven't taken great care to
>> avoid it in this case.
>>
>> Anyway...
>>
>> I can build v3.14.1 but I don't know what kernel configuration
>> you are using.  Knowing that could be helpful.  I built it using
>> a config I have though, and it's *possible* you crashed on
>> this line, in rbd_segment_name():
>>         ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
>>                         rbd_dev->header.object_prefix, segment);
>> And if so, the only reason I can think that this failed is if
>> rbd_dev->header.object_prefix were null (or an otherwise bad
>> pointer value).  But at this point it's a lot of speculation.
> 
> More precisely, it crashed on
> 
> segment = offset >> rbd_dev->header.obj_order;

After looking more closely at this tonight I can say I concur.

kernel: BUG: unable to handle kernel paging request at ffff87ff3fbcdc58
RAX: ffff87ff3fbcdc00

    2483:       00 00 00 be             movzbl 0x58(%rax),%ecx

Unfortunately that's about all I can say right now.

Since the stack includes rbd_request_fn() we know it's a
request that came from the block layer--which means that
the rbd_img_request_create() call was not being done for
a parent image request.  On the other hand, if you're right
about use-after-free, it could still involve an image request
created through that path through the code (if a parent image
request were freed while it was still in use).

Hannes indicated layered images were involved.

More later...

					-Alex

> while loading obj_order.  rbd_dev is ffff87ff3fbcdc00, which suggests
> a use after free of some sort.  (This is the first rbd_dev deref after
> grabbing it from img_request at the top of rbd_img_request_fill(),
> which got it from request_queue::queuedata in rbd_request_fn().)
> 
> Thanks,
> 
>                 Ilya
> 

