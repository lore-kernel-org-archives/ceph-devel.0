From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph Manager brag module
Date: Thu, 14 Dec 2017 22:52:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712142250300.2838@piezo.novalocal>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com> <robbat2-20171214T223534-352252711Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:56988 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbdLNWw4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 17:52:56 -0500
In-Reply-To: <robbat2-20171214T223534-352252711Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel@vger.kernel.org

On Thu, 14 Dec 2017, Robin H. Johnson wrote:
> On Thu, Dec 14, 2017 at 10:24:24AM +0100, Wido den Hollander wrote:
> > Hi,
> > 
> > After discussing with Sage I started to work [0] on a 'brag' module for 
> > Ceph Manager.
> > 
> > The intention of this module is to send (after a opt-in!) statistics 
> > about a Ceph cluster back to the project every few days.
> I like it, but have one concern.
> 
> > My intention is to include:
> > - fsid (as identifier)
> Please don't expose the raw FSID.
> Consider a hash of FSID before submission.

+1. I'd actually just generate a new uuid and stash it in mgr/brag/brag-id 
(or similar) in config-key.

> > - number of MONs
> > - number of OSDs
> > - FileStore / BlueStore
> > - number of pools / PGs
> > - data used in bytes
> > - data free
> > - number of objects,
> > - version(s)
> RGWs?

It can summarize everything in servicemap by type so that we also capture 
other daemons too (rbd-mirror and future gateways).

sage
