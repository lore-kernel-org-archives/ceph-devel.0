From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 8 Apr 2011 16:10:04 -0700
Message-ID: <BANLkTimUZJhzCcC1AGTC73vi4ELVdy5H3w@mail.gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
	<75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
	<1297893011.25491.124.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
	<4D9F367B.1070904@sandia.gov>
	<Pine.LNX.4.64.1104081343460.15928@cobra.newdream.net>
	<4D9F87F7.6090203@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab1DHXKG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 19:10:06 -0400
Received: by fxm17 with SMTP id 17so2623666fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2011 16:10:05 -0700 (PDT)
In-Reply-To: <4D9F87F7.6090203@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 8, 2011 at 3:11 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Sage Weil wrote:
>
>>
>> I would also be interested in seeing a system level profile (oprofil=
e?) to
>> see where CPU time is being spent. =A0There are likely low hanging f=
ruit in
>> the OSD that would reduce CPU overhead.
>
> This will take me a little while, since I need to learn
> about the tools. =A0But since I need to learn about them
> anyway, that's a good thing.

oprofile is surprisingly easy to get started with. We have a wiki page =
about it:

http://ceph.newdream.net/wiki/Cpu_profiling

>
>>
>> I guess the other thing that would help to confirm this is to just h=
alve
>> the number of OSDs on your machines in a test and see if the problem=
 goes
>> away.
>
> I was going to try this first, exactly because it seems like
> a definitive test.
>
>>
>>> If my analysis above is correct, do you think anything
>>> can be gained by running the heartbeat and heartbeat
>>> dispatcher threads as SCHED_RR threads? =A0Since tick() runs
>>> heartbeat_check(), that would also need to be SCHED_RR,
>>> or the heartbeats could arrive on time, but not checked
>>> until it was too late.

Thanks for the ideas. However, I doubt that making the OSD::tick()
thread SCHED_RR would really work.

The OSD::tick() code is taking locks all over the place. Since a bunch
of other threads besides the tick thread can be holding those locks,
this would soon result in priority inversion. Not to mention,
heartbeat_messenger has its own thread(s) which actually perform the
work of sending the heartbeat messages.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
