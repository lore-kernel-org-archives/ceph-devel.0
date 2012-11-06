From: Sage Weil <sage@inktank.com>
Subject: Re: chaning pg_num / pgp_num after adding more osds
Date: Tue, 6 Nov 2012 02:59:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211060251380.12495@cobra.newdream.net>
References: <5097C9DD.3030600@profihost.ag> <50984F82.3010706@inktank.com> <5098BCFF.6050004@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33052 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab2KFK7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 05:59:04 -0500
In-Reply-To: <5098BCFF.6050004@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 6 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Am 06.11.2012 00:45, schrieb Josh Durgin:
> > On 11/05/2012 06:14 AM, Stefan Priebe - Profihost AG wrote:
> > > Hello list,
> > > 
> > > Is there a way to change the number of pg_num / pgp_num after adding
> > > more osds?
> > 
> > The pg_num/pgp_num settings are only used by mkcephfs at install time.
> > 
> > > I mean i would like to start with 16 OSDs but i think i'll expand over
> > > time to up to 100 OSDs. So i think i need to tune pg_num / pgp_num.
> > 
> > You can specify pg_num when creating a pool:
> > 
> > ceph osd pool create <name> <pgnum>
> > 
> > But you don't want to have too many (thousands per osd). Being able
> > to change the number of pgs in a pool (pg splitting/merging) is in
> > the works, but in the mean time you can create more pools after you add
> > a bunch of osds to keep your pg/osd ratio around 100.
> 
> Thanks Josh for your explanation. I'm not sure if i already understood what pg
> is at all.
> 
> First i see that ceph is creating 832 pgs for 12 osds in my case per default.
> This is 69,3333333 per OSD. You're talking about 100 - is the default
> calculation broken or hardcoded?

Each PG has N copies, where N defaults to 2.  So that would be ~139 per 
osd.

The 100 per osd is a very rough guide; that is just a decent balance 
between variance in utilization (~10%) and pg overhead (too many PGs can 
use RAM on the ceph-osds and introduce more replication/syncrhonization 
related network traffic).

> When i have one pool with 800 pgs and i add 20 new OSDs how does a new pool
> help? I mean the old pools will stay with 800 pgs.

It make the distribution of existing data less coarse, but as the size of 
teh PGs for the new pool increases things will tend to level out.

My suggestion is to overshoot the PG count a little bit (not too much!), 
maybe ~200 pgs per osd.  If things get too unbalanced after a significant 
expansion you can put new data is new pools, or make fine-grainted 
adjustments in the CRUSH map.  

I suspect that this will be sufficient for just about everyone until the 
splitting functionality is in place... hopefully in 1-2 dev releases after 
bobtail.

sage

