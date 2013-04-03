From: Gregory Farnum <greg@inktank.com>
Subject: Re: Trouble getting a new file system to start, for v0.59 and newer
Date: Wed, 3 Apr 2013 10:14:30 -0700
Message-ID: <CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
References: <515C4EC4.5040602@sandia.gov>
	<alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
	<515C6232.4070204@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:49240 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762548Ab3DCROb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 13:14:31 -0400
Received: by mail-qe0-f49.google.com with SMTP id 1so980180qec.8
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 10:14:30 -0700 (PDT)
In-Reply-To: <515C6232.4070204@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Apr 3, 2013 at 10:09 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Sage,
>
> On 04/03/2013 09:58 AM, Sage Weil wrote:
>> Hi Jim,
>>
>> What happens if you change 'osd mon ack timeout =3D 300' (from the
>> default of 30)?  I suspect part of the problem is that the mons are =
just
>> slow enough that the osd's resend the same thing again and it snowba=
lls
>> into more work for the monitor.
>
> Thanks, that helped.  My OSDs aren't reconnecting to the mon any more=
,
> and the new filesystem started up as expected.
>
> Hmmm, it occurs to me that I upgraded my mon hosts to 10 GbE NICs at
> about the same time I started testing v0.59.  Perhaps before the upgr=
ade
> I was running right at the edge of that timeout.  After the NIC upgra=
de
> the PGStat messages come flooding in at startup, and they bunch up
> enough that working through the backlog pushed me over the timeout cl=
iff?
>
> Is there any downside to using a large 'osd mon ack timeout', assumin=
g I
> run more than one mon?  If so, I expect I'll work my way back from
> 'osd mon ack timeout =3D 300' to see how big it needs to be to stay r=
eliable
> for my configuration.

It's a timeout, so the generic downsides to larger timeouts =97 if the
monitor actually has gone away it's going to take the OSDs more time
to connect to somebody else for their updates and reports. This will
probably be most apparent if they're trying to peer and can't make
progress until they get acks from the monitors, but the one they're
connected to has died.


> Sorry for the noise about paxos.  At least it was useful
> to help Joao find that debug log message that was more expensive
> than expected....

It's not noise =97 the reason this timeout is causing problems now is
that the monitor disk commits are taking so long that it looks like
they've failed. Which is bad. :/ So thanks for reporting it!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
