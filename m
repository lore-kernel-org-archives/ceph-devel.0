From: Sage Weil <sage@inktank.com>
Subject: Re: Determining when it's safe to reboot a node?
Date: Tue, 25 Sep 2012 12:19:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209251214570.28680@cobra.newdream.net>
References: <CAPud5_4Y2ff8Y5gNgaM0Ap_A4_NwBv2JvLpF9dWxxXKj1CZH-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab2IYTTn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 15:19:43 -0400
In-Reply-To: <CAPud5_4Y2ff8Y5gNgaM0Ap_A4_NwBv2JvLpF9dWxxXKj1CZH-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Hi Nick,

On Tue, 25 Sep 2012, Nick Bartos wrote:
> I need to figure out some way of determining when it's OK to safely
> reboot a single node.  I believe this involves making sure that at
> least one other monitor is running and up to date, and all the PGs on
> the local OSDs have up to date copies somewhere else in the cluster.
> We're not concerned about MDS at this time, since we're not currently
> using the POSIX filesystem.
> 
> I recall having a verbal conversation with Sage on this topic, but
> apparently I didn't take good notes or I can't find them.  I do
> remember the solution was somewhat complicated.  Is there any sort of
> straight forward 'ceph' command that can do this now?  If there isn't
> one, I think it would be really great if something like that could be
> implemented.  It would seem to be a common enough use case to have a
> simple command which could tell the admin if rebooting the node would
> render the cluster partially unusable.

Making a conservative determination should be pretty straightforward.  
Something like:

 - make sure losing any local mon won't break quorum
 - make sure all PGs touching local osd(s) are active+clean and have other 
   osds in the acting set

should do the trick, as a first pass at least.  This can all be done by 
analyzing the 'ceph pg dump --format=json', 'ceph osd dump --format=json', 
and 'ceph quorum_status'.  The annoying part is just mapping ip addresses 
to osds and mons to figure out which ones are local...

sage
