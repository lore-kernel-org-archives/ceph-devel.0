From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: parsing in the ceph osd subsystem
Date: Fri, 30 Nov 2012 01:04:00 +0000
Message-ID: <50B80600.1000304@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com> <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net> <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39897 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2K3BEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 20:04:08 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so5164507wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 17:04:06 -0800 (PST)
In-Reply-To: <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/29/2012 07:01 PM, Andrey Korolyov wrote:
> On Thu, Nov 29, 2012 at 8:34 PM, Sage Weil <sage@inktank.com> wrote:
>> On Thu, 29 Nov 2012, Andrey Korolyov wrote:
>>> $ ceph osd down -
>>> osd.0 is already down
>>> $ ceph osd down ---
>>> osd.0 is already down
>>>
>>> the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
>>> ceph cli should explicitly work only with positive integers plus zero,
>>> refusing all other input.
>>
>> which branch is this?  this parsing is cleaned u pin the latest
>> next/master.
>>
>>
> 
> It was produced by 0.54-tag. I have built
> dd3a24a647d0b0f1153cf1b102ed1f51d51be2f2 today and problem has
> gone(except parsing ``-0'' as 0 and 00000/0000001 as 0 and 1
> correspondingly).

A fix for the signed parameter has been pushed to next. However, after
consideration, when it comes to the '0+\d' parameters, that kind of
input was considered valid; Greg put it best on IRC, and I quote:

<gregaf> joao: not sure we want to prevent "01" from parsing as 1, I
suspect some people with large clusters will find that useful so they
can conflate the name and ID while keeping everything three digits

Hope this makes sense to you.

  -Joao
