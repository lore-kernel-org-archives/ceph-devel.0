From: Sage Weil <sage@newdream.net>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 17:16:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702151715170.7782@piezo.novalocal>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl> <alpine.DEB.2.11.1702151712530.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36784 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdBORQX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 12:16:23 -0500
In-Reply-To: <alpine.DEB.2.11.1702151712530.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 15 Feb 2017, Sage Weil wrote:
> On Wed, 15 Feb 2017, Wido den Hollander wrote:
> > Hi,
> > 
> > Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't 
> > provide a OSD ID.
> > 
> > With BlueStore coming I think the use-case for this is becoming very 
> > valid:
> > 
> > 1. Stop OSD
> > 2. Zap disk
> > 3. Re-create OSD with same ID and UUID (with BlueStore)
> > 4. Start OSD
> > 
> > This allows for a in-place update of the OSD without modifying the 
> > CRUSHMap. For the cluster's point of view the OSD goes down and comes 
> > back up empty.
> > 
> > There were some drawbacks around this and some dangers, so before I 
> > start working on a PR for this, any gotcaches which might be a problem?
> > 
> > The idea is that users have a very simple way to re-format a OSD 
> > in-place while keeping the same CRUSH location, ID and UUID.
> 
> +1
> 
> However, I don't think we need to specify the osd id.. just the uuid.  If 
> you pass an existing uuid to 'osd create' it will give you back the 
> existing osd id.  Please test to confirm, but I *think* it is sufficient 
> to just give ceph-disk prepare the old osd's uuid.
> 
> Maybe the thing to do is create a streamlined command to do this: 
> 'ceph-disk prepare --zap-and-reformat' or something that grabs the old 
> uuid for you, does the zap, and then feeds it to prepare?

Hmm, alternatively, maybe we want something a bit more generic, like

 ceph-disk prepare --replace-osd-id NNN ...

and have that fetch the uuid to use from the monitor.  That way it's the 
same process if you yank out a failed disk, plug a new one in, and want to 
rebuild it in place.

sage
