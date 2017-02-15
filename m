From: Sage Weil <sage@newdream.net>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 17:34:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702151723350.7782@piezo.novalocal>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl> <CAJ4mKGZPfWg+WCfYdaobuRj0BgqSatQ11UNTFhvxqNiG2Fh-vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36892 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBORex (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 12:34:53 -0500
In-Reply-To: <CAJ4mKGZPfWg+WCfYdaobuRj0BgqSatQ11UNTFhvxqNiG2Fh-vw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 15 Feb 2017, Gregory Farnum wrote:
> On Wed, Feb 15, 2017 at 8:59 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't provide a OSD ID.
> >
> > With BlueStore coming I think the use-case for this is becoming very valid:
> >
> > 1. Stop OSD
> > 2. Zap disk
> > 3. Re-create OSD with same ID and UUID (with BlueStore)
> > 4. Start OSD
> >
> > This allows for a in-place update of the OSD without modifying the CRUSHMap. For the cluster's point of view the OSD goes down and comes back up empty.
> >
> > There were some drawbacks around this and some dangers, so before I start working on a PR for this, any gotcaches which might be a problem?
> 
> Yes. Unfortunately they are subtle and I don't remember them. :p
> 
> I'd recommend going back and finding the historical discussions about
> this to be sure. I *think* there were two main issues which prompted
> us to remove that:
> 1) people creating very large IDs, needlessly exploding OSDMap size
> because it's all array-based,

Working in terms of uuids should avoid this (i.e., users can't 
force a large oid id without significant effort).

> 2) issues reusing the ID of lost OSDs versus PGs recognizing that the
> OSD didn't have the data they wanted.
> 
> 1 is still a bit of a problem, though if anybody has a good UX way of
> handling it that's the real issue. 2 has hopefully been fixed over the
> course of various refactors and improvements, but it's not something
> I'd count on without checking very carefully.

Oh yeah, this is the one that worries me.  I think the scenario we want 
to help users avoid is that osd N exists (but might be down at the moment) 
and a new, empty version of that same OSD is created and started.  
Peering will reasonably conclude that PG instances don't exist and may 
end up concluding that writes didn't happen.

I think we want some sort of safety check so that the user as to say "this 
osd is dead" before they're allowed to create a new one in its image.  I 
think the simplest thing is to use the existing 'ceph osd lost ...' 
command for this.  I.e., the mon won't let a blank OSD start with a given 
uuid/id unless it is either a new osd rank or the rank is marked 
lost.

My main lingering doubt here is whether it's a bad idea to reuse a uuid; 
it seems like the whole point is that uuids are unique.  Perhaps instead 
the ceph-disk prepare --replace-oid NN command should replace the old uuid 
in the map with the new one as part of this process.  Probably something 
like 'ceph osd replace newuuid olduuid' to make the whole thing 
idempotent...

sage



> -Greg
> 
> >
> > The idea is that users have a very simple way to re-format a OSD in-place while keeping the same CRUSH location, ID and UUID.
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
