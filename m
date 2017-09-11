From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] Ceph release cadence
Date: Tue, 12 Sep 2017 00:13:48 +0100
Message-ID: <CALe9h7cj8B+gp-2VNh5oqg=ZYMKhb3OZQAYvk4+qkEUony8TSA@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <CALe9h7eFV5sitW+8WAVqjmB+rJvYJw-5C4nizS0HTqffr-_bCA@mail.gmail.com> <CABGPr5ko81W=4kekDNk1_UKcJH4HQ6udWLb0W9V-hnKAo8O=_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:45446 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdIKXOK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Sep 2017 19:14:10 -0400
Received: by mail-wm0-f47.google.com with SMTP id f199so50187670wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Sep 2017 16:14:09 -0700 (PDT)
In-Reply-To: <CABGPr5ko81W=4kekDNk1_UKcJH4HQ6udWLb0W9V-hnKAo8O=_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Hines <bhines@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

(this is a little off topic, but it's a fair point that deserves a
response, so here goes)

On Mon, Sep 11, 2017 at 11:38 PM, Ben Hines <bhines@gmail.com> wrote:
> We have generally been running the latest non LTS 'stable' release since my
> cluster is slightly less mission critical than others, and there were
> important features to us added in both Infernalis and Kraken. But i really
> only care about RGW. If the rgw component could be split out of ceph into a
> plugin and independently updated, it'd be awesome for us.
>
> A minor bugfix to radosgw shouldn't be blocked by issues with RBD, for
> example. I don't care at all.
> Could have packages like:
>
> ceph-core
> ceph-radosgw
> ceph-rbd ...
> ceph-mgr..
>
> Might increase the testing workload, but automation should take care of
> that...

I think you might be underestimating the level of effort and expense
involved in the Ceph automated testing!

> ceph-mgr is also similar. Minor (or even major) updates to the GUI dashboard
> shouldn't be blocked rolling out to users because we're waiting on a new RBD
> feature or critical RGW fix.

In general, the solution to this is not to spawn a load of extra work
by breaking things out into separately versioned entities (and dealing
with resulting inter-version compatibility issues, which is a HUGE
overhead), but rather to ensure that the main Ceph are sufficiently
frequent that it's not too much of an issue.  Folks always have the
option of building their own packages, or downloading pre-release
stuff if they have a super-urgent need for a particular bugfix.

Taking the dashboard as an example -- it's under active development,
as is the ceph-mgr module interface it consumes.  In the current
model, I can add a dashboard feature and its mgr interface dependency
in one step.  There is no stable/static/versioned interface that
isolates these components, and creating one would itself be a
significant amount of work.  The monolithic versioning is not without
its downsides, but they are a conscious cost/benefit decision rather
than an oversight.

The suggestion about RBD and RGW specifically is more reasonable (as
they are librados clients and librados is a versioned interface), but
in practice they do have hooks outside of librados (OSD object
classes, ceph-mgr functionality), so it's far from a no-brainer.
Ultimately up to the folks who develop those bits though.

> radosgw and mgr are really 'clients', after all.

mgr is a required part of RADOS as of luminous (some key functionality
lives there now), it's not really a client in the way that RBD/RGW
are.  It has some client-ish stuff in it, but the mon is also a client
to the mgr for some functionality, and some CLI commands go straight
to the mgr.

John

>
> -Ben
>
> On Mon, Sep 11, 2017 at 3:30 PM, John Spray <jspray@redhat.com> wrote:
>>
>> On Wed, Sep 6, 2017 at 4:23 PM, Sage Weil <sweil@redhat.com> wrote:
>> > Hi everyone,
>> >
>> > Traditionally, we have done a major named "stable" release twice a year,
>> > and every other such release has been an "LTS" release, with fixes
>> > backported for 1-2 years.
>> >
>> > With kraken and luminous we missed our schedule by a lot: instead of
>> > releasing in October and April we released in January and August.
>> >
>> > A few observations:
>> >
>> > - Not a lot of people seem to run the "odd" releases (e.g., infernalis,
>> > kraken).  This limits the value of actually making them.  It also means
>> > that those who *do* run them are running riskier code (fewer users ->
>> > more
>> > bugs).
>> >
>> > - The more recent requirement that upgrading clusters must make a stop
>> > at
>> > each LTS (e.g., hammer -> luminous not supported, must go hammer ->
>> > jewel
>> > -> lumninous) has been hugely helpful on the development side by
>> > reducing
>> > the amount of cross-version compatibility code to maintain and reducing
>> > the number of upgrade combinations to test.
>> >
>> > - When we try to do a time-based "train" release cadence, there always
>> > seems to be some "must-have" thing that delays the release a bit.  This
>> > doesn't happen as much with the odd releases, but it definitely happens
>> > with the LTS releases.  When the next LTS is a year away, it is hard to
>> > suck it up and wait that long.
>> >
>> > A couple of options:
>> >
>> > * Keep even/odd pattern, and continue being flexible with release dates
>> >
>> >   + flexible
>> >   - unpredictable
>> >   - odd releases of dubious value
>> >
>> > * Keep even/odd pattern, but force a 'train' model with a more regular
>> > cadence
>> >
>> >   + predictable schedule
>> >   - some features will miss the target and be delayed a year
>> >
>> > * Drop the odd releases but change nothing else (i.e., 12-month release
>> > cadence)
>> >
>> >   + eliminate the confusing odd releases with dubious value
>> >
>> > * Drop the odd releases, and aim for a ~9 month cadence. This splits the
>> > difference between the current even/odd pattern we've been doing.
>> >
>> >   + eliminate the confusing odd releases with dubious value
>> >   + waiting for the next release isn't quite as bad
>> >   - required upgrades every 9 months instead of ever 12 months
>>
>> This is my preferred option (second choice would be the next one up,
>> i.e. same thing but annually).
>>
>> Our focus should be on delivering solid stuff, but not necessarily
>> bending over backwards to enable people to run old stuff.  Our
>> commitment to releases should be that there are either fixes for that
>> release, or a newer (better) release to upgrade to.  Either way there
>> is a solution on offer (and any user/vendor who wants to independently
>> maintain other stable branches is free to do so).
>>
>> John
>>
>> > * Drop the odd releases, but relax the "must upgrade through every LTS"
>> > to
>> > allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
>> > nautilus).  Shorten release cycle (~6-9 months).
>> >
>> >   + more flexibility for users
>> >   + downstreams have greater choice in adopting an upstrema release
>> >   - more LTS branches to maintain
>> >   - more upgrade paths to consider
>> >
>> > Other options we should consider?  Other thoughts?
>> >
>> > Thanks!
>> > sage
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
