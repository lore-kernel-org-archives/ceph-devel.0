From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] overflow of int ret: use ssize_t for ret
Date: Fri, 23 Nov 2012 14:15:43 +0000
Message-ID: <CAFEAcA-JSXVHf2Ax=ren8emCMhf2=F0+V+7_crav1OiiZn2aOQ@mail.gmail.com>
References: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
	<CAJSP0QUhb4J6GQjuJ3OU2cgiFo+t25ERZhibMkYVLW0RuFeamA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33539 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2KWOPo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 09:15:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so3401496iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 06:15:44 -0800 (PST)
In-Reply-To: <CAJSP0QUhb4J6GQjuJ3OU2cgiFo+t25ERZhibMkYVLW0RuFeamA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Stefan Weil <sw@weilnetz.de>

On 23 November 2012 14:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Nov 22, 2012 at 10:07 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 5a0f79f..0384c6c 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -69,7 +69,7 @@ typedef enum {
>>  typedef struct RBDAIOCB {
>>      BlockDriverAIOCB common;
>>      QEMUBH *bh;
>> -    int ret;
>> +    ssize_t ret;
>>      QEMUIOVector *qiov;
>>      char *bounce;
>>      RBDAIOCmd cmd;
>> @@ -86,7 +86,7 @@ typedef struct RADOSCB {
>>      int done;
>>      int64_t size;
>>      char *buf;
>> -    int ret;
>> +    ssize_t ret;
>>  } RADOSCB;
>>
>>  #define RBD_FD_READ 0
>
> I preferred your previous patch:
>
> ssize_t on 32-bit hosts has sizeof(ssize_t) == 4.  In
> qemu_rbd_complete_aio() we may assign acb->ret = rcb->size.  Here the
> size field is int64_t, so ssize_t ret would truncate the value.

The rcb size field should be a size_t: it is used for calling
rbd_aio_write and rbd_aio_read so if we've overflowed 32 bits
then we've already got a problem there.

-- PMM
