From: Sage Weil <sage@newdream.net>
Subject: Re: CEPH distributed filesystem on two sites
Date: Thu, 15 Jul 2010 09:10:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007150905010.26304@cobra.newdream.net>
References: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
 <201007121409.00765.iggy@theiggy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43995 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646Ab0GOQIH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jul 2010 12:08:07 -0400
In-Reply-To: <201007121409.00765.iggy@theiggy.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Jackson <iggy@theiggy.com>
Cc: Roland Rabben <roland@jotta.no>, ceph-devel@vger.kernel.org

On Mon, 12 Jul 2010, Brian Jackson wrote:
> On Monday, July 12, 2010 01:59:38 pm Roland Rabben wrote:
> > Have there been any work to get CEPH working with two datacenters?
> 
> 
> We've talked about it on irc in the past. It's not really what ceph was 
> designed for, but given sufficient bandwidth between the DCs it should work.
> 
> In your particular situation if 1 DC was disconnected but not down, you could 
> have an issue if things changed in both locations. You would also have an 
> issue if connectivity was lost because ceph would try to replicate things up 
> to 3x at both sites.

Well, sort of.  If have a network partition, only one partition will be 
available (whichever can reach the majority of the monitors).  No updates 
will be applied to the disconnected DC.  Ceph favors consistency over 
availability in the presence of a partition.

This lends itself to a primary + data backup DC type of situation where 
the majority (or all) monitors are in the primary DC, but there is no 
failover.  Actual failover would need a one or more monitors is at a third 
location.  But this is not a case that is designed or optimized for, so 
improvements could definitely be made.

sage

> 
> > 
> > I would like to have two copies of a file at site 1 and a third copy
> > at site two.
> 
> 
> That should be achievable.
> 
> 
> > And would you be able to continue running with one of the sites down?
> 
> 
> Well, taking into consideration the things I already mentioned, you should 
> continue to have access to the filesystem.
> 
> 
> > 
> > Best regards
> > 
> > Roland Rabben
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
