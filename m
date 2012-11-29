From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: parsing in the ceph osd subsystem
Date: Thu, 29 Nov 2012 19:49:54 +0000
Message-ID: <50B7BC62.6020408@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com> <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net> <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62840 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2K2TuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 14:50:01 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6470766bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 11:50:00 -0800 (PST)
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

We use strtol() to parse numeric values, and '-0', '00000' or '00001'
are valid numeric values. I suppose we could enforce the argument to be
numeric only, hence getting rid of '-0' and enforce stricter checks on
the parameters to rule out valid numeric values that look funny, which
in the '0*\d' cases it should be fairly simple.

  -Joao
