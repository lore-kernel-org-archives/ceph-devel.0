From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Feature]Proposal for adding a new flag named shared to support
 performance and statistic purpose
Date: Thu, 5 Jun 2014 15:43:07 +0800
Message-ID: <CACJqLyb8dpoV9iRFaqg_F05cbso6AX2RYD7bLPb4Gj9z+=V1tg@mail.gmail.com>
References: <CACJqLyZoxqN69NarVLsWZan7aULwbULUAFwmGC5D_jiVTc=uqg@mail.gmail.com>
	<53901B6D.1060707@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61353 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaFEHnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 03:43:08 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so398736wgh.29
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 00:43:07 -0700 (PDT)
In-Reply-To: <53901B6D.1060707@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 5, 2014 at 3:25 PM, Wido den Hollander <wido@42on.com> wrote:
> On 06/05/2014 09:01 AM, Haomai Wang wrote:
>>
>> Hi,
>> Previously I sent a mail about the difficult of rbd snapshot size
>> statistic. The main solution is using object map to store the changes.
>> The problem is we can't handle with multi client concurrent modify.
>>
>> Lack of object map(like pointer map in qcow2), it cause many problems
>> in librbd. Such as clone depth, the deep clone depth will cause
>> remarkable latency. Usually each clone wrap will increase two times of
>> latency.
>>
>> I consider to make a tradeoff between multi-client support and
>> single-client support for librbd. In practice, most of the
>> volumes/images are used by VM, there only exist one client will
>> access/modify image. We can't only want to make shared image possible
>> but make most of use cases bad. So we can add a new flag called
>> "shared" when creating image. If "shared" is false, librbd will
>> maintain a object map for each image. The object map is considered to
>> durable, each image_close call will store the map into rados. If the
>> client  is crashed and failed to dump the object map, the next client
>> open the image will think the object map as out of date and reset the
>> objectmap.
>
>
> Why not flush out the object map every X period? Assume a client runs for
> weeks or months and you would keep that map in memory all the time since the
> image is never closed.

Yes, as a period job is also a good alter

>
>
>>
>> We can easily find the advantage of this feature:
>> 1. Avoid clone performance problem
>> 2. Make snapshot statistic possible
>> 3. Improve librbd operation performance including read, copy-on-write
>> operation.
>>
>> What do you think above? More feedbacks are appreciate!
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on



-- 
Best Regards,

Wheat
