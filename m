From: Sage Weil <sage@newdream.net>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 3 Jun 2015 13:45:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net> <556F6480.1090901@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37824 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbbFCUpR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 16:45:17 -0400
In-Reply-To: <556F6480.1090901@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Jun 2015, Owen Synge wrote:
> > I'm hoping that phase 3 can be avoided entirely.  The upgrade/conversion 
> > path (at least for upstream packages) will be firefly -> infernalis; I'm 
> > don't think it will be that useful to build infernalis packages that do 
> > sysvinit for systemd distros.  (Maybe this situation gets more 
> > complicated if we backport this transition to hammer or downstream does 
> > the same, but even then the transition will be an upgrade one.)
> 
> Agreed,
> 
> <snip/>
> 
> > Also, I think we should do 1 and 2 basically at the same time.  I don't 
> > think it's worth spending any effort trying to make things behave with 
> > just 1 (and not 2).
> > 
> > Am I talking sense?  I can never tell with this stuff.  :)
> > 
> > sage
> 
> I think you speak sense,
> 
> If I underwstand right you favor the user interface as:
> 
> 	--with-init=systemd
> 	--with-init=sysv
> 	--with-init=upstart
> 	--with-init=bsd
> 
> This is wiser when you start adding up all the possible init systems
> that can exist.

Sounds good to me.  It could (should?) even error out if no init system is 
specified?  Otherwise someone will likely be in for a surprise.

sage
