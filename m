From: David Disseldorp <ddiss@suse.de>
Subject: Re: udev remove events to mark OSD down/out on disk-pull
Date: Wed, 16 Nov 2016 16:16:02 +0100
Message-ID: <20161116161602.7d5ff898@suse.de>
References: <20161116033042.68eee001@suse.de>
        <alpine.DEB.2.11.1611161448100.8814@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41409 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932123AbcKPPQF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 10:16:05 -0500
In-Reply-To: <alpine.DEB.2.11.1611161448100.8814@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 16 Nov 2016 14:50:30 +0000 (UTC), Sage Weil wrote:

> On Wed, 16 Nov 2016, David Disseldorp wrote:
> > Hi,
> > 
> > I'm currently looking at ways to speed up OSD down/out notifications
> > for disk-pull events, and was investigating using udev remove events
> > for this.
> > 
> > IIUC, the outage currently propagates through to the mons via OSD device
> > I/O error -> filestore I/O error ->  ceph-osd ceph_abort() -> heartbeat
> > failure.  
> 
> We just merged (post-jewel) a change that makes connection refused events 
> trigger an immediate mark-down of the peer OSD.  I think this will have 
> the same effect, as long as the ceph-osd process is killed in a timely 
> manner.  Have you tried it?  I'd suggest making sure that it's not 
> sufficient before investing too much time into a udev-based approach...
> 
> See a033dc6f5b4cef357db6f5951062d680e880ba0e

Looks much cleaner than handling this in udev. I'll test this with
Jewel and follow up - thanks Sage!

Cheers, David
