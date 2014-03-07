From: Gregory Farnum <greg@inktank.com>
Subject: Re: contraining crush placement possibilities
Date: Fri, 7 Mar 2014 09:29:26 -0800
Message-ID: <CAPYLRziGh52rUq1yk5U74D55zs+C=Sda9Dm_UbR9M7F5sECSdA@mail.gmail.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
	<CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com>
	<alpine.DEB.2.00.1403070705440.24219@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50388 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaCGRgt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 12:36:49 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so4940687qcx.6
        for <ceph-devel@vger.kernel.org>; Fri, 07 Mar 2014 09:36:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1403070705440.24219@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 7, 2014 at 7:10 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 7 Mar 2014, Dan van der Ster wrote:
>> On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
>> > Sheldon just
>> > pointed out a talk from ATC that discusses the basic problem:
>> >
>> >         https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
>> >
>> > The situation with CRUSH is slightly better, I think, because the number
>> > of peers for a given OSD in a large cluster is bounded (pg_num /
>> > num_osds), but I think we may still be able improve things.
>>
>> I'm surprised they didn't cite Ceph -- aren't copysets ~= placement groups?
>
> I think so (I didn't listen to the whole talk :).  My ears did perk up
> when Carlos (who was part of the original team at UCSC) asked the question
> about the CRUSH paper at the end, though. :)
>
> Anyway, now I'm thinking that this *is* really just all about tuning
> pg_num/pgp_num.  And of course managing failure domains in the CRUSH map
> as best we can to align placement with expected sources of correlated
> failure.  But again, I would appreciate any confirmation from others'
> intuitions or (better yet) a proper mathematical model.  This bit of my
> brain is full of cobwebs, and wasn't particularly strong here to begin
> with.

Well, yes and no. They're constraining data sharing in order to reduce
the probability of any given data loss event, and we can reduce data
sharing by reducing the pgp_num. But the example you cited was "place
all copies in the top third of the selected racks", and that's a
little different because it means they can independently scale the
data sharing *within* that grouping to maintain a good data balance,
which CRUSH would have trouble with.
Unfortunately my intuition around probability and stats isn't much
good, so that's about as far as I can take this effectively. ;)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
