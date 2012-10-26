From: Sage Weil <sage@inktank.com>
Subject: Re: Proper configuration of the SSDs in a storage brick
Date: Fri, 26 Oct 2012 09:33:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210260929090.23524@cobra.newdream.net>
References: <002401cdb2b4$f259c800$d70d5800$@netmass.com> <508A9657.3080006@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42419 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301Ab2JZQdx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 12:33:53 -0400
In-Reply-To: <508A9657.3080006@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Stephen Perkins <perkins@netmass.com>, ceph-devel@vger.kernel.org

On Fri, 26 Oct 2012, Wido den Hollander wrote:
> On 10/25/2012 03:30 PM, Stephen Perkins wrote:
> > Hi all,
> > 
> > In looking at the design of a storage brick (just OSDs), I have found a dual
> > power hardware solution that allows for 10 hot-swap drives and has a
> > motherboard with 2 SATA III 6G ports (for the SSDs) and 8 SATA II 3G (for
> > physical drives).  No RAID card. This seems a good match to me given my
> > needs.  This system also supports 10G Ethernet via an add in card, so please
> > assume that for the questions.  I'm also assuming 2TB or 3TB drives for the
> > 8 hot swap.  My workload is throughput intensive (writes mainly) and not IOP
> > heavy.
> > 
> > I have 2 questions and would love to hear from the group.
> > 
> > Question 1: What is the most appropriate configuration for the journal SSDs?
> > 
> > I'm not entirely sure what happens when you lose a journal drive.  If the
> > whole brick goes offline (i.e. all OSDs stop communicating with ceph), does
> > it make since to configure the SSDs into RAID1?
> > 
> 
> When you loose the journal these OSDs will commit suicide and in this case
> you'd loose 8 OSDs.

One small correction here: it depends.

If you use ext4 or XFS, then yes: losing the journal means the data disk 
is lost too.  

However, if you use btrfs, the data disk has consistent point-in-time 
checkpoints it can roll back to.  It is not useful from the perspective of 
a specific IO request (i.e., if client X wrote to 3 replicas, then all 3 
replicas lost their journals, the write may have been lost, along with the 
other 0.01% of writes that happened in the last several seconds).

On the other hand, for a single osd that loses the journal, you can 
initialize a new one and it can rejoin the cluster and will have 99.99% of 
the data in place, making reintegration/recovery quick and cheap

sage
