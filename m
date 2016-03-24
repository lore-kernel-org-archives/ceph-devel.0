From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Thu, 24 Mar 2016 22:15:13 +0100
Message-ID: <CAOi1vP8pDCbNej9a_5-THG_Dp70jG+_T6vzT36quBzsu4hiJgQ@mail.gmail.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
	<CACJqLyax9Nntz09qJF2E_jjtoVa2moJxzW5T42bHVFGLop31Ug@mail.gmail.com>
	<6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local>
	<alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33893 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcCXVPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 17:15:15 -0400
Received: by mail-lf0-f43.google.com with SMTP id c62so40998668lfc.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 14:15:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 24, 2016 at 9:55 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 24 Mar 2016, Igor.Podoski@ts.fujitsu.com wrote:
>> Ok, so back to slightly modified Sage idea:
>>
>> Osd before abort() could write its ID (from **argv) to ceph-watchdog
>> named pipe. Only one could be hazard here - case when all osd's want to
>> notify watchdog in the same time. As I wrote before it would not be a
>> 'watchdog' process, but 'process down notify', so question is do we need
>> watchdog like thing for some other stuff (in the feature) or process
>> down notify will be sufficient?
>
> I was imagining something that works the other way around, where the
> watchdog is very simple:
>
>  - osd (or any daemon) opens a unix domain socket and identifies
> itself. e.g. "I am osd.123 at 1.2.3.4:6823"
>  - if the socket is closed, the watchdog notifies the mon that there was a
> failure
>  - the osd (or other daemon) can optionally send a message over the socket
> changing it's identifier (e.g, if the osd rebinds to a new ip).
>
> This way the watchdog doesn't *do* anything except wait for new
> connections or for connections to close.  No polling of PIDs or anything
> like that.
>
> We could figure out where the most common failures are (e.g., op thread
> timeout, or EIO), but I think in practice that will be hard--there are
> lots of places where as assert return values are 0.  An external watchdog,
> OTOH, would capture *all* of those cases, and the bugs.

What do you mean by a place where an assert return value is 0?
assert(!ret)?

My point is all of the asserts can be classified into two groups:
something (an error or a case) that isn't handled and an "oops" kind of
thing.  The actual condition doesn't matter.

Ultimately, this is about shrinking the time it takes for a MON to
notice the "oops".  Do we expect those things to be common and frequent
enough to justify an external daemon, however small and simple, on each
OSD node?

Thanks,

                Ilya
