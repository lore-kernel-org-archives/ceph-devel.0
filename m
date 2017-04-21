From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 15:39:46 +0200
Message-ID: <20170421133946.4r4qja74uwq6f25l@nora.maurer-it.com>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
 <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
 <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com>
 <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz>
 <20170421091325.t23jra6qdbfjgjeh@nora.maurer-it.com>
 <alpine.DEB.2.11.1704211313220.6575@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox.maurer-it.com ([212.186.127.180]:26800 "EHLO
        proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1039801AbdDUNjw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Apr 2017 09:39:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1704211313220.6575@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Nathan Cutler <ncutler@suse.cz>, Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 21, 2017 at 01:16:23PM +0000, Sage Weil wrote:
> On Fri, 21 Apr 2017, Fabian Grünbichler wrote:
> > On Thu, Apr 20, 2017 at 08:11:38PM +0200, Nathan Cutler wrote:
> > > Hi Willem:
> > > 
> > > It sounds like you are trying to use the sysvinit scripts? These have been
> > > unmaintained (presumably with lots of weeds growing up) since infernalis.
> > > Until now I have been assuming that all init systems other than systemd
> > > (sysvinit, upstart, etc.) are deprecated in Ceph.
> > 
> > Slightly OT, but AFAICT http://tracker.ceph.com/issues/18305 still
> > applies to the official ceph.com Kraken Debian packages, i.e., ceph-base
> > installs and activates the init.d script, which then races against the
> > (udev-activated) ceph-osd systemd units. If anything except systemd is
> > indeed deprecated, I wonder why the Debian packages (still) ship AND
> > activate both systemd units and Sys V init scripts?
> > 
> > (Note that the proposed fix probably does not apply as is anymore,
> > because ceph-disk and the systemd units have been changed in the
> > meantime).
> 
> I think the issue with Debian (generally) is that it "supports" multiple 
> init systems (sysvinit and systemd both), even though systemd is the one 
> installed default.  Which means we ship the sysvinit script and systemd 
> unit files.
> 
> (There may very well be a bug in how we "activate" them, though!)
> 

that's why I reported the original issue - in general you never want to
have both a multi-daemon init script (like the "old" ceph one) and the
replacing split up systemd units active at the same time.

since systemd will generate a unit for every init script for which a
unit of the same name does not already exist, you either need to mask
the auto-generated unit (i.e., symlink it to /dev/null) or write a
replacement unit that has the identical name (so the "ceph" init script
becomes the "ceph.service" unit). if you don't do that and your units
are named differently than your init script, both will be active (this
is not a Debianism, it is how the LSB generator in systemd is supposed
to work to ease the transition from Sys V init to systemd..).

what exacerbates the issue in this case is that the systemd units + udev
actually don't completely replace the old init scripts, because some of
the udev events might have been processed before the system was fully
booted, and osds might not be properly activated on boot as a result.

hence my proposal to add a ceph.service that simply calls "ceph-disk
activate-all", which is AFAICT the only part of the init script that is
not covered by the current systemd units / udev rules.

the whole ceph service startup is pretty messy in general IMHO,
especially for OSDs where (IIRC?) udev rules are calling python scripts
which are starting systemd units which are in turn calling python
scripts with different parameters that end up starting systemd units
which actually start daemons (somewhere in there the mounting happens as
well..).

