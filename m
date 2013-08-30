From: Sage Weil <sage@inktank.com>
Subject: Re: Questions about mds locks
Date: Thu, 29 Aug 2013 20:58:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308292050140.12241@cobra.newdream.net>
References: <CAMm-wcJ13NDMXfNymURbgaHvGF42Py2fKJHSSAwBLs=Qif3_8w@mail.gmail.com> <CAPYLRzgZ53bp4UfZ5n65nnuJmEiQwDpT8-jmLAEo8exL7kXp+g@mail.gmail.com> <CAMm-wcJRcByTO0RzRnvYJJ2Hv8QM+cRfAG5Ue6sCa2gnVpNH7g@mail.gmail.com>
 <CAPYLRzgimoABj+NWpMF9HUW31wu9zDVhCco24O4wnP8LRV0EaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51273 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab3H3D6S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 23:58:18 -0400
In-Reply-To: <CAPYLRzgimoABj+NWpMF9HUW31wu9zDVhCco24O4wnP8LRV0EaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dong Yuan <yuandong1222@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

> > I noticed that states is organized into groups even in one state
> > machine.Using simplelock state machine as an example which I am most
> > familiar with. In simplelock state machine, There are four groups
> > (LOCK_REMOTEXLOCK is not used anymore, right?) and three stable
> > states: LOCK_SYNC, LOCK_LOCK and LOCK_EXCL. In my opinion, the
> > semantic of these three stable states is:
> >
> > LOCK_SYNC: normal state, everyone can read or readlock while no one
> > want wrlock and xlock.
> Right.
> 
> > LOCK_LOCK: shared lock? I can't get it.
> Hrm. I'm not sure ? Sage?

Yes, it's confusing.  These are better thought of as state machines 
controlling whether you are allowed to lock--not locks themselves.

SYNC - any replica can rdlock, nobody can wrlock (shared write) or xlock (exlusive)
LOCK - nobody can rdlock; only primary mds can wrlock or xlock
XLOCK - somebody is holding an xlock
MIX - any replica can wrlock; nobody can rdlock or xlock

XLOCK is treated as unstable because as soon as the xlock is released we 
transition away from that state to XLOCKDONE and then to some other state, 
depending on who is waiting for what locks and various other factors.  The 
xlock states are quite confusing; I would start with the others.

The other thing to keep in mind is that these states *also* control what 
capability bits (on inodes) or leases (on dentries) we are allowed to 
issue to clients.  Renaming a bunch of these types (e.g., 
s/LOCK_/ACCESSMODE_/) would probably go a long way toward making this more 
approachable.

sage
