From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: [ceph-users] Ceph release cadence
Date: Wed, 6 Sep 2017 13:02:46 -0600
Message-ID: <CA+9C14Z=R9NjP8+faZvQEQrAusXO0=N0Rrf-CEU6uMALGpyz1w@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:37732 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdIFTDH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 15:03:07 -0400
Received: by mail-vk0-f46.google.com with SMTP id c82so6135638vkd.4
        for <ceph-devel@vger.kernel.org>; Wed, 06 Sep 2017 12:03:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-users <ceph-users@ceph.com>

I have been working with Ceph for the last several years and I help
support multiple Ceph clusters. I would like to have the team drop the
Even/Odd release schedule, and go to an all production release
schedule.  I would like releases on no more then a 9 month schedule,
with smaller incremental changes and predictable dates.  It would be
nice to be able to upgrade from at least the last 2 releases.

I would also like to see the RC schedule be more like the Linux kernel
or Samba releases, where we have an idea on how many RCs to expect and
how often they would come out, so we can schedule our testing, and
provide more helpful feedback during the RC period.

Eric

On Wed, Sep 6, 2017 at 9:23 AM, Sage Weil <sweil@redhat.com> wrote:
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
