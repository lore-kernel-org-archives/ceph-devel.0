From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: ceph v0.42 sync
Date: Mon, 27 Feb 2012 07:01:12 +0100
Message-ID: <1330322472.3834.56.camel@julia.gcs.org.hu>
References: <1330250058.3834.46.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1202262122370.23717@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:42995 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2B0GBQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 01:01:16 -0500
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.barcikacomp.hu (Postfix) with ESMTPA id CDB5297CAC
	for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 07:01:12 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1202262122370.23717@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Sun, 2012-02-26 at 21:23 -0800, Sage Weil wrote:
> v0.42.2 for now.. v0.43 should be out either Friday or the following 
> Monday.
 OK, will get v0.42.2 from git, as the homepage has only v0.42 for
download.

On Sun, 2012-02-26 at 21:29 -0800, Sage Weil wrote:
> Hmm, actually it looks like /run isn't present on many of my machines 
> (squeeze, oneiric).  I'm inclined to stick with the /var/run symlink until 
> the change is more pervasive.  
 Yes, this change is for the new Debian and Ubuntu releases in
development. The others have /var/run only.

> Is this important enough to add an autoconf option to use the new path 
> instead of the old?
 Not at all. Even now /run is the real directory, /var/run is now a
symlink to it. Everyone can still use /var/run for a while.

Laszlo/GCS

