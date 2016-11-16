From: Sage Weil <sage@newdream.net>
Subject: Re: udev remove events to mark OSD down/out on disk-pull
Date: Wed, 16 Nov 2016 14:50:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611161448100.8814@piezo.us.to>
References: <20161116033042.68eee001@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50166 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbcKPOud (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 09:50:33 -0500
In-Reply-To: <20161116033042.68eee001@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 16 Nov 2016, David Disseldorp wrote:
> Hi,
> 
> I'm currently looking at ways to speed up OSD down/out notifications
> for disk-pull events, and was investigating using udev remove events
> for this.
> 
> IIUC, the outage currently propagates through to the mons via OSD device
> I/O error -> filestore I/O error ->  ceph-osd ceph_abort() -> heartbeat
> failure.

We just merged (post-jewel) a change that makes connection refused events 
trigger an immediate mark-down of the peer OSD.  I think this will have 
the same effect, as long as the ceph-osd process is killed in a timely 
manner.  Have you tried it?  I'd suggest making sure that it's not 
sufficient before investing too much time into a udev-based approach...

See a033dc6f5b4cef357db6f5951062d680e880ba0e

sage

> 
> For the disk-pull case, this should be relatively easy to speed up
> by handling the remove event in 95-ceph-osd.rules with an appropriate
> osd down/out PDU. The problem then becomes maintaining consistent
> information in the udev database (all stashed via IMPORT{program}):
> - cluster / OSD ids
> - appropriate cephx creds
> 
> Before I hack something up for this, I'm interested in what others
> think, and whether anyone has already gone down this path. I seem to
> recall someone attempting to change the ceph-osd behaviour on I/O
> error at some stage.
> 
> Cheers, David
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
