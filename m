From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSDMap checksums
Date: Fri, 22 Aug 2014 10:08:39 -0700
Message-ID: <CAPYLRzhstbj-mVNxzcEi8QJdKh4wRQ9ZP4_ShRAAfz8Q2=HgCQ@mail.gmail.com>
References: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net>
	<CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com>
	<alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net>
	<CAPYLRzioYDorFaruE5nnQgVZrxC9vDckT6Et6KmWhFaYt4fszw@mail.gmail.com>
	<alpine.DEB.2.00.1408192139210.28244@cobra.newdream.net>
	<CAPYLRzgU_vmOZVoGcnmVNch=adkd4WmUZbjYJ1E8JVDDrHj81Q@mail.gmail.com>
	<alpine.DEB.2.00.1408211709300.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:41936 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbaHVRIk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 13:08:40 -0400
Received: by mail-qa0-f41.google.com with SMTP id j7so9991947qaq.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 10:08:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408211709300.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 21, 2014 at 5:38 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 19 Aug 2014, Gregory Farnum wrote:
>> As far as I can tell, checksumming incrementals are good for two
>> things besides detecting bit flips:
>> 1) It's easy to extend to signing the Incremental, which is more sec=
ure
>> 2) It protects against accidental divergence like we saw when we add=
ed
>> the extra heartbeat IP fields
>
> Thinking back, the last time we really screwed this up was
>
>         http://tracker.ceph.com/issues/8738
>
> where the mons were distributing two versions of OSDMaps with differe=
nt
> crush tunable values encoded.  This was because they were encoding th=
e
> full maps locally and didn't all do it the same way (because we weren=
't
> doing the right feature checks there).  That bug is fixed, of course,=
 but
> I'd like to have assurance that we won't hit similar ones--this was f=
ar
> from the first time something like this has happened.

Huh, I actually can't think of any others which impacted mappings like
this one did. That said, I agree...

> Having the OSDs
> generate full maps locally is another tier down but essentially the s=
ame
> problem.  Any manner of bugs could lead to violating the critical
> invariant and we would be none the wiser.

=2E..but if we're really stuck on having bytewise-identical maps across
all OSDs, that means that the OSDs (and whoever else is checking CRCs)
*have* to all understand the entirety of the map well enough to decode
it correctly. This is just another way of saying that they need to be
new enough to understand every encoded feature of the OSDMap =E2=80=94 =
which
is another way of saying that either the monitors must restrict what
features they put in the maps, or the OSDs must all be at least as new
as the monitors.

Now, sure, we could use this as insurance in development testing to
make sure that monitors aren't encoding things their older OSDs won't
understand, but we've in the past had situations where we *wanted* to
let new OSDs see newer data that the old ones just ignored. (Namely,
heartbeat addresses.) Maybe losing that option is a tradeoff worth
making, but we're still going to need to have all the feature bit
controls we presently rely on; this will just tell us (during upgrade
testing, not earlier!) that we missed creating some.



>> Trying to get anything more out of it seems like attacking a problem
>> at very much the wrong layer.
>
> I don't think that this is so much the solution to the problem as
> insurance that if we miss something it won't cause irreparable damage=
=2E
>
> Here's the branch I have so far:
>
>         https://github.com/ceph/ceph/pull/2300
>
> The thing I was missing (and just added) is validation of the full OS=
DMap
> crc in the monitor.  I think it is actually much harder to cope with =
in
> the mon, though.  I think our only real option there is to assert.  N=
ot
> graceful, but it means we did something wrong by generating an increm=
ental
> that not all mons (let alone OSDs) could rebuild.  The OSDs, OTOH, ca=
n
> request pristine maps from the mon if they need them.
>
> We could make a distinction between OSDMaps that vary in encoding but=
 not
> mapping, but I worry that is going to make things overly complex.  We=
 get
> a lot of certainty with a crc over the whole thing.  OTOH, it means t=
hat
> adding simple features like 87722a42c286d4d12190b86b6d06d388e2953ba0
> (remember previous weight when auto-marking osd out) that are only us=
eful
> on the mons (tho to be fair, that data probably is better of being st=
ored
> in the mon store and not the OSDMap, so bad example).
>
> Hrm...

Yeah, being strict about CRCs in the monitor is definitely a good
idea, and we're pretty much stuck asserting there. I'm off to look at
the PR now and will comment more there.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
