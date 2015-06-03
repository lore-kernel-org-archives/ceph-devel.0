From: Sage Weil <sage@newdream.net>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 3 Jun 2015 09:26:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net>
References: <556F1E19.6080704@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36502 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbFCQ0G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 12:26:06 -0400
In-Reply-To: <556F1E19.6080704@suse.com>
Content-ID: <alpine.DEB.2.00.1506030919531.9814@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Jun 2015, Owen Synge wrote:
> Dear ceph-devel,
> 
> Linux has more than one init systems.
> 
> We in SUSE are in the process of up streaming our spec files, and all
> our releases are systemd based.
> 
> Ceph seems more tested with sysVinit upstream.
> 
> We have 3 basic options for doing this in a packaged upstream system.
> 
> 1) We dont install init scripts/config as part of "make install" and
> "install all the init components via conditionals in the spec file.
> 
> 2) We install all init scripts/config for all flavours of init using
> make install and delete unwanted init systems via conditionals in the
> spec file.
> 
> 3) We add autotools an conditional for each init system, and only
> install with make install enabled init systems scripts/config.
> 
> ------
> 
> We are currently following policy (1)
> 
> I propose we follow policy (3) because (1) makes many distribution
> specific conditionals and requires duplication for each platform for all
> files not installed with "make install".
> 
> -----
> 
> Their are many ways to follow policy 3 so I would propose that when no
> init system is followed, policy (1) and policy (3) should appear identical.
> 
> -----

Let's do it!

> For a transition period between following policy (1) to policy (3)
> 
> phase (1)
> 
> I would expect we would add a conditional to ceph.spec for suse to add
> to the configure step:
> 
> 	--with-init-systemd
> 
> And when other distributions want to move to a full systemd flavour they
> also add a similar conditional.
> 
> phase (2)
> 
> We add a new configure level conditional:
> 
> 	--with-init-sysv
> 
> All sysV init installs are removed from from the spec file and added to
> the "make install" process.
> 
> phase (3)
> 
> Distributions with more than one init system, or init systems that can
> emulate sysVinit, can build packages with either init system and so
> migration can be tested.
> 
> -----
> 
> Does anyone object to this plan?
> Does anyone agree with this plan?
> Does anyone see difficulties with the plan?

I'm hoping that phase 3 can be avoided entirely.  The upgrade/conversion 
path (at least for upstream packages) will be firefly -> infernalis; I'm 
don't think it will be that useful to build infernalis packages that do 
sysvinit for systemd distros.  (Maybe this situation gets more 
complicated if we backport this transition to hammer or downstream does 
the same, but even then the transition will be an upgrade one.)

Ken and I talked a bit about this yesterday and he convinced me that 
catering to multiple init systems w/in a single distro (e.g., by letting 
sysvinit and systemd files coexist) is not worth our time.  This has the 
nice benefit of letting us sunset the 
/var/lib/ceph/*/*/{sysvinit,upstart,systemd} files.

Also, I think we should do 1 and 2 basically at the same time.  I don't 
think it's worth spending any effort trying to make things behave with 
just 1 (and not 2).

Am I talking sense?  I can never tell with this stuff.  :)

sage
