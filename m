From: Sage Weil <sage@inktank.com>
Subject: Re: mkcephfs error: cannot remove `/var/lib/ceph/osd/ceph-0'
Date: Fri, 8 Feb 2013 21:42:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302082141220.5874@cobra.newdream.net>
References: <kf4gdf$nn4$1@ger.gmane.org> <alpine.DEB.2.00.1302082055130.5874@cobra.newdream.net> <kf4nfb$6ge$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46898 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3BIFmA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Feb 2013 00:42:00 -0500
In-Reply-To: <kf4nfb$6ge$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

On Sat, 9 Feb 2013, Adam Nielsen wrote:
> > > $ mkcephfs --init-local-daemons mon -d /tmp/foo
> > 
> > Not sure if this is the problem, but: you're creating the mon...
> > 
> > > === mon.0 ===
> > > rm: cannot remove `/var/lib/ceph/osd/ceph-0': Device or resource busy
> > 
> > ..but the path is /var/lib/ceph/osd/...?  Did you override the paths in
> > your ceph.conf?
> 
> Ah yes I did, I see the problem now.  What I wanted to do was to put *all*
> Ceph data onto the same disk (since I am booting the machine off an SD card so
> there is not enough space for much else.)
> 
> What's the best solution in this case?  Should I override the mon path and put
> it as /var/lib/ceph/osd/ceph-0/mon/ for example, or should I mount my disk as
> /var/lib/ceph instead?

Yeah, you could mount it on /var/lib/ceph, or just make a symlink.

sage
