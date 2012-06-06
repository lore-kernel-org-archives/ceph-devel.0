From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph and BackupPC (was: Re: mount: 10.0.6.10:/: can't read
 superblock)
Date: Wed, 6 Jun 2012 09:24:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206060923070.5397@cobra.newdream.net>
References: <c99406dc-0969-47de-a75a-72a8f42eae52@mail.linserv.se>
 <3941218.dafc4yYMCO@pc10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35012 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2FFQYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:24:09 -0400
In-Reply-To: <3941218.dafc4yYMCO@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Martin Wilderoth <martin.wilderoth@linserv.se>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 6 Jun 2012, Guido Winkelmann wrote:
> Am Dienstag, 5. Juni 2012, 14:33:19 schrieb Martin Wilderoth:
> 
> > I have not done any changes installed at version 0.46 upgraded earlier and
> > have been testing with ceph and ceph-fuse and backuppc.
> 
> BackupPC and Ceph sounds like an interesting combination. Other than this 
> hanging MDS problem, what are your experiences with that?
> 
> I'm asking because BackupPC is the only application I know of that actually 
> makes heavy use of hardlinks. Ceph, as far as I've understood it, supports 
> hardlinks, but works under the assumption that they're a rare and not 
> performance-critical corner case, and does some optimizations that help the 
> more common cases, but would probably hurt if you are using hardlinks a lot.

Right.  There is currently a scalability limit on the number of hard 
links, currently.  Any large set of backuppc data will eat a lot of memory 
on mds.0 and (eventually) case problems.

sage

