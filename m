From: Sage Weil <sage@newdream.net>
Subject: Re: Assertion in v0.40 - os/FileStore.cc: 2438: FAILED assert(0 ==
 "unexpected error")
Date: Sat, 14 Jan 2012 21:52:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201142150180.24825@cobra.newdream.net>
References: <4F1193DE.7040202@tuxadero.com> <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42157 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2AOFwM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jan 2012 00:52:12 -0500
In-Reply-To: <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi Martin-

On Sat, 14 Jan 2012, Sage Weil wrote:
> Hi Martin-
> 
> On Sat, 14 Jan 2012, Martin Mailand wrote:
> 
> > Hi
> > one of four OSD died during the update to v0.40 with an Assertion
> > os/FileStore.cc: 2438: FAILED assert(0 == "unexpected error")
> > Even after a complete shutdown of the cluster an a new start with all OSD at
> > the same version, this osd did not start.
> > 
> > The OSD Log it attached.
> 
> It's trying to replay a transaction that appears to be invalid because the 
> .2 clone is smaller than it thinks.  Is this the first time the OSD 
> crashed, or did it crash once, and you cranked up logs and generated 
> this one?  If you have the previous log, that would be helpful... it 
> should have a similar tranasction dump but a different stack trace.

I pushed a wip-osd-dump-journal branch to git that will make

	ceph-osd -i <whatever> --dump-journal > /tmp/foo.txt

dump the contents of your entire osd journal (sans data) to a text file.  
Do you mind sending that along as well?  I'd like to see what is in the 
journal _after_ the event that is failing (if anything).

Thanks!
sage


> 
> Also, are any of the 6 patches on top of 0.40 related to the filestore or 
> osd?
> 
> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
