From: Sage Weil <sage@newdream.net>
Subject: Re: rados import/export
Date: Mon, 30 Apr 2012 13:50:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45615 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839Ab2D3UuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 16:50:15 -0400
In-Reply-To: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 30 Apr 2012, Henry C Chang wrote:
> Hi all,
> 
> I found one issue when I played around the "rados import/export"
> commands. I tried:
> 
> 1. Export the pool ".users.uid" to a local directory.
> 2. Delete the pool.
> 3. Import the pool ".user.uid" from the local directory.
> 
> After the pool is restored, the rgw's user info are correct. However,
> I failed to list the user's buckets.
> Then, I traced the codes a little bit. It seems the problem is that we
> do not export/import the omaps (stored in leveldb) of the objects.
> Since v0.44, we employed leveldb to store the key/value maps. I think
> we need to take care of the omaps as well during backup and restore.

The real question here is how *should* we be storing omap values when we 
export to/import from regular files?  A specially-marked (with xattr) .db 
file?

A related problem is how to store placement key strings for objects with 
modified placement; I can't remember if we already did something for that 
yet or not (maybe specially-named xattr?).

sage
