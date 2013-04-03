From: Gregory Farnum <greg@inktank.com>
Subject: Re: Trouble getting a new file system to start, for v0.59 and newer
Date: Wed, 3 Apr 2013 10:49:56 -0700
Message-ID: <CAPYLRzhzQp3xsf_QzzYYJo9RAj_sBV1THs2PJUhk1QRe9XB42w@mail.gmail.com>
References: <515C4EC4.5040602@sandia.gov>
	<alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
	<515C6232.4070204@sandia.gov>
	<CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:65404 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab3DCRt5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 13:49:57 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so787410qcq.39
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 10:49:57 -0700 (PDT)
In-Reply-To: <CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Apr 3, 2013 at 10:14 AM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Wed, Apr 3, 2013 at 10:09 AM, Jim Schutt <jaschut@sandia.gov> wrot=
e:
>> Hi Sage,
>>
>> On 04/03/2013 09:58 AM, Sage Weil wrote:
>>> Hi Jim,
>>>
>>> What happens if you change 'osd mon ack timeout =3D 300' (from the
>>> default of 30)?  I suspect part of the problem is that the mons are=
 just
>>> slow enough that the osd's resend the same thing again and it snowb=
alls
>>> into more work for the monitor.
>>
>> Thanks, that helped.  My OSDs aren't reconnecting to the mon any mor=
e,
>> and the new filesystem started up as expected.
>>
>> Hmmm, it occurs to me that I upgraded my mon hosts to 10 GbE NICs at
>> about the same time I started testing v0.59.  Perhaps before the upg=
rade
>> I was running right at the edge of that timeout.  After the NIC upgr=
ade
>> the PGStat messages come flooding in at startup, and they bunch up
>> enough that working through the backlog pushed me over the timeout c=
liff?
>>
>> Is there any downside to using a large 'osd mon ack timeout', assumi=
ng I
>> run more than one mon?  If so, I expect I'll work my way back from
>> 'osd mon ack timeout =3D 300' to see how big it needs to be to stay =
reliable
>> for my configuration.
>
> It's a timeout, so the generic downsides to larger timeouts =97 if th=
e
> monitor actually has gone away it's going to take the OSDs more time
> to connect to somebody else for their updates and reports. This will
> probably be most apparent if they're trying to peer and can't make
> progress until they get acks from the monitors, but the one they're
> connected to has died.
>
>
>> Sorry for the noise about paxos.  At least it was useful
>> to help Joao find that debug log message that was more expensive
>> than expected....
>
> It's not noise =97 the reason this timeout is causing problems now is
> that the monitor disk commits are taking so long that it looks like
> they've failed. Which is bad. :/ So thanks for reporting it!

Sorry, guess I forgot some of the history since this piece at least is
resolved now. I'm surprised if 30-second timeouts are causing issues
without those overloads you were seeing; have you seen this issue
without your high debugging levels and without the bad PG commits (due
to debugging)?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
