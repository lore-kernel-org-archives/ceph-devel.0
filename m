From: Sage Weil <sage@inktank.com>
Subject: Re: Newbie questions
Date: Mon, 1 Oct 2012 09:13:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210010908160.25178@cobra.newdream.net>
References: <k4c2dj$s3i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43844 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2JAQNm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:13:42 -0400
In-Reply-To: <k4c2dj$s3i$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

On Mon, 1 Oct 2012, Adam Nielsen wrote:
> Hi all,
> 
> I've been investigating cluster filesystems for a while now, and I have a few
> questions about Ceph I hope you don't mind me asking here.  This is in the
> context of using Ceph as a POSIX filesystem and alternative to something like
> NFS.
> 
>   1. Is Ceph stable enough for "real" use yet?  I read that upgrading to v0.48
> required a reformat, which I imagine would be a bit of an issue in a
> production system.  Is this how upgrades are normally done?  Is anyone running
> Ceph in a production environment with real data yet?

The upgrade to v0.48 required a conversion the first time each ceph-osd 
daemon was started with new code.  It was transparent to the user except 
for the fact that the conversion was slow.  It is also atypical.

The goal is for all future Ceph upgrades to be transparent and rolling 
(i.e., upgrade one daemon/machine at a time while the cluster remains 
completely available).  This is an absolute requirement for 
upgrades/updates within a stable series (e.g., v0.48 -> v0.48.2), and a 
high priority and probability between versions (argonaut -> bobtail, v0.51 
-> v0.52, etc.).

>   3. If I have multiple disks in a machine that I can dedicate to Ceph, is it
> better to RAID them and present Ceph with a single filesystem, or do you get
> better results by giving Ceph a filesystem on each disk and letting it look
> after the striping and any faulty disks?

There are arguments to be made for both configurations.  Currently we are 
using (and generally recommending) one ceph-osd per disk.  I would 
consider going the RAID route if you have limited RAM on the node or have 
a high-end RAID array that you want to take full advantage of.

sage
