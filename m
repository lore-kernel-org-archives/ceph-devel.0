From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] add dkms support
Date: Wed, 28 Jul 2010 11:30:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007281125440.4541@cobra.newdream.net>
References: <Pine.LNX.4.64.1007280957090.4541@cobra.newdream.net>
 <Pine.LNX.4.64.1007280959400.4541@cobra.newdream.net> <i2pqdk$8l1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46191 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab0G1S1c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 14:27:32 -0400
In-Reply-To: <i2pqdk$8l1$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wed, 28 Jul 2010, Thomas Mueller wrote:
> Am Wed, 28 Jul 2010 10:02:19 -0700 schrieb Sage Weil:
> 
> > BTW, the Debian kernel guys would rather include the ceph module in the
> > main kernel package than include a dkms package directly in Debian. 
> > That means maintaining a backport branch specifically for 2.6.32 (the
> > squeeze kernel).
> > 
> > (We should still have this dkms package available on the ceph site, of
> > course!)
> 
> would be cool if they included it in squeeze kernel. but i'm bit 
> surprised. squeeze freeze is expected late august (http://
> lists.debian.org/debian-devel-announce/2010/06/msg00002.html) and debian 
> folks normaly don't bump versions and only do bugfixing after a release. 
> 
> so I would expect that squeeze has to include a stable ceph.ko and stable 
> server side too. And as the freeze seems to be approaching fast this 
> would be a tough schedule.

I'm not sure what their criteria are there... the ceph-dkms ITP is 589562,

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=589562

> what leads me to my other question: when will ceph be considered 
> "stable"? :)

Soon?  :)  I'd be interested in hearing what you (or anyone else) expect 
from a "stable" v1.0 release.

See http://tracker.newdream.net/projects/ceph/roadmap.

sage
