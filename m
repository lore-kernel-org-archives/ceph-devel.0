From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [PATCH] overflow of int ret: use ssize_t for ret
Date: Fri, 23 Nov 2012 15:38:17 +0100
Message-ID: <50AF8A59.6060205@profihost.ag>
References: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag> <CAJSP0QUhb4J6GQjuJ3OU2cgiFo+t25ERZhibMkYVLW0RuFeamA@mail.gmail.com> <CAFEAcA-JSXVHf2Ax=ren8emCMhf2=F0+V+7_crav1OiiZn2aOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48423 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2KWOi1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 09:38:27 -0500
In-Reply-To: <CAFEAcA-JSXVHf2Ax=ren8emCMhf2=F0+V+7_crav1OiiZn2aOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Stefan Weil <sw@weilnetz.de>

Hi,

i'm not a ceph or inktank guy. I can't made any decision on what to 
change. At least right now you'll see failing I/O's in your guest, when 
you discard whole disks.

I could fix this for me with int64 and with ssize_t. So if i should 
resend another patch i need a concrete advise how to patch.

Thanks!

Greets,
Stefan

Am 23.11.2012 15:15, schrieb Peter Maydell:
> On 23 November 2012 14:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Thu, Nov 22, 2012 at 10:07 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>> diff --git a/block/rbd.c b/block/rbd.c
>>> index 5a0f79f..0384c6c 100644
>>> --- a/block/rbd.c
>>> +++ b/block/rbd.c
>>> @@ -69,7 +69,7 @@ typedef enum {
>>>   typedef struct RBDAIOCB {
>>>       BlockDriverAIOCB common;
>>>       QEMUBH *bh;
>>> -    int ret;
>>> +    ssize_t ret;
>>>       QEMUIOVector *qiov;
>>>       char *bounce;
>>>       RBDAIOCmd cmd;
>>> @@ -86,7 +86,7 @@ typedef struct RADOSCB {
>>>       int done;
>>>       int64_t size;
>>>       char *buf;
>>> -    int ret;
>>> +    ssize_t ret;
>>>   } RADOSCB;
>>>
>>>   #define RBD_FD_READ 0
>>
>> I preferred your previous patch:
>>
>> ssize_t on 32-bit hosts has sizeof(ssize_t) == 4.  In
>> qemu_rbd_complete_aio() we may assign acb->ret = rcb->size.  Here the
>> size field is int64_t, so ssize_t ret would truncate the value.
>
> The rcb size field should be a size_t: it is used for calling
> rbd_aio_write and rbd_aio_read so if we've overflowed 32 bits
> then we've already got a problem there.
>
> -- PMM
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
