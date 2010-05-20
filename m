From: Brian Jackson <iggy@theiggy.com>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 12:03:23 -0500
Message-ID: <201005201203.23647.iggy@theiggy.com>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from theiggy.com ([66.220.1.110]:53844 "EHLO mail.theiggy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393Ab0ETRNI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 May 2010 13:13:08 -0400
Received: from matrix.theiggy.com (ip187.ravinia.hou.ygnition.net [24.219.194.187])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.theiggy.com (Postfix) with ESMTPSA id 8ECE5E411
	for <ceph-devel@vger.kernel.org>; Thu, 20 May 2010 12:03:25 -0500 (CDT)
In-Reply-To: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thursday 20 May 2010 11:59:08 Fred Ar wrote:
> --- On Thu, 5/20/10, Wido den Hollander <wido@pcextreme.nl> wrote:
> > Hi,
> > 
<snip>
> > 
> > Am i right? Is this "the way to go"?
> 
> I don't know the way to go.
> But I think that in the 1st case (1 OSD per hard disk) when a hard disk
> fails, it gets replicated elsewhere. During that time the other 3 OSDs on
> the same machine are still working fine and serving requests. And then
> some time later, you've got a brand new disk, you shutdown the machnie,
> that's 3 more OSDs down. In the 2nd case, as soon as 1 disk starts
> failing, your OSD (which is 4 disks) gets taken down, that's approximately
> equivalent to 4 OSDs going down at the same time if we compare to your 1st
> case.
> 
> So in both cases you have to shutdown 1 machine, but in the 1st case your
> cluster gets replicated in 2 stages, first the failing OSD, then the 3
> other (when you change the disk). And before the 2nd stage the 3 disks
> that stayed alive still work... If the network is a bottleneck, the 1st
> case might be better, because less data gets replicated at the same time.


You could even plan it out and decomm each remaining osd one at a time at off-
peak hours to minimize disruption and the possibility of stressing the system 
so much that something else fails.


> 
> About your 2nd case: as cheap as the hardware may be, having 3 perfectly
> operational disks not working has a cost...
> 
> What I don't know, in both cases, is: when the machines gets back online,
> will it hold the same data as before being shutdown, or will they get
> entirely new data? I can remember that crush was quite stable and designed
> to avoid that kind of full cluster rebalance on failing/new OSD...
> 
> I don't understand how - in the 2nd case - the btrfs pool of 4 disks would
> "repair" its missing data, so that the data on the 3 good disks does not
> need to get replicated over the network.
> 
> > Then there is the journaling topic.
> > 
> > When creating a filesystem you get a big warning if the
> > drive cache is
> > enabled on the journaling partition. Imho you don't want to
> > have a drive
> > cache on your journal, but you do want to have one on your
> > data
> > partition.
> > 
> > This forces you to use a seperate disk for your journaling.
> > Assume that
> > i would have 4 disks in a btrfs stripe, would a fifth disk
> > for
> > journaling only be sufficient? I assume so, since it only
> > has to hold
> > data for a few seconds.
> 
> Let me just copy/paste a question asked yesterday on irc, and Sage's
> answer:
> 
> me> sagewk, what is the best: - a jounal on a partition, same disk as osd
> data and disk write caching off, or - journal on a filesystem, same disk
> as osd data, write caching on? sagewk> partition with write cache off, i
> suspect.
> sagewk> hopefully someday we'll be able to flush the disk cache from
> userspace and that annoyance will go away me> so you don't expect a
> performance penalty running btrfs on a disk with caching deacivated
> sagewk> not really.  the writer threads should keep the disk busy, and the
> commit sequence has barriers that flushes the cache anyway.
> 
> My question was not exactly the same as yours, but I think the answer Sage
> gave is also valid in your case.
> 
> Fred
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
