From: Gregory Farnum <greg@inktank.com>
Subject: Re: Firefly maintenance release schedule
Date: Wed, 15 Oct 2014 09:59:03 -0700
Message-ID: <CAPYLRzg5we+dGkAGpbC1Byop+L5aiF40pjfdZpynPKRLokHvwA@mail.gmail.com>
References: <CAM0pNLO7m0=1nkhmqigfMhTeaNYOtW6no9neAWoaX9fKt0uZDg@mail.gmail.com>
	<CAM0pNLN0XoMtWAAqJqgF+VTZmQNu4oFPRUtrDz6FFNWWLo8Sow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:32908 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaJOQ7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 12:59:04 -0400
Received: by mail-qc0-f177.google.com with SMTP id c9so1293718qcz.8
        for <ceph-devel@vger.kernel.org>; Wed, 15 Oct 2014 09:59:03 -0700 (PDT)
In-Reply-To: <CAM0pNLN0XoMtWAAqJqgF+VTZmQNu4oFPRUtrDz6FFNWWLo8Sow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Borodaenko <dborodaenko@mirantis.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 15, 2014 at 9:39 AM, Dmitry Borodaenko
<dborodaenko@mirantis.com> wrote:
> On Tue, Sep 30, 2014 at 6:49 PM, Dmitry Borodaenko
> <dborodaenko@mirantis.com> wrote:
>> Last stable Firefly release (v0.80.5) was tagged on July 29 (over 2
>> months ago). Since then, there were twice as many commits merged into
>> the firefly branch than there existed on the branch before v0.80.5:
>>
>> $ git log --oneline --no-merges v0.80..v0.80.5|wc -l
>> 122
>> $ git log --oneline --no-merges v0.80.5..firefly|wc -l
>> 227
>>
>> Is this a one time aberration in the process or should we expect the
>> gap between maintenance updates for LTS releases of Ceph to keep
>> growing?
>
> I didn't get a response to that nag other than the v0.80.6 release
> announcement on the day after, so I guess it wasn't completely ignored
> :)
>
> Except it turned out v0.80.6 was slightly less than useful as a
> maintenance release:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-October/043701.html
>
> Two weeks later we have v0.80.7 with 3 more commits that hopefully
> make it actually usable. There are many ways to look at that from
> release management perspective.
>
> Good: 2 weeks is much better than 2 months.
> Bad: that's 2.5 months since last *stable* Firefly release.
> Ugly: that's 2 weeks for 3 commits, and now we have 54 more waiting
> for the next release...
>
> Wait what?! Oh right, 54 more commits were merged from firefly-next as
> soon as v0.80.7 was tagged:
> $ git log --oneline --no-merges v0.80.7..firefly|wc -l
> 54
>
> Some of these are fixes for Urgent priority bugs, crashes, and data loss:
> http://tracker.ceph.com/issues/9492
> http://tracker.ceph.com/issues/9039
> http://tracker.ceph.com/issues/9582
> http://tracker.ceph.com/issues/9307
> etc.
>
> So what a Ceph deployer supposed to do with this? Wait another couple
> of weeks (hopefully) for v0.80.8? Take v0.80.7 and hope not to
> encounter any of these bugs? Or label Firefly as "not production ready
> yet" and go back to Dumpling? My personal preference obviously would
> be the first option, but waiting for 2.5 more months is not going to
> fit my schedule :(

Take .80.7. All of the bugs you've cited, you are supremely unlikely
to run into. The "Urgent" tag is a measure of planning priority, not
of impact to users; here it generally means "we found a bug on a
stable branch that we can reproduce". Taking them in order:
http://tracker.ceph.com/issues/9492: only happens if you try and cheat
with your CRUSH rules, and obviously nobody did that until Sage
suggested it as a solution to the problem somebody had 29 days ago
when this was discovered.
http://tracker.ceph.com/issues/9039: The most serious here, but only
happens if you're using RGW, and storing user data in multiple pools,
and issue a COPY command to copy data between different pools.
http://tracker.ceph.com/issues/9582: Only happens if you're using the
op timeout feature of librados with the C bindings OR the op timeout
feature *and* the user-provided buffers in the C++ interface. (To the
best of my knowledge, the people who discovered this are the only ones
using op timeouts.)
http://tracker.ceph.com/issues/9307: I'm actually not sure what's
going on here; looks like some kind of extremely rare race when
authorizing requests? (ie, fixed by a retry)

We messed up the v0.80.6 release in a very specific way (and if you
were deploying a new cluster it wasn't a problem), but you're
extrapolating too much from the presence of patches about what their
impact is and what the system's stability is. These are largely
cleaning up rough edges around user interfaces, and smoothing out
issues in the new functionality that a standard deployment isn't going
to experience. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
