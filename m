From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 15:24:53 -0800
Message-ID: <AANLkTi=E5mAM5DHXN2Q5a0C3LcMNYNsJ8YMmzT1K+Od_@mail.gmail.com>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
	<1296511912.23762.205.camel@sale659.sandia.gov>
	<AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
	<1296515768.23762.216.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52503 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab1AaXYy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 18:24:54 -0500
Received: by fxm20 with SMTP id 20so6188689fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 15:24:53 -0800 (PST)
In-Reply-To: <1296515768.23762.216.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 31, 2011 at 3:16 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> On Mon, 2011-01-31 at 15:57 -0700, Colin McCabe wrote:
>>
>> > If Ceph scrub works this way, then another
>> > thing I really want to do is learn to tell my disks to not try
>> > so hard to recover a sector, as I know I have at least one other
>> > copy I can use to repair it, and because that minimizes the time
>> > that osd is stalled.
>>
>> Do you set these kind of timeouts through smartctl or hdparm?
>
>
> I've never done this on any drives that we use, so I
> don't know and would really like to learn more.
>
> But here's an example of more info of the sort that
> got me thinking about it:
> =A0http://en.wikipedia.org/wiki/Time-Limited_Error_Recovery

Yeah, I'm vaguely familiar with this sort of thing from my time in the
storage industry. I'm pretty sure it has to be configured in the hard
drive firmware rather than at a higher layer of the stack.

Of course the drives that, say, NetApp sells you will come configured
this way. But how do you get this behavior from white box stuff?
That's the question.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
