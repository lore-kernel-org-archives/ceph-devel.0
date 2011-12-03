From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Sat, 03 Dec 2011 15:21 +0100
Message-ID: <3826746.5bRf3lS2YZ@tolkien>
References: <4366451.BU1d1YAr76@pc10> <2356347.ajsbJfnmVK@pc10> <CACLRD_0mb_PxqmZUqgTnjXJARKw6NV34QEF_fqCtXZ4UJ7C9GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:42832 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab1LCOVI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 3 Dec 2011 09:21:08 -0500
Received: from tolkien.localnet (dslc-082-083-217-020.pools.arcor-ip.net [82.83.217.20])
	by hartes-hannover.de (Postfix) with ESMTPSA id 33E6210C866
	for <ceph-devel@vger.kernel.org>; Sat,  3 Dec 2011 15:21:07 +0100 (CET)
In-Reply-To: <CACLRD_0mb_PxqmZUqgTnjXJARKw6NV34QEF_fqCtXZ4UJ7C9GQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Friday 02 December 2011 11:29:41 Samuel Just wrote:
> Guido,
> 
> Sorry for the confusion, you hit a bug where the default map for a
> cluster with one osd contains no pgs.  0.39 (which will be released
> today) will have a fix.

Really? Then why does the output of ceph -s below mention 6 pgs?

BTW, that's another aspect where the documentation is a bit lacking right now. 
I've found a page telling me how to change the number of pgs, but I couldn't 
find any explanation so far what a pg actually is, or why I should want to 
change their number...

	Guido
 
> -Sam
> 
> On Fri, Dec 2, 2011 at 8:24 AM, Guido Winkelmann
> 
> <guido-ceph@thisisnotatest.de> wrote:
> > Hi,
> > 
> > Am Freitag, 25. November 2011, 19:54:42 schrieb Wido den Hollander:
> >> Hi Guido,
> >> 
> >> On 11/25/2011 05:53 PM, Guido Winkelmann wrote:
> >> > Hi,
> >> > 
> >> > When trying to mount a Ceph filesystem with "mount.ceph
> >> > 10.3.1.33:6789:/ /mnt", the command hangs for several minutes and
> >> > then fails with the message
> >> > 
> >> > mount error 5 = Input/output error
> >> 
> >> Does "ceph -s" work? If so, what is the output?
> > 
> > It works. This is the output:
> > 
> > # ceph -s
> > 2011-11-28 18:51:32.018383    pg v60: 6 pgs: 6 active+clean+degraded; 0
> > KB data, 1292 KB used, 1750 GB / 1752 GB avail
> > 2011-11-28 18:51:32.018610   mds e11: 1/1/1 up {0=alpha=up:creating}
> > 2011-11-28 18:51:32.018698   osd e22: 1 osds: 1 up, 1 in
> > 2011-11-28 18:51:32.018767   log 2011-11-28 18:50:16.299822 mon.0
> > 10.3.1.33:6789/0 3 : [INF] mds.? 10.3.1.33:6800/21218 up:boot
> > 2011-11-28 18:51:32.018833   mon e1: 1 mons at {ceph1=10.3.1.33:6789/0}


