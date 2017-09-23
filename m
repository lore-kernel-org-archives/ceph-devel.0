From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Ceph release cadence
Date: Sat, 23 Sep 2017 01:58:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709230128240.16664@piezo.novalocal>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal> <alpine.DEB.2.11.1709222211280.16664@piezo.novalocal> <CAJ4mKGbrksDnFvqF2gGb1wzrE4TK4VXALRJi+NoZqje9Ke58qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-114945740-1506131938=:16664"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:55328 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIWB67 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Sep 2017 21:58:59 -0400
In-Reply-To: <CAJ4mKGbrksDnFvqF2gGb1wzrE4TK4VXALRJi+NoZqje9Ke58qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-users <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-114945740-1506131938=:16664
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2017, Gregory Farnum wrote:
> On Fri, Sep 22, 2017 at 3:28 PM, Sage Weil <sage@newdream.net> wrote:
> > Here is a concrete proposal for everyone to summarily shoot down (or
> > heartily endorse, depending on how your friday is going):
> >
> > - 9 month cycle
> > - enforce a predictable release schedule with a freeze date and
> >   a release date.  (The actual .0 release of course depends on no blocker
> >   bugs being open; not sure how zealous 'train' style projects do
> >   this.)
> 
> Train projects basically commit to a feature freeze enough in advance
> of the expected release date that it's feasible, and don't let people
> fake it by rushing in stuff they "finished" the day before. I'm not
> sure if every-9-month LTSes will be more conducive to that or not — if
> we do scheduled releases, we still fundamentally need to be able to
> say "nope, that feature we've been saying for 9 months we hope to have
> out in this LTS won't make it until the next one". And we seem pretty
> bad at that.

I'll be the first to say I'm no small part of the "we" there.  But I'm 
also suggesting that's not a reason not to try to do better.  As I 
said I think this will be easier than in the past because we don't 
have as many headline features we're trying to wedge in.

In any case, is there an alternative way to get to the much-desired 
regular cadence?

> > - no more even/odd pattern; all stable releases are created equal.
> > - support upgrades from up to 3 releases back.
> >
> > This shortens the cycle a bit to relieve the "this feature must go in"
> > stress, without making it so short as to make the release pointless (e.g.,
> > infernalis, kraken).  (I also think that the feature pressure is much
> > lower now than it has been in the past.)
> >
> > This creates more work for the developers because there are more upgrade
> > paths to consider: we no longer have strict "choke points" (like all
> > upgrades must go through luminous).  We could reserve the option to pick
> > specific choke point releases in the future, perhaps taking care to make
> > sure these are the releases that go into downstream distros.  We'll need
> > to be more systematic about the upgrade testing.
> 
> This sounds generally good to me — we did multiple-release upgrades
> for a long time, and stuff is probably more complicated now but I
> don't think it will actually be that big a deal.
> 
> 3 releases back might be a bit much though — that's 27 months! (For
> luminous, the beginning of 2015. Hammer.)

I'm *much* happier with 2 :) so no complaint from me.  I just heard a lot 
of "2 years" and 2 releases (18 months) doesn't quite cover it.  Maybe 
it's best to start with that, though?  It's still an improvement over the 
current ~12 months.

> > Somewhat separately, several people expressed concern about having stable
> > releases to develop against.  This is somewhat orthogonal to what users
> > need.  To that end, we can do a dev checkpoint every 1 or 2 months
> > (preferences?), where we fork a 'next' branch and stabilize all of the
> > tests before moving on.  This is good practice anyway to avoid
> > accumulating low-frequency failures in the test suite that have to be
> > squashed at the end.
> 
> So this sounds like a fine idea to me, but how do we distinguish this
> from the intermediate stable releases?
> 
> By which I mean, are we *really* going to do a stabilization branch
> that will never get seen by users? What kind of testing and bug fixing
> are we going to commit to doing against it, and how do we balance that
> effort with feature work?
> 
> It seems like the same conflict we have now, only since the dev
> checkpoints are less important they'll lose more often. Then we'll end
> up having 9 months of scheduled work to debug for a user release
> instead of 5 months that slipped to 7 or 8...

What if we frame this stabilization period in terms of stability of the 
test suite.  That gives us something concrete to aim for, lets us move on 
when we reach some threshold, and aligns perfectly with the thing that 
makes it hard to safely land new code (noisy test results)...

sage
--8323329-114945740-1506131938=:16664--
