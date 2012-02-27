From: Sage Weil <sage@newdream.net>
Subject: Re: ceph v0.42 sync
Date: Mon, 27 Feb 2012 09:13:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202270913230.12283@cobra.newdream.net>
References: <1330250058.3834.46.camel@julia.gcs.org.hu>
 <Pine.LNX.4.64.1202262122370.23717@cobra.newdream.net>
 <1330322472.3834.56.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32924 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab2B0RNk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 12:13:40 -0500
In-Reply-To: <1330322472.3834.56.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Mon, 27 Feb 2012, Laszlo Boszormenyi wrote:
> On Sun, 2012-02-26 at 21:23 -0800, Sage Weil wrote:
> > v0.42.2 for now.. v0.43 should be out either Friday or the following 
> > Monday.
>  OK, will get v0.42.2 from git, as the homepage has only v0.42 for
> download.

Whoops, the tarballs are there now.

Thanks!
sage


> 
> On Sun, 2012-02-26 at 21:29 -0800, Sage Weil wrote:
> > Hmm, actually it looks like /run isn't present on many of my machines 
> > (squeeze, oneiric).  I'm inclined to stick with the /var/run symlink until 
> > the change is more pervasive.  
>  Yes, this change is for the new Debian and Ubuntu releases in
> development. The others have /var/run only.
> 
> > Is this important enough to add an autoconf option to use the new path 
> > instead of the old?
>  Not at all. Even now /run is the real directory, /var/run is now a
> symlink to it. Everyone can still use /var/run for a while.
> 
> Laszlo/GCS
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
