From: Sage Weil <sweil@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Tue, 20 Jun 2017 21:00:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706202045410.32269@piezo.novalocal>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal> <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
 <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal> <CAJ4mKGZCQP0FXh5NWA8429mFmZq3=oqFX=eJMRCPoapmEVJULg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-454802838-1497992447=:32269"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdFTVAs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Jun 2017 17:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFDBCC04F4CE
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 21:00:47 +0000 (UTC)
In-Reply-To: <CAJ4mKGZCQP0FXh5NWA8429mFmZq3=oqFX=eJMRCPoapmEVJULg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-454802838-1497992447=:32269
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2017, Gregory Farnum wrote:
> On Mon, Jun 19, 2017 at 12:26 PM, Sage Weil <sweil@redhat.com> wrote:
> > I wrote up a quick proposal at
> >
> >         http://pad.ceph.com/p/service-map
> >
> > Basic idea:
> >
> >  - generic ServiceMap of service -> daemon -> metadata and status
> >  - managed/persisted by mon
> >  - librados interface to register as service X name Y (e.g., 'rgw.foo')
> >  - librados will send regular beacon to mon to keep entry alive
> >  - various mon commands to dump all or part of the service map
> 
> I am deeply uncomfortable with putting this stuff into the monitor (at
> least, directly). The main purpose we've discussed is to enable
> manager dashboard display of these services, along with stats
> collection, and there's no reason for that to go anywhere other than
> the manager — in fact, routing it through the monitor is inimical to
> timely updates of statistics. Why do you want to do that instead of
> letting it be handled by the manager, which can aggregate and persist
> whatever data it likes in a convenient form — and in ways which are
> mindful of monitor IO abilities?

Well, I argued for doing this in the mon this morning but after 
implementing the first half of it I'm thinking the mgr makes more sense.  
I wanted to use the mon makes sense because 

- it's a persistent structure that should remain consistent across mgr 
restarts etc,
- it looks just like OSDMap and FSMap, just a bit more freeform. those are 
in the mon.
- if it's stored on the mon, there's no particular reason the mgr needs to 
be involved at all

The main complaint was around the 'status' map which may update 
semi-frequently; does that need to be persisted?  (I'd argue that most 
things that change very frequently are probably best covered by 
perfcounters or something other than this globally visible service map.  
But some ad hoc status information is definitely useful, so...)

But... after writing a ServiceMap and ServiceMonitor skeleton it's time to 
implemetn beacon, and I'd prefer to do that using MMonCommand to (1) make 
it usable and testable via the cli (i.e., a well-written bash script could 
be a service if it wanted to), and (2) avoid writing new messages that 
aren't really needed.  And new commands can be trivially implemented on 
the mgr.  In python.

Also, the get_health etc hooks in ServiceMonitor made me think we will 
want some per-service logic around this stuff.  Like, issue a health 
warning if < my target 5 radosgws are running.  Writing per-service 
pluggable logic is also a good fit for ceph-mgr.

Also, the contents of ServiceMap can just be a section of config-key and 
trivially visible to all, without any special code.  This also seems 
convenient (albeit more fragile).

If it goes in mgr, though, I assume we'll have a split between what is 
persisted (in config-key or elsewhere) and what is ephemeral status 
information.  I expect this whole thing is easiest to implement as a 
mgr_module, but I'm not sure we have a way to share unpersisted state 
between modules?  Perhaps a config-key-like interface but local only to 
the mgr instance is all we need there.

sage
--8323329-454802838-1497992447=:32269--
