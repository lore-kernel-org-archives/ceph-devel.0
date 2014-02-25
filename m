From: Sage Weil <sage@inktank.com>
Subject: Re: Fwd: wip-hint
Date: Tue, 25 Feb 2014 09:38:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402240521510.17508@cobra.newdream.net>
References: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net> <CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com> <CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com> <alpine.DEB.2.00.1402231113430.17508@cobra.newdream.net>
 <CABBk=J_=V+sDg_Z8aiTxHA3Rv7ygt=ePipG_YoHTSzYUG8Y2wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36186 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYRir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 12:38:47 -0500
In-Reply-To: <CABBk=J_=V+sDg_Z8aiTxHA3Rv7ygt=ePipG_YoHTSzYUG8Y2wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
> On Sun, Feb 23, 2014 at 11:25 AM, Sage Weil <sage@inktank.com> wrote:
> > On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
> >> (resending to get through the list) My main concern is that the whole
> >> notion of hint needs to be abstracted. Instead of having a specific op
> >> for allocation hints we should have a generic hint operation that
> >> would contain a hint type in it. That hint will then be parsed within
> >> the various osd components, and will be used if identified and if
> >> needed. Then you'd be able to add various hints without needing to
> >> change the  protocol itself.
> >> Not sure if the operation itself needs to have a "write" flag set on it,
> >> as hints may apply to read operations too (e.g., a hint to prefetch data
> >> read). We may want to create two different ops, one for read and one for
> >> write. I think that a first step would be to modify the current op and
> >> add a "hint type" string at the data portion, and an optional bufferlist
> >> for data. The size params need to be generic and not specific (param1,
> >> param2, ...).
> >
> > The nice thing about adding a new rados op is that there isn't any
> > disruptive protocol change.  Practically speaking, there isn't a big
> > difference between adding one new hint op that is extensible and utilizing
> > the (already extensible) rados op infrastructure.  Mostly it just means
> > that the allocation hint is nicely named and parameterized for this
> > particular purpose without precluding the ability to add other ops later.
> > In the read-side hint case I think we should be particularly careful about
> > using things like flags to make it trivial to add new behaviors, but I
> > don't see a benefit to smoshing those sorts of hints together with
> > allocation hints when the alloc stuff is clearly different.
> >
> > That said, I think it *is* important whether we are nice and general
> > about alloc hints in this op.  We can add new fields to the args union as
> > needed (up to a point), and can always add an setallochint2 op, but if
> > there is something obvious missing..
> >
> 
> The current op is very specialized and I'm having trouble to see how
> it could later be extended. Basically it just passes the following:

This is really:

opcode/type = ALLOC_HINT
> __le64 expected_size;
> __le64 expected_write_size;
> __u8 expected_size_probability;
 
> Thinking about future librados application developers that will also
> need to tie the osd into some specialized backend with its own quirks.
> For example., an allocation hint might need to specify that writes
> need to be interleaved by sectors, with some special ordering, or that
> writes will be done directly on the block storage with some specific
> alignment.

We can add fields to this, for example by adding

	__le32 alignment;

to the args for this particular opcode.

> Now, I don't think it would be possible for these users to add new rados 
> ops, and otoh, the current info that this specific operation is 
> insufficient. So at the minimum we're missing a 'hint type' info here.

That's the rados opcode.  And we can add rados opcodes whenever we want, 
specifically when we add support on the backend.  Any ops marked with 
FAILOK will be ignored if they are not understood.

Basically, at *some* level, we need to have a switch where there is a 
'type' and we define the various parameters for that particular type of 
hint.  We can either

1- define a catch-all 'hint' op at the rados level, and then start 
defining specific types and their params, starting with something for 
allocation hints.

2- use the existing framework for rados ops and use that as the 'type'.

This patch takes option 2 because all the generic work is already done at 
the rados level and we can easily add new ops and ignore ones that we 
don't understand at the server side.

I agree that having a full pass-through would also be useful, and we can 
add that later (probably around the time when we have pluggable backends 
that might understand it).  I'm not sure what we would gain from doing the 
switch on hint type underneath a catch-all rados op.  If nothing else, we 
already would have to have 2 since some hints are 'write' hints and need 
to be treated a bit differently by the OSD.

sage
