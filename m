From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: [ceph-users] Ceph release cadence
Date: Tue, 12 Sep 2017 09:59:23 +1000
Message-ID: <CA+z5Dsy_pr6iMX1UBdAmWnqhdLu4y8N8gL5XWfTUqFoZVJOXXw@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:38910 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdIKX7p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Sep 2017 19:59:45 -0400
Received: by mail-qt0-f171.google.com with SMTP id q8so22478853qtb.5
        for <ceph-devel@vger.kernel.org>; Mon, 11 Sep 2017 16:59:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, Ceph-User <ceph-users@ceph.com>

(Apologies if this is a double post - I think my phone turned it into
HTML and so bounced from ceph-devel)...

We currently use both upstream and distro (RHCS) versions on different
clusters. Downstream releases are still free to apply their own
models.

I like the idea of a predictable (and more regular) train model (and
I'd point out that trains can run a little late - there just needs to
be some process around that.

If you were to keep the even/odd release model then I'd suggest
considering a 4 monthly train cadence on these. If the even/odd model
is dropped (which would be my preference) then I like the sound of ~9
monthly releases splitting the difference between today's model.
OpenStack does 6 monthly cycles, and I think the data shows this is
too frequent for most operators (of course OpenStack is much more
complex and multifaceted as well) - many deployments are well behind
the stable deprecation schedule and it's the norm to hear people
talking about doing "skip upgrades".

On 7 September 2017 at 01:23, Sage Weil <sweil@redhat.com> wrote:
> Hi everyone,
>
> Traditionally, we have done a major named "stable" release twice a year,
> and every other such release has been an "LTS" release, with fixes
> backported for 1-2 years.
>
> With kraken and luminous we missed our schedule by a lot: instead of
> releasing in October and April we released in January and August.
>
> A few observations:
>
> - Not a lot of people seem to run the "odd" releases (e.g., infernalis,
> kraken).  This limits the value of actually making them.  It also means
> that those who *do* run them are running riskier code (fewer users -> more
> bugs).
>
> - The more recent requirement that upgrading clusters must make a stop at
> each LTS (e.g., hammer -> luminous not supported, must go hammer -> jewel
> -> lumninous) has been hugely helpful on the development side by reducing
> the amount of cross-version compatibility code to maintain and reducing
> the number of upgrade combinations to test.
>
> - When we try to do a time-based "train" release cadence, there always
> seems to be some "must-have" thing that delays the release a bit.  This
> doesn't happen as much with the odd releases, but it definitely happens
> with the LTS releases.  When the next LTS is a year away, it is hard to
> suck it up and wait that long.
>
> A couple of options:
>
> * Keep even/odd pattern, and continue being flexible with release dates
>
>   + flexible
>   - unpredictable
>   - odd releases of dubious value
>
> * Keep even/odd pattern, but force a 'train' model with a more regular
> cadence
>
>   + predictable schedule
>   - some features will miss the target and be delayed a year
>
> * Drop the odd releases but change nothing else (i.e., 12-month release
> cadence)
>
>   + eliminate the confusing odd releases with dubious value
>
> * Drop the odd releases, and aim for a ~9 month cadence. This splits the
> difference between the current even/odd pattern we've been doing.
>
>   + eliminate the confusing odd releases with dubious value
>   + waiting for the next release isn't quite as bad
>   - required upgrades every 9 months instead of ever 12 months
>
> * Drop the odd releases, but relax the "must upgrade through every LTS" to
> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
> nautilus).  Shorten release cycle (~6-9 months).
>
>   + more flexibility for users
>   + downstreams have greater choice in adopting an upstrema release
>   - more LTS branches to maintain
>   - more upgrade paths to consider
>
> Other options we should consider?  Other thoughts?
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Cheers,
~Blairo
