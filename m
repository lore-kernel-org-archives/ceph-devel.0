From: Sage Weil <sage@newdream.net>
Subject: Re: ceph v0.42 sync
Date: Sun, 26 Feb 2012 21:23:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202262122370.23717@cobra.newdream.net>
References: <1330250058.3834.46.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41683 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2B0FXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 00:23:44 -0500
In-Reply-To: <1330250058.3834.46.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Sun, 26 Feb 2012, Laszlo Boszormenyi wrote:
> Hi,
> 
> I send some patches to make the packaging difference smaller between us.
> The first, create_run_dir.patch to make /run/ceph created on every
> start. Yes, it's /run as /var/run is now a symbolic link to the former.
> The next is an update to control to reflect the new Standards-Version
> and to make hdparm optional to sdparm, which is for sATA discs.
> Then an update to rules. Adding build-arch and build-indep targets.

I've applied these to master, thanks!  They'll be in v0.43.

> I ask for a clarification of version numbers. Homepage shows v0.42 as
> the latest downloadable as git contains v0.42.1 and v0.42.2 tags. Are
> they official and/or should I wait for v0.43 which is due to yesterday
> as I know?

v0.42.2 for now.. v0.43 should be out either Friday or the following 
Monday.

sage
