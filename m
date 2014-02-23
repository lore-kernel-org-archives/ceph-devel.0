From: Sage Weil <sage@inktank.com>
Subject: Re: Fwd: wip-hint
Date: Sun, 23 Feb 2014 11:25:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402231113430.17508@cobra.newdream.net>
References: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net> <CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com> <CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56556 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaBWTZM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 14:25:12 -0500
In-Reply-To: <CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
> (resending to get through the list) My main concern is that the whole
> notion of hint needs to be abstracted. Instead of having a specific op
> for allocation hints we should have a generic hint operation that
> would contain a hint type in it. That hint will then be parsed within
> the various osd components, and will be used if identified and if
> needed. Then you'd be able to add various hints without needing to
> change the  protocol itself.
> Not sure if the operation itself needs to have a "write" flag set on it, 
> as hints may apply to read operations too (e.g., a hint to prefetch data 
> read). We may want to create two different ops, one for read and one for 
> write. I think that a first step would be to modify the current op and 
> add a "hint type" string at the data portion, and an optional bufferlist 
> for data. The size params need to be generic and not specific (param1, 
> param2, ...).

The nice thing about adding a new rados op is that there isn't any 
disruptive protocol change.  Practically speaking, there isn't a big 
difference between adding one new hint op that is extensible and utilizing 
the (already extensible) rados op infrastructure.  Mostly it just means 
that the allocation hint is nicely named and parameterized for this 
particular purpose without precluding the ability to add other ops later. 
In the read-side hint case I think we should be particularly careful about 
using things like flags to make it trivial to add new behaviors, but I 
don't see a benefit to smoshing those sorts of hints together with 
allocation hints when the alloc stuff is clearly different.

That said, I think it *is* important whether we are nice and general 
about alloc hints in this op.  We can add new fields to the args union as 
needed (up to a point), and can always add an setallochint2 op, but if 
there is something obvious missing..

> The reasoning behind that is that at one point we may have different
> backbends plugging into the osd externally. Providing a proper osd
> backbend sdk might be another step. So we'd want this to be as
> abstract as possible. These hints could be sent blindly without the
> osd needing to understand their meaning, leaving it to the backbend to
> interpret.

Hmm, good point.  The ftct that is is clearly parameterized means the OSD 
is passing through named arguments.  We can always add a pass-thru hint 
for stuff that is outside the well-defined hints.  Even so I suspect most 
of it will/can be captured with flags while still falling into a few 
buckets (alloc hint now, later something like fadvise or generic 
wriete hints).

s

> 
> Yehuda
> 
> On Sunday, February 23, 2014, Sage Weil <sage@inktank.com> wrote:
> >
> > Hey Sam, Yehuda,
> >
> > Can you take a final look at https://github.com/ceph/ceph/pull/1284?
> >
> > Yehuda, you mentioned wanting to make the hint op as general as possible.
> > This bit is only addressing the allocation piece, and there is room in the
> > args struct to add additional fields (so far 0 means 'not
> > specified/undefined'), but I'm not sure if that captures your concerns.
> >
> > Thanks!
> > sage
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
