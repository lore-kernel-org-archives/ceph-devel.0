From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: mon memory leak
Date: Wed, 13 Mar 2013 14:16:02 +0000
Message-ID: <51408A22.7070906@inktank.com>
References: <51405874.6030506@profihost.ag> <CAOLwVUk9bT-pR3_6QmG+HywZMs4sEKZGGX=uiFqvFyFTM1Q=aA@mail.gmail.com> <CACkq2mr1juPpqn85jsxeNr_RdgX1nyC6KDLehuNs5rSveWMALw@mail.gmail.com> <514085F5.6010509@inktank.com> <514087D3.20200@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:44608 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3CMORA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 10:17:00 -0400
Received: by mail-bk0-f52.google.com with SMTP id jk13so470154bkc.25
        for <ceph-devel@vger.kernel.org>; Wed, 13 Mar 2013 07:16:59 -0700 (PDT)
In-Reply-To: <514087D3.20200@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Travis Rhoden <trhoden@gmail.com>, =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/13/2013 02:06 PM, Stefan Priebe - Profihost AG wrote:
> Hi Joao,
> Am 13.03.2013 14:58, schrieb Joao Eduardo Luis:
>
>> I'm expecting to be able to find the time Real Soon Now to put a doc
>> together with ways, for anyone willing, to provide us further insight on
>> what's happening.  The monitor is supposed to be able to dump a heap
>> profile (using gperftools) on-the-fly, but I recall having some issues
>> with that not so long ago, so that's probably one thing to look into asap.
>
> Thanks - that would be great i'm willing ;-)

Cool, good to know.  I'll post something to the ml as soon as I have 
something worth sharing.  Most likely next week.  It's unlikely I'll get 
around to do it still this week.

>
>> In any case, Stefan, do you by chance still have that monitor going?
> Sadly not i needed the memory ;-)
>
>> Furthermore, assuming you are using a
>> version prior to v0.58,
> Yes current Bobtail 0.56.3
>
>> any chance you can run a 'du -chs
>> /var/lib/ceph/mon/ceph-foo',
> No idea what you expect to see but all mon servers consume 180MB of disk
> space.

eh, just trying to figure out if said memory consumption is due to some 
large map being kept in memory.  Given we always write to the store when 
maps are updated, and only after that do we load them to memory, I was 
hoping to see some incredibly high disk consumption (while the monitor 
was running) in order to assert whether the mem consumption would be 
tied to some specific map.  But given that the store is periodically 
trimmed this was a long shot anyway. Still worth a try though ;)

   -Joao

>
> [: ~]# du -chs /ceph/mon
> 180M    /ceph/mon
> 180M    total
>
> Greets,
> Stefan
>

