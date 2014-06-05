From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Feature]Proposal for adding a new flag named shared to support
 performance and statistic purpose
Date: Thu, 5 Jun 2014 22:40:15 +0800
Message-ID: <CACJqLyasdSzu_Wg3NRWmm4f=mq=sUfDqovw6y7uBhQXyzzpftw@mail.gmail.com>
References: <CACJqLyZoxqN69NarVLsWZan7aULwbULUAFwmGC5D_jiVTc=uqg@mail.gmail.com>
	<53901B6D.1060707@42on.com>
	<CACJqLyb8dpoV9iRFaqg_F05cbso6AX2RYD7bLPb4Gj9z+=V1tg@mail.gmail.com>
	<7334B4281E425749B85E08CF7EC6F85329CBE143@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:60416 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaFEOkR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 10:40:17 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so1004756wgh.17
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 07:40:16 -0700 (PDT)
In-Reply-To: <7334B4281E425749B85E08CF7EC6F85329CBE143@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Wido den Hollander <wido@42on.com>, Sage Weil <sage@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 5, 2014 at 9:55 PM, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
> You talk about restting the object map on a restart after a crash -- I assume you mean rebuilding, how long will this take?

The object map can be regarded as a state cache. So The object map
after crash will make all object state in objectmap "unknown", this
mean only when client access the object, the state will be updated. So
the object map won't rebuild when image opens, it only affect runtime
condition.

>
>
> -----------------------------------------------------------
> The true mystery of the world is the visible, not the invisible.
>  Oscar Wilde (1854 - 1900)
>
> Allen Samuels
> Chief Software Architect, Emerging Storage Solutions
>
> 951 SanDisk Drive, Milpitas, CA 95035
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Thursday, June 05, 2014 12:43 AM
> To: Wido den Hollander
> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org
> Subject: Re: [Feature]Proposal for adding a new flag named shared to support performance and statistic purpose
>
> On Thu, Jun 5, 2014 at 3:25 PM, Wido den Hollander <wido@42on.com> wrote:
>> On 06/05/2014 09:01 AM, Haomai Wang wrote:
>>>
>>> Hi,
>>> Previously I sent a mail about the difficult of rbd snapshot size
>>> statistic. The main solution is using object map to store the changes.
>>> The problem is we can't handle with multi client concurrent modify.
>>>
>>> Lack of object map(like pointer map in qcow2), it cause many problems
>>> in librbd. Such as clone depth, the deep clone depth will cause
>>> remarkable latency. Usually each clone wrap will increase two times
>>> of latency.
>>>
>>> I consider to make a tradeoff between multi-client support and
>>> single-client support for librbd. In practice, most of the
>>> volumes/images are used by VM, there only exist one client will
>>> access/modify image. We can't only want to make shared image possible
>>> but make most of use cases bad. So we can add a new flag called
>>> "shared" when creating image. If "shared" is false, librbd will
>>> maintain a object map for each image. The object map is considered to
>>> durable, each image_close call will store the map into rados. If the
>>> client  is crashed and failed to dump the object map, the next client
>>> open the image will think the object map as out of date and reset the
>>> objectmap.
>>
>>
>> Why not flush out the object map every X period? Assume a client runs
>> for weeks or months and you would keep that map in memory all the time
>> since the image is never closed.
>
> Yes, as a period job is also a good alter
>
>>
>>
>>>
>>> We can easily find the advantage of this feature:
>>> 1. Avoid clone performance problem
>>> 2. Make snapshot statistic possible
>>> 3. Improve librbd operation performance including read, copy-on-write
>>> operation.
>>>
>>> What do you think above? More feedbacks are appreciate!
>>>
>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Best Regards,

Wheat
