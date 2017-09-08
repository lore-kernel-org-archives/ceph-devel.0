From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [Ceph-maintainers] Ceph release cadence
Date: Fri, 8 Sep 2017 09:59:33 -0700
Message-ID: <CAJ4mKGaht37m-Gz=Y3R54+BM6PfHwux4CkjTcrz79LUGVd9MMg@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <20170907113913.wutbtiy2pavl5mfc@suse.com> <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:47081 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdIHQ7g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 12:59:36 -0400
Received: by mail-it0-f44.google.com with SMTP id 6so2998146itl.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 09:59:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

I think I'm the resident train release advocate so I'm sure my
advocating that model will surprise nobody. I'm not sure I'd go all
the way to Lars' multi-release maintenance model (although it's
definitely something I'm interested in), but there are two big reasons
I wish we were on a train with more frequent real releases:

1) It reduces the cost of features missing a release. Right now if
something misses an LTS release, that's it for a year. And nobody
likes releasing an LTS without a bunch of big new features, so each
LTS is later than the one before as we scramble to get features merged
in.

...and then we deal with the fact that we scrambled to get a bunch of
features merged in and they weren't quite baked. (Luminous so far
seems to have gone much better in this regard! Hurray! But I think
that has a lot to do with our feature-release-scramble this year being
mostly peripheral stuff around user interfaces that got tacked on
about the time we'd initially planned the release to occur.)

2) Train releases increase predictability for downstreams, partners,
and users around when releases will happen. Right now, the release
process and schedule is entirely opaque to anybody who's not involved
in every single upstream meeting we have; and it's unpredictable even
to those who are. That makes things difficult, as Xiaoxi said.

There are other peripheral but serious benefits I'd expect to see from
fully-validated train releases as well. It would be *awesome* to have
more frequent known-stable points to do new development against. If
you're an external developer and you want a new feature, you have to
either keep it rebased against a fast-changing master branch, or you
need to settle for writing it against a long-out-of-date LTS and then
forward-porting it for merge. If you're an FS developer writing a very
small new OSD feature and you try to validate it against RADOS, you've
no idea if bugs that pop up and look random are because you really did
something wrong or if there's currently an intermittent issue in RADOS
master. I would have *loved* to be able to maintain CephFS integration
branches for features that didn't touch RADOS and were built on top of
the latest release instead of master, but it was utterly infeasible
because there were too many missing features with the long delays.

On Fri, Sep 8, 2017 at 9:16 AM, Sage Weil <sweil@redhat.com> wrote:
> I'm going to pick on Lars a bit here...
>
> On Thu, 7 Sep 2017, Lars Marowsky-Bree wrote:
>> On 2017-09-06T15:23:34, Sage Weil <sweil@redhat.com> wrote:
>> > Other options we should consider?  Other thoughts?
>>
>> With about 20-odd years in software development, I've become a big
>> believer in schedule-driven releases. If it's feature-based, you never
>> know when they'll get done.
>>
>> If the schedule intervals are too long though, the urge to press too
>> much in (so as not to miss the next merge window) is just too high,
>> meaning the train gets derailed. (Which cascades into the future,
>> because the next time the pressure will be even higher based on the
>> previous experience.) This requires strictness.
>>
>> We've had a few Linux kernel releases that were effectively feature
>> driven and never quite made it. 1.3.x? 1.5.x? My memory is bad, but they
>> were a disaster than eventually led Linus to evolve to the current
>> model.
>>
>> That serves them really well, and I believe it might be worth
>> considering for us.
>
> This model is very appealing.  The problem with it that I see is that the
> upstream kernel community doesn't really do stable releases.  Mainline
> developers are just getting their stuff upstream, and entire separate
> organizations and teams are doing the stable distro kernels.  (There are
> upstream stable kernels too, yes, but they don't get much testing AFAICS
> and I'm not sure who uses them.)
>
> More importantly, upgrade and on-disk format issues are present for almost
> everything that we change in Ceph.  Those things rarely come up for the
> kernel.  Even the local file systems (a small piece of the kernel) have
> comparatively fewer format changes that we do, it seems.
>
> These make the upgrade testing a huge concern and burden for the
> Ceph development community.
>
>> I'd try to move away from the major milestones. Features get integrated
>> into the next schedule-driven release when they deemed ready and stable;
>> when they're not, not a big deal, the next one is coming up "soonish".
>>
>> (This effectively decouples feature development slightly from the
>> release schedule.)
>>
>> We could even go for "a release every 3 months, sharp", merge window for
>> the first month, stabilization the second, release clean up the third,
>> ship.
>>
>> Interoperability hacks for the cluster/server side are maintained for 2
>> years, and then dropped.  Sharp. (Speaking as one of those folks
>> affected, we should not burden the community with this.) Client interop
>> is a different story, a bit.
>>
>> Basically, effectively edging towards continuous integration of features
>> and bugfixes both. Nobody has to wait for anything much, and can
>> schedule reasonably independently.
>
> If I read between the lines a bit here, but this sounds like is:
>
>  - keep the frequently major releases (but possibly shorten the 6mo
>    cadence)
>  - do backports for all of them, not just the even ones
>  - test upgrades between all of them within a 2 year horizon, instead
>    of just the last major one
>
> Is that accurate?
>
> Unfortunately it sounds to me like that would significantly increase the
> maintenance burden (double it even?) and slow development down.  The user
> base will also end up fragmented across a broader range of versions, which
> means we'll see a wider variety of bugs and each release will be less
> stable.
>
> This is full of trade-offs... time we spend backporting or testing
> upgrades is time we don't spend fixing bugs or improving performance or
> adding features.

Not all newly-allocated effort for doing maintenance and testing
necessarily means reducing effort available for new feature
development. Sometimes it just makes that development easier and more
efficient!    I think we'd find that more tested and stable releases
would spread joy and stability throughout our development process and
make life much easier on prospective contributors.
-Greg
