From: Sage Weil <sweil@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Tue, 20 Jun 2017 21:40:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706202129120.32269@piezo.novalocal>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal> <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
 <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal> <CAJ4mKGZCQP0FXh5NWA8429mFmZq3=oqFX=eJMRCPoapmEVJULg@mail.gmail.com> <alpine.DEB.2.11.1706202045410.32269@piezo.novalocal> <CAJ4mKGY8mGwi=F3mu-q_zB19L6VBDHeGEkyHGtY3oDafV2gQLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1102110120-1497994865=:32269"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdFTVlL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Jun 2017 17:41:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD04A4E4C3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 21:41:05 +0000 (UTC)
In-Reply-To: <CAJ4mKGY8mGwi=F3mu-q_zB19L6VBDHeGEkyHGtY3oDafV2gQLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1102110120-1497994865=:32269
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2017, Gregory Farnum wrote:
> On Tue, Jun 20, 2017 at 2:00 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 20 Jun 2017, Gregory Farnum wrote:
> >> On Mon, Jun 19, 2017 at 12:26 PM, Sage Weil <sweil@redhat.com> wrote:
> >> > I wrote up a quick proposal at
> >> >
> >> >         http://pad.ceph.com/p/service-map
> >> >
> >> > Basic idea:
> >> >
> >> >  - generic ServiceMap of service -> daemon -> metadata and status
> >> >  - managed/persisted by mon
> >> >  - librados interface to register as service X name Y (e.g., 'rgw.foo')
> >> >  - librados will send regular beacon to mon to keep entry alive
> >> >  - various mon commands to dump all or part of the service map
> >>
> >> I am deeply uncomfortable with putting this stuff into the monitor (at
> >> least, directly). The main purpose we've discussed is to enable
> >> manager dashboard display of these services, along with stats
> >> collection, and there's no reason for that to go anywhere other than
> >> the manager — in fact, routing it through the monitor is inimical to
> >> timely updates of statistics. Why do you want to do that instead of
> >> letting it be handled by the manager, which can aggregate and persist
> >> whatever data it likes in a convenient form — and in ways which are
> >> mindful of monitor IO abilities?
> >
> > Well, I argued for doing this in the mon this morning but after
> > implementing the first half of it I'm thinking the mgr makes more sense.
> > I wanted to use the mon makes sense because
> >
> > - it's a persistent structure that should remain consistent across mgr
> > restarts etc,
> > - it looks just like OSDMap and FSMap, just a bit more freeform. those are
> > in the mon.
> > - if it's stored on the mon, there's no particular reason the mgr needs to
> > be involved at all
> 
> I wrote out a whole email and then realized these 3 criteria are
> actually the sticking point let's go through them in order:
> 
> * Why should the service map be a persistent structure? I mean, we
> don't want to see stuff flapping in and out of existence if the
> manager bounces, but that's a very different set of constraints than
> something like "this must consistently move strictly forward in time",
> which is what the monitor provides. I'd be inclined to persist a
> snapshot of the static metadata every 30 seconds (if it's changed)
> just so we don't gratuitously make graphs look weird, but otherwise it
> seems entirely ephemeral to me.
> 
> * I guess at the moment I disagree about that. It looks like them in
> the sense that it stores data, I guess. But the purpose ("displaying
> things to administrators") is entirely different from the OSDMap/FSMap
> ("assign authority over data so we remain consistent").
> 
> * It's always nice to restrict the number of involved components, but
> that can just as easily be flipped around: if it's stored on the
> manager, there's no reason the mon needs to be involved at all! And
> not involving the mon (with its requirement that any change touch
> disk) is a lot bigger of a deal, unless you're worried about adding
> new dependencies on a not-quite-as-HA service. But the service map as
> I understand it is way less critical than stuff like some of the PG
> and quota commands that already depend on the manager.

Making something appear on the dashboard is goal #1, but the minute this 
is in place it's going to be used for all the same sorts of things 
that things like ZK are used for.  Which rbd-mirror daemon is the leader?  
Which rgw is doing gc?  How should I auto-generate my haproxy config for 
rgw?  And so on.  And for pretty everything that isn't just the gui 
display, making this progress forward in time in an orderly way makes 
sense.

But I agree this implementation doesn't need to go in the mon.  It just 
needs to persist the important stuff there.  I think if we segregate 
per-daemon state into things that need to be consistent and persisted 
(e.g., rgw's IP address) and things that don't (which bucket radosgw 
multisite sync is working on, or current progress resharding a bucket) 
we'll be fine.

> > The main complaint was around the 'status' map which may update
> > semi-frequently; does that need to be persisted?  (I'd argue that most
> > things that change very frequently are probably best covered by
> > perfcounters or something other than this globally visible service map.
> > But some ad hoc status information is definitely useful, so...)
> 
> Are perfcounters available through the librados interface? I was sort
> of assuming that punching a similar interface through librados was 50%
> of the point here, although re-reading the thread I'm not sure how I
> got that impression.

Yeah, I totally didn't think of that.  I guess I'd say we probably want 
that additional librados interface to funnel information into the same 
metrics channel that perfcounts go through so that this data ends up in 
whatever TSDB you're using.  Then you can draw all the pretty graphs of 
how many rbd images are currently replicating, how much bandwidth they're 
consuming, what the lag is, and so on.

Unfortunately I also buy the argument that there is other ephemeral stuff 
that doesn't look like a metric (like current rgw sync 
position/bucket/object), so we probably need all three (static and/or 
persistent service daemon metadata, ephemerate daemon metadata, and 
additional perfcounter-like metrics)...

sage
--8323329-1102110120-1497994865=:32269--
