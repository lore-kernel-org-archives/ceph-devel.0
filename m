From: Sage Weil <sage@newdream.net>
Subject: Re: upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 15:18:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707141507080.27271@piezo.novalocal>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de> <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal> <20170714142734.5aqzae7x7fmsqmmz@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40158 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbdGNPS6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 11:18:58 -0400
In-Reply-To: <20170714142734.5aqzae7x7fmsqmmz@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Joao Eduardo Luis <joao@suse.de>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Fri, 14 Jul 2017, Lars Marowsky-Bree wrote:
> On 2017-07-14T14:12:08, Sage Weil <sage@newdream.net> wrote:
> 
> > > Any thoughts on how to mitigate this, or on whether I got this all wrong and
> > > am missing a crucial detail that blows this wall of text away, please let me
> > > know.
> > I don't know; the requirement that mons be upgraded before OSDs doesn't 
> > seem that unreasonable to me.  That might be slightly more painful in a 
> > hyperconverged scenario (osds and mons on the same host), but it should 
> > just require some admin TLC (restart mon daemons instead of 
> > rebooting).
> 
> I think it's quite unreasonable, to be quite honest. Collocated MONs
> with OSDs is very typical for smaller cluster environments.

Yes, but how many of those clusters can only upgrade by updating the 
packages and rebooting?  Our documented procedures have always recommended 
upgrading the packages, then restarting either mons or osds first and to 
my recollection nobody has complained.  TBH my first encounter with the 
"reboot on upgrade" procedure in the Linux world was with Fedora (which I 
just recently switched to for my desktop)--and FWIW it felt very 
anachronistic.

But regardless, the real issue is this is a trade-off between the testing 
and software complexity burden vs user flexibility.  Enforcing an upgrade 
order means we have less to test and have greater confidence the user 
won't see something we haven't.  It also means, in this case, that we can 
rip out out a ton of legacy code in luminous without having to keep 
compatibility workarounds in place for another whole LTS cycle (a year!).  
That reduces code complexity, improves quality, and improves velocity.  
The downside is that the upgrade procedures has to be done in a particular 
order.

Honestly, though, I think it is a good idea for operators to be 
careful with their upgrades anyway.  They should upgrade just mons, let 
cluster stabilize, and make sure things are okay (e.g., no new 
health warnings saying they have to 'ceph osd set sortbitwise') before 
continuing.

Also, although I think it's a good idea to do the mon upgrade relatively 
quickly (one after the other until they are upgraded), the OSD upgrade can 
be stretched out longer.  (We do pretty thorough thrashing tests with 
mixed-version OSD clusters, but go through the mon upgrades pretty 
quickly.)
 
> > Is there something in some distros that *requires* a reboot in order to 
> > upgrade packages?
> 
> Not necessarily.
> 
> *But* once we've upgraded the packages, a failure or reboot might
> trigger this.

True, but this is rare, and even so the worst that can happen in this 
case is the OSDs don't come up until the other mons are upgrade.  If the 
admin plans to upgrade the mons in succession without lingering with 
mixed-versions mon the worst-case downtime window is very small--and only 
kicks in if *more than one* of the mon nodes fails (taking out OSDs in 
more than one failure domain).

> And customers don't always upgrade all nodes at once in a short period
> (the benefit of a supposed rolling upgrade cycle), increasing the risk.

I think they should plan to do this for the mons.  We can make a note 
stating as much in the upgrade procedure docs?
 
> I wish we'd already be fully containerized so indeed the MONs were truly
> independent of everything else going on on the cluster, but ...

Indeed!  Next time around...

> > Also, this only seems like it will affect users that are getting their 
> > ceph packages from the distro itself and not from a ceph.com channel or a 
> > special subscription/product channel (this is how the RHEL stuff works, I 
> > think).
> 
> Even there, upgrading only the MON daemons and not the OSDs is tricky?

I mean you would upgrade all of the packages, but only restart the mon 
daemons.  The deb packages have skipped the auto-restart in the postinst 
(or whatever) stage for years.  I'm pretty sure the rpms do the same?

Anyway, does that make sense?  Yes, it means that you can't just reboot in 
succession if your mons are mixed with OSDs.  But this time adding that 
restriction let us do the SnapSet and snapdir conversion in a single 
release, which is a *huge* win and will let us rip out a bunch of ugly OSD 
code.  We might not have a need for it next time around (and can try to 
avoid it), but I'm guessing something will come up and it will again be a 
hard call to make balancing between sloppy/easy upgrades vs simpler 
code...

sage


