From: Sage Weil <sage@newdream.net>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 22:21:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711142208490.28240@piezo.novalocal>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:49958 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbdKNWVI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 17:21:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by tragedy.dreamhost.com (Postfix) with ESMTPS id 6C5F315F89D
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 14:21:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've updated the pad at

	http://pad.ceph.com/p/config

After thinking about this a bit more, I think we may need to abandon the 
idea of a pure ceph.conf-less world.  Lots of people already have tooling 
around ceph.conf, getting rid of it will be an awkward process (even for a 
one-time upgrade), and I'm not sure we can eliminate it entirely anyway 
since many options affect the bootstrapping phase, authentication, and so 
on.

Instead, I'm currently partial to giving processes a more nuanced view of 
their config based on where the value comes from.  A single option may 
include

1- a default value (compiled in)
2- a value from the mon
3- a value from ceph.conf
4- a value set via command line, 'ceph tell', 'ceph daemon ... config set 
...', etc.

We would always use the highest-priority value on that list.  This means 
that ceph.conf can override the mon, just like a command-line argument 
overrides ceph.conf.

On the flip side of this, all of these values are also reported to the mgr 
and tracked along with the other daemon state.  So regardless of where 
config values come from, it is all still visible via the CLI, GUI, or 
whatever else.

Further, we can then make the GUI (or CLI or whatever) act on that 
information to, say,

- assimilate ceph.conf values into the mon so that ceph.cong can be 
removed/abbreviated (i.e., the upgrade/transition path to centralized 
config)
- see override values set via cli (i.e., in gui)
- clear override values (i.e., ceph tell <daemon> config rm <name>)
- surface a HEALTH_WARN if a CLI or 'config set' override has been 
set on one or more daemons (so the operator knows the running config is 
not persistent).
- surface a HEALTH_WARN if a mon option is overriden by a daemon's local 
ceph.conf 
file.

Notably, the user can also do nothing and the cluster can continue to 
operate as it always has.  The mgr will still have the new visibility into 
running daemon options, so the GUI experience will still be 
consistent--they just won't be able to change configs centrally (or 
rather, those settings won't have any effect if old ceph.conf's override 
them).

I think Kyle's revision history suggestion is a great one.  I don't have 
any bright ideas about how this should be managed on the mon side yet, but 
I agree that it is an important function and should be baked in from day 
1.

Thoughts?
sage
