From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: parsing in the ceph osd subsystem
Date: Thu, 29 Nov 2012 22:01:28 +0300
Message-ID: <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
 <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59179 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab2K2TBv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 14:01:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so13390761obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 11:01:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 29, 2012 at 8:34 PM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 29 Nov 2012, Andrey Korolyov wrote:
>> $ ceph osd down -
>> osd.0 is already down
>> $ ceph osd down ---
>> osd.0 is already down
>>
>> the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
>> ceph cli should explicitly work only with positive integers plus zero,
>> refusing all other input.
>
> which branch is this?  this parsing is cleaned u pin the latest
> next/master.
>
>

It was produced by 0.54-tag. I have built
dd3a24a647d0b0f1153cf1b102ed1f51d51be2f2 today and problem has
gone(except parsing ``-0'' as 0 and 00000/0000001 as 0 and 1
correspondingly).

>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
