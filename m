From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] overflow of int ret: use ssize_t for ret
Date: Fri, 23 Nov 2012 16:56:15 +0100
Message-ID: <CAJSP0QWuLCQF2b+HjxG_GCQeYw_TWF_iN1BDXtVGnaa6OuDoEg@mail.gmail.com>
References: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
	<CAJSP0QUhb4J6GQjuJ3OU2cgiFo+t25ERZhibMkYVLW0RuFeamA@mail.gmail.com>
	<CAFEAcA-JSXVHf2Ax=ren8emCMhf2=F0+V+7_crav1OiiZn2aOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:64005 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2KWP4R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 10:56:17 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so4418882lag.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 07:56:16 -0800 (PST)
In-Reply-To: <CAFEAcA-JSXVHf2Ax=ren8emCMhf2=F0+V+7_crav1OiiZn2aOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Priebe <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Stefan Weil <sw@weilnetz.de>

On Fri, Nov 23, 2012 at 3:15 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 November 2012 14:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Thu, Nov 22, 2012 at 10:07 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>> diff --git a/block/rbd.c b/block/rbd.c
>>> index 5a0f79f..0384c6c 100644
>>> --- a/block/rbd.c
>>> +++ b/block/rbd.c
>>> @@ -69,7 +69,7 @@ typedef enum {
>>>  typedef struct RBDAIOCB {
>>>      BlockDriverAIOCB common;
>>>      QEMUBH *bh;
>>> -    int ret;
>>> +    ssize_t ret;
>>>      QEMUIOVector *qiov;
>>>      char *bounce;
>>>      RBDAIOCmd cmd;
>>> @@ -86,7 +86,7 @@ typedef struct RADOSCB {
>>>      int done;
>>>      int64_t size;
>>>      char *buf;
>>> -    int ret;
>>> +    ssize_t ret;
>>>  } RADOSCB;
>>>
>>>  #define RBD_FD_READ 0
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

You are right that size_t is fine for read/write.

But size_t is not fine for discard:
1. librbd takes uint64_t for discard.
2. Completing a discard request uses size.
3. BlockDriverCompletionFunc only passes int ret value <--- broken for
large discard

Stefan Priebe has been discarding large regions (e.g. >4 GB must be
possible on a 32-bit host).

The previous int64_t patch didn't clean up types completely but it
made things better.  AFAICT we need to be able to discard >4 GB so
ssize_t/size_t doesn't cut it on 32-bit hosts.

Stefan
