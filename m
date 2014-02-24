From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Fwd: wip-hint
Date: Sun, 23 Feb 2014 21:47:58 -0800
Message-ID: <CABBk=J_=V+sDg_Z8aiTxHA3Rv7ygt=ePipG_YoHTSzYUG8Y2wQ@mail.gmail.com>
References: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net>
	<CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com>
	<CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com>
	<alpine.DEB.2.00.1402231113430.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38182 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaBXFr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 00:47:59 -0500
Received: by mail-vc0-f169.google.com with SMTP id hq11so5406489vcb.0
        for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 21:47:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402231113430.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Feb 23, 2014 at 11:25 AM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
>> (resending to get through the list) My main concern is that the whole
>> notion of hint needs to be abstracted. Instead of having a specific op
>> for allocation hints we should have a generic hint operation that
>> would contain a hint type in it. That hint will then be parsed within
>> the various osd components, and will be used if identified and if
>> needed. Then you'd be able to add various hints without needing to
>> change the  protocol itself.
>> Not sure if the operation itself needs to have a "write" flag set on it,
>> as hints may apply to read operations too (e.g., a hint to prefetch data
>> read). We may want to create two different ops, one for read and one for
>> write. I think that a first step would be to modify the current op and
>> add a "hint type" string at the data portion, and an optional bufferlist
>> for data. The size params need to be generic and not specific (param1,
>> param2, ...).
>
> The nice thing about adding a new rados op is that there isn't any
> disruptive protocol change.  Practically speaking, there isn't a big
> difference between adding one new hint op that is extensible and utilizing
> the (already extensible) rados op infrastructure.  Mostly it just means
> that the allocation hint is nicely named and parameterized for this
> particular purpose without precluding the ability to add other ops later.
> In the read-side hint case I think we should be particularly careful about
> using things like flags to make it trivial to add new behaviors, but I
> don't see a benefit to smoshing those sorts of hints together with
> allocation hints when the alloc stuff is clearly different.
>
> That said, I think it *is* important whether we are nice and general
> about alloc hints in this op.  We can add new fields to the args union as
> needed (up to a point), and can always add an setallochint2 op, but if
> there is something obvious missing..
>

The current op is very specialized and I'm having trouble to see how
it could later be extended. Basically it just passes the following:

__le64 expected_size;
__le64 expected_write_size;
__u8 expected_size_probability;

Thinking about future librados application developers that will also
need to tie the osd into some specialized backend with its own quirks.
For example., an allocation hint might need to specify that writes
need to be interleaved by sectors, with some special ordering, or that
writes will be done directly on the block storage with some specific
alignment. Now, I don't think it would be possible for these users to
add new rados ops, and otoh, the current info that this specific
operation is insufficient. So at the minimum we're missing a 'hint
type' info here. And it's not clear to me that we want to have it as
an int, as that would make it harder for future users to provide their
own implementation without potential collisions.

>> The reasoning behind that is that at one point we may have different
>> backbends plugging into the osd externally. Providing a proper osd
>> backbend sdk might be another step. So we'd want this to be as
>> abstract as possible. These hints could be sent blindly without the
>> osd needing to understand their meaning, leaving it to the backbend to
>> interpret.
>
> Hmm, good point.  The ftct that is is clearly parameterized means the OSD
> is passing through named arguments.  We can always add a pass-thru hint
> for stuff that is outside the well-defined hints.  Even so I suspect most
> of it will/can be captured with flags while still falling into a few
> buckets (alloc hint now, later something like fadvise or generic
> wriete hints).
>

Well, it is possible, but I'm not sure whether flags is the best
choice here. In any case, the current implementation blindly assumes a
specific hint type and there are no actual flags.

> s
>
>>
>> Yehuda
>>
>> On Sunday, February 23, 2014, Sage Weil <sage@inktank.com> wrote:
>> >
>> > Hey Sam, Yehuda,
>> >
>> > Can you take a final look at https://github.com/ceph/ceph/pull/1284?
>> >
>> > Yehuda, you mentioned wanting to make the hint op as general as possible.
>> > This bit is only addressing the allocation piece, and there is room in the
>> > args struct to add additional fields (so far 0 means 'not
>> > specified/undefined'), but I'm not sure if that captures your concerns.
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
