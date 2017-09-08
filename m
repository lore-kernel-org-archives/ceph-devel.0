From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] Ceph release cadence
Date: Fri, 8 Sep 2017 16:16:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal> <20170907113913.wutbtiy2pavl5mfc@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755900AbdIHQQE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 8 Sep 2017 12:16:04 -0400
In-Reply-To: <20170907113913.wutbtiy2pavl5mfc@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com, ceph-users@ceph.com

I'm going to pick on Lars a bit here...

On Thu, 7 Sep 2017, Lars Marowsky-Bree wrote:
> On 2017-09-06T15:23:34, Sage Weil <sweil@redhat.com> wrote:
> > Other options we should consider?  Other thoughts?
> 
> With about 20-odd years in software development, I've become a big
> believer in schedule-driven releases. If it's feature-based, you never
> know when they'll get done.
> 
> If the schedule intervals are too long though, the urge to press too
> much in (so as not to miss the next merge window) is just too high,
> meaning the train gets derailed. (Which cascades into the future,
> because the next time the pressure will be even higher based on the
> previous experience.) This requires strictness.
> 
> We've had a few Linux kernel releases that were effectively feature
> driven and never quite made it. 1.3.x? 1.5.x? My memory is bad, but they
> were a disaster than eventually led Linus to evolve to the current
> model.
> 
> That serves them really well, and I believe it might be worth
> considering for us.

This model is very appealing.  The problem with it that I see is that the 
upstream kernel community doesn't really do stable releases.  Mainline 
developers are just getting their stuff upstream, and entire separate 
organizations and teams are doing the stable distro kernels.  (There are 
upstream stable kernels too, yes, but they don't get much testing AFAICS 
and I'm not sure who uses them.)

More importantly, upgrade and on-disk format issues are present for almost 
everything that we change in Ceph.  Those things rarely come up for the 
kernel.  Even the local file systems (a small piece of the kernel) have 
comparatively fewer format changes that we do, it seems.

These make the upgrade testing a huge concern and burden for the 
Ceph development community.

> I'd try to move away from the major milestones. Features get integrated
> into the next schedule-driven release when they deemed ready and stable;
> when they're not, not a big deal, the next one is coming up "soonish".
> 
> (This effectively decouples feature development slightly from the
> release schedule.)
> 
> We could even go for "a release every 3 months, sharp", merge window for
> the first month, stabilization the second, release clean up the third,
> ship.
> 
> Interoperability hacks for the cluster/server side are maintained for 2
> years, and then dropped.  Sharp. (Speaking as one of those folks
> affected, we should not burden the community with this.) Client interop
> is a different story, a bit.
> 
> Basically, effectively edging towards continuous integration of features
> and bugfixes both. Nobody has to wait for anything much, and can
> schedule reasonably independently.

If I read between the lines a bit here, but this sounds like is:

 - keep the frequently major releases (but possibly shorten the 6mo 
   cadence)
 - do backports for all of them, not just the even ones
 - test upgrades between all of them within a 2 year horizon, instead 
   of just the last major one

Is that accurate?

Unfortunately it sounds to me like that would significantly increase the 
maintenance burden (double it even?) and slow development down.  The user 
base will also end up fragmented across a broader range of versions, which 
means we'll see a wider variety of bugs and each release will be less 
stable.

This is full of trade-offs... time we spend backporting or testing 
upgrades is time we don't spend fixing bugs or improving performance or 
adding features.

sage
