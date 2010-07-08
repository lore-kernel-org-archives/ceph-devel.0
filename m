From: Sage Weil <sage@newdream.net>
Subject: Re: "clocks not synchronized" warning message
Date: Thu, 8 Jul 2010 07:53:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007080750200.32514@cobra.newdream.net>
References: <i14hq2$hn$1@dough.gmane.org> <1278598768.2253.18.camel@wido-laptop.pcextreme.nl>
 <i14nfj$hn$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0GHOvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 10:51:18 -0400
In-Reply-To: <i14nfj$hn$4@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Thu, 8 Jul 2010, Thomas Mueller wrote:

> Am Thu, 08 Jul 2010 16:19:28 +0200 schrieb Wido den Hollander:
> 
> > Hi,
> > 
> > I'm experiencing the same. The default "mon lease wiggle room" is set t
> > .001, which gives the messages in my setup.
> 
> this is what I just found too - in unstable the default is now 0.010.  
> with 0.5 the message was still there. with 1.0 it was away.
> 
> I think 0.010 is still a bit small for a system not connected to a atomic 
> clock? :)

How about .5 seconds?  We sync our machines to a local ntp server, so the 
clocks get really close (sub-ms).  I forget that NTP isn't so accurate 
over a WAN.

The issue is that the monitor leases and timeouts are something like 2 
seconds (so that failures/unavailability) are detected quickly, so the 
tolerable clock drift can't get too close to that.

sage
