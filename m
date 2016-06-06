From: Samuel Just <sjust@redhat.com>
Subject: Re: unfound object problem
Date: Mon, 6 Jun 2016 15:07:55 -0700
Message-ID: <CAN=+7FVBf+gu03XX3nNzff5LzKVmj8-3NxDRPXO_D13gS0m+LQ@mail.gmail.com>
References: <CAKE=UQJxaZPms82=qZeceSCW2+okmSPVGJ12ML0gd2JPW2uEEQ@mail.gmail.com>
	<CAJ4mKGZ9aWdDpoHeJ5cebxVn=j-vs9t2SnNBJHYYTHh-5b1E-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34056 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbcFFWH4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2016 18:07:56 -0400
Received: by mail-qg0-f53.google.com with SMTP id p34so49716593qgp.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jun 2016 15:07:56 -0700 (PDT)
In-Reply-To: <CAJ4mKGZ9aWdDpoHeJ5cebxVn=j-vs9t2SnNBJHYYTHh-5b1E-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Rui Xie <jerry.xr86@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I don't quite understand...  Can you explain the sequence of events in
more detail?
-Sam

On Mon, Jun 6, 2016 at 2:14 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Sun, May 29, 2016 at 8:58 PM, Rui Xie <jerry.xr86@gmail.com> wrote:
>> Hi
>>
>> I found an unfound object problem in my test environment (hammer).
>> I suspect the reason is the wrong update of up_thru.
>>
>> from osdmap, the up_thru become smaller than before at an epoch.  some
>> old PGTemp messages with smaller epoch are prepared and executed, and
>> change the up_thru to smaller epoch.
>> maybe_went_rw is wrong for that interval.
>>
>> I think prepare_pgtemp should not change up_thru if it is smaller than
>> current, and duplicated PGTemp messages not be sent ?
>>
>> Is this a bug or something wrong for me?
>>
>> Thanks !
>
> I'm not sure if this came out of the same place or not, but Sam was
> just talking last week about an issue with pgtemp updates that is at
> least close to this bug. That one was resolved in the OSDMonitor, if
> those are the up_thru locations you're talking about. :)
> -Greg
