From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: config on mons
Date: Wed, 15 Nov 2017 18:16:37 +0100
Message-ID: <20171115171637.ycmpu4ovmp4laz5l@suse.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal>
 <CALe9h7ciU3ajzPTkh1iCC=+qdEdHbt3n97NCgQDgsML6cLUS2w@mail.gmail.com>
 <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756079AbdKORQz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Nov 2017 12:16:55 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 393FBABD9
        for <ceph-devel@vger.kernel.org>; Wed, 15 Nov 2017 17:16:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1711151318370.28240@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-11-15T13:32:55, Sage Weil <sage@newdream.net> wrote:

I am strongly in favor of moving the config to the MONs, and
depreciating ceph.conf - maybe a ceph-bootstrap.conf for connecting to
the MONs to get it, but that's it.

In a previous life, I helped design a Cluster Information Base to reduce
config drift - a central information store is vastly superior to files
copied around, whether that happens manually or from a config management
system.

It's always outdated *somewhere*, and Ceph already has the concept of
the MONs having maps and a concurrency/consistency algorithm for them
(beloved PAXOS), so it doesn't add any significant complexity.

So for once, I vote for building it in. Don't add etcd/consul. We want
strong consistency here, and can build on stuff already there. If Ceph
would need to invent this from scratch, sure, but thus we can build on
something existing that needs to work anyway or we're screwed.

> > > 1- a default value (compiled in)
> > > 2- a value from the mon
> > > 3- a value from ceph.conf
> > > 4- a value set via command line, 'ceph tell', 'ceph daemon ... config set
> > > ...', etc.

I'm opposed to 3 and 4.

I *can* see the need to override a value on a per-host or on a
per-daemon instance basis (including combinations thereof, e.g., all
OSDs on node X). (Back when, we also expected these to be way more
frequently needed; to this day, I can count on my fingers the times I
needed per-host overrides, I think; really the only use case where this
happens more often are debug flags.)

But if you want any sort of consistency, those modify the settings in
the respective map on the MON, and the daemon *then* gets that one from
the single authoritative source of truth.

> (We also have to allow local overrides to ensure that the mon config can't 
> brick the cluster by setting the internal mon settings, like paxos_*, to 
> some bad value.)

Valid point; but perhaps this could be solved by allowing the MONs to
start up in a "safe" mode, too?

> I think the reporting to mgr to make a distinction needs to be there, 
> though, because (1) to make a transition we want to see the delta between 
> what the daemon has running and what the mon wants, and (2) I don't think 
> we should make things like 'ceph daemon ... config set ...' turn into a 
> request to the monitor to set a config so that the daemon will get a 
> corresponding config update.  These are low-level commands that are 
> important for debugging/fixing issues and I we shouldn't break them.

I'm not perfectly sure about this one, see above. I think having a
single channel through which config updates reach daemons might be worth
it.

> Or the UI can not implement those buttons at all and just show that there 
> is a disaparity and leave it to the user to fix (or not)...?

... or make the disparity go away through a single source of truth.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

