From: Sage Weil <sage@newdream.net>
Subject: Re: wip-librbd-caching
Date: Wed, 18 Apr 2012 10:44:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204181042510.15730@cobra.newdream.net>
References: <4F872D48.6070801@tuxadero.com> <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
 <4F8EB889.4080106@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2DRRoo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 13:44:44 -0400
In-Reply-To: <4F8EB889.4080106@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Wed, 18 Apr 2012, Martin Mailand wrote:
> Am 12.04.2012 21:45, schrieb Sage Weil:
> > The config options you'll want to look at are client_oc_* (in case you
> > didn't see that already :).  "oc" is short for objectcacher, and it isn't
> > only used for client (libcephfs), so it might be worth renaming these
> > options before people start using them.
> 
> Hi,
> 
> I changed the values and the performance is still very good and the memory
> footprint is much smaller.
> 
> OPTION(client_oc_size, OPT_INT, 1024*1024* 50)    // MB * n
> OPTION(client_oc_max_dirty, OPT_INT, 1024*1024* 25)    // MB * n  (dirty OR
> tx.. bigish)
> OPTION(client_oc_target_dirty, OPT_INT, 1024*1024* 8) // target dirty (keep
> this smallish)
> // note: the max amount of "in flight" dirty data is roughly (max - target)
> 
> But I am not quite sure about the meaning of the values.
> client_oc_size Max size of the cache?

yes

> client_oc_max_dirty max dirty value before the writeback starts?

before writes block and wait for writeback to bring the dirty level down

> client_oc_target_dirty ???

before writeback starts

BTW I renamed 'rbd cache enabled' -> 'rbd cache'.  I'd like to rename the 
objectcacher settings too so they aren't nested under client_ (which is 
the fs client code).

objectcacher_*?

sage
