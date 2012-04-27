From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Release/branch naming; input requested
Date: Thu, 26 Apr 2012 17:35:18 -0700
Message-ID: <CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59096 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab2D0AfS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Apr 2012 20:35:18 -0400
Received: by vcqp1 with SMTP id p1so155390vcq.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Apr 2012 17:35:18 -0700 (PDT)
In-Reply-To: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 26, 2012 at 5:09 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> Ceph is maturing as a product. This brings us new challenges. Up to
> this point, we've been putting out a new release every 2-3 weeks, and
> only rarely updating an old release. Update releases like 0.42.2 are
> still a fairly rare occasion, and the the last number has never
> reached 4. However, as we get more and more customers and integrators
> deploying Ceph, we need to provide more stable branches with long term
> maintenance.
>
> I'm expecting, worst case, we'll be looking at something like this:
>
> - "oldstable": right now, 0.41 plus bugfixes only, because that's what
> deployed out there; updates will be rare
> - "stable": minor new features will be brought in, but we'll need to
> do extensive upgrade testing
> - "integration": this will be what our OpenStack Folsom integration
> will be against; including e.g. RBD layering
> - "latest": new release every 2-3 weeks
>
> On top of these, if you ask for the autobuilt repositories, we have:
>
> - "master": autobuilt all the time
> - several branches similar to "master", one per ceph.git branch, that
> sometimes are helpful in isolating a bug, or testing whether a code
> change fixes it
>
> Now, all of these are relative names. For example, once OpenStack
> Folsom is released, we'll need to open a new line of development for
> integrating the next version, branching it off the "latest" at a
> suitable point in time.
>
> The problem with these relative names is, if you run a system against
> "stable", and what "stable" points at changes, suddenly your old &
> reliable system thinks it needs to be upgraded. It's better to look up
> the current value of stable, and point the installation at that for
> updates. Combine this with people tending to be pretty bad at
> remembering specific numbers (I was a Debian Developer and I still
> can't remember which one is Debian 5.0!), and a new practice emerged:
> releases started getting codenames.
>
> Debian originally started giving their releases codenames from the Toy
> Story movies: hamm, slink, potato, woody, sarge, etch, lenny, squeeze,
> wheezy.
>
> Ubuntu uses largely similar infrastructure, but quickly improved on
> that by alphabetizing their codenames: breezy, dapper, edgy, feisty,
> gutsy, hardy, intrepid, jaunty, karmic, lucid, maverick, natty,
> oneiric, precise; you don't need to remember the order to know
> maverick came after lucid. The theme here is adjectives describing an
> alliterative animal, Natty Narwhal etc.
>
> OpenStack has picked the same alphabetical idea, using geographic
> names near where their per-release development summit is hosted:
> austin, bexar, cactus, diablo, essex, folsom.
>
> A company I used to work for picked names of mountains, largely
> choosing based on the magnificence of the upcoming release. By that
> logic, agel would have fewer new features than matterhorn. The same
> theme of mountains could also be used alphabetically. (Back at that
> point, a large part of that reasoning was that we left version
> numbering completely up to sales; engineering just did a look up of
> codename.buildnumber => version string, and we were able to change the
> version number of the product without rebuilding.)
>
> On the flip side, Ubuntu also picked up an idea of versioning releases
> based on the time of the release: YY.MM, as in 11.10, 12.04. This
> works really well for them, because they release only every 6 months,
> and they put a lot of effort into being on schedule, so it's always
> .04 or .10.
>
>
>
> Now, here are my actual questions:
>
> 1. What should the "relative" names of the branches be? "stable" vs
> "latest" etc. I especially don't like "integration", but I do see a
> time where it is not ready for "stable" but still needs to branch off
> of "latest".

reallyold
old
current
next
latest/experimental

>
> 2. Do we want to use cutesy codenames? Alphabetical? Based on what theme?

Yes. Theme should be voted on.

>
> 3. Do we want to use calendar based names? "I'm using Ceph branch
> 2012.04"? (Or spell it 2012-04 to avoid confusing with 0.41 style
> versions?)

No. I don't think it makes much sense. Not at this point at least.

>
> 3. What do we do with version numbers? With a 2-3 week iteration,
> we'll end up with something like 0.41.x, 0.56.x for Folsom integration
> (less than a year from now), and 0.57, 0.58 etc for "latest".

We can keep those, they are completely orthogonal. These are exactly
what they are: dev cycle numbers. I'm not too afraid of big numbers
there, as they become uninteresting once you have the other naming
scheme. They have the nice property of monotonically increasing which
is useful internally.

>
> 4. What will be worthy of 1.0? Is it when the distributed file system
> is solid? Getting out of 0.x would help with separating the different
> branches based on major numbers, but I fear that window has closed
> already.
>

Do we need to have 1.0? I'd say that for the first release that
becomes 'current' with the voted naming scheme we adjust the build
version number to 1.0. After that, every release (not every dev
cycle!) we'd decide whether it's worthy of a major number upgrade or
not. Minor releases can increase the minor version. Fixes on top of
that would go to the 3rd level.
I'm not sure whether it'd work nicely with dev cycle numbering though.

Yehuda
