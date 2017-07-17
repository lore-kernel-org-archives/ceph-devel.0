From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: upgrade procedure to Luminous
Date: Mon, 17 Jul 2017 14:30:16 +0200
Message-ID: <20170717123016.5tdnbmb5cgt77pa2@suse.com>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
 <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
 <20170714142734.5aqzae7x7fmsqmmz@suse.com>
 <alpine.DEB.2.11.1707141507080.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40119 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdGQMaZ (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 17 Jul 2017 08:30:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1707141507080.27271@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Joao Eduardo Luis <joao@suse.de>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On 2017-07-14T15:18:54, Sage Weil <sage@newdream.net> wrote:

> Yes, but how many of those clusters can only upgrade by updating the 
> packages and rebooting?  Our documented procedures have always recommended 
> upgrading the packages, then restarting either mons or osds first and to 
> my recollection nobody has complained.  TBH my first encounter with the 
> "reboot on upgrade" procedure in the Linux world was with Fedora (which I 
> just recently switched to for my desktop)--and FWIW it felt very 
> anachronistic.

Admittedly, it is. This is my main reason for hoping for containers.

My main issue is not that they must be rebooted. In most cases, ceph-mon
can be restarted. My fear is that they *might* be rebooted by a failure
during that time, and it'd have been my expectation that normal
operation does not expose Ceph to such degraded scenarios. Ceph is,
after all, supposedly at least tolerant of one fault at a time.

And I'd obviously have considered upgrades a normal operation, not a
critical phase.

If one considers upgrades an operation that degrades redundancy, sure,
the current behaviour is in line.

> won't see something we haven't.  It also means, in this case, that we can 
> rip out out a ton of legacy code in luminous without having to keep 
> compatibility workarounds in place for another whole LTS cycle (a year!).  

Seriously, welcome to the world of enterprise software and customer
expectations ;-) 1 year! I wish! ;-)

> True, but this is rare, and even so the worst that can happen in this 
> case is the OSDs don't come up until the other mons are upgrade.  If the 
> admin plans to upgrade the mons in succession without lingering with 
> mixed-versions mon the worst-case downtime window is very small--and only 
> kicks in if *more than one* of the mon nodes fails (taking out OSDs in 
> more than one failure domain).

This is an interesting design philosophy in a fault tolerant distributed
system.

> > And customers don't always upgrade all nodes at once in a short period
> > (the benefit of a supposed rolling upgrade cycle), increasing the risk.
> I think they should plan to do this for the mons.  We can make a note 
> stating as much in the upgrade procedure docs?

Yes, we'll have to orchestrate this accordingly.

Upgrade all MONs; restart all MONs (while warning users that this is a
critical time period); start rebooting for the kernel/glibc updates.

> Anyway, does that make sense?  Yes, it means that you can't just reboot in 
> succession if your mons are mixed with OSDs.  But this time adding that 
> restriction let us do the SnapSet and snapdir conversion in a single 
> release, which is a *huge* win and will let us rip out a bunch of ugly OSD 
> code.  We might not have a need for it next time around (and can try to 
> avoid it), but I'm guessing something will come up and it will again be a 
> hard call to make balancing between sloppy/easy upgrades vs simpler 
> code...

The next major transition probably will be from non-containerized L to
fully-containerized N(autilus?). That'll be a fascinating can of worms
anyway. But that would *really* benefit if nodes could be more easily
redeployed and not just restarting daemon processes.

Thanks, at least now we know this is intentional. That was helpful, at
least!


-- 
Architect SDS
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

