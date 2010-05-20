From: Fred Ar <ar.fred@yahoo.com>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 09:59:08 -0700 (PDT)
Message-ID: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
References: <1274359650.1907.212.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from n4-vm0.bullet.mail.gq1.yahoo.com ([67.195.9.7]:24661 "HELO
	n4-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753680Ab0ETQ7J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 May 2010 12:59:09 -0400
In-Reply-To: <1274359650.1907.212.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--- On Thu, 5/20/10, Wido den Hollander <wido@pcextreme.nl> wrote:
> Hi,
> 
> When hanging around the mailinglist i noticed that there
> are a lot of
> questions about Ceph and possible hardware setups.
> 
> After reading http://ceph.newdream.net/wiki/Designing_a_cluster i've
> still got a lot of questions hanging around, so this is why
> i'm making
> this post.
> 
> I in my situation i would like to run Ceph on the cheapest
> (best bang
> for buck) hardware available.
> 
> Think about simple servers with 4 to 6 harddisks (desktop
> mainboards,
> cpu's and disks) and building Ceph on top of that.
> 
> We want to skip the expensive RAID controllers, since they
> become
> obsolute when using Ceph and setting the replication on the
> desired
> level.
> 
> Now we get to the OSD topic:
> * One cosd per disk?
> * Btrfs stripe accross these disks?
> * What about journaling?
> 
> With a custom CRUSH map
> ( http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
> ) you
> can place data on strategic locations, in my situation i
> would create 5
> pools with each 4 OSD's, where these 4 pools are all
> located in seperate
> 19" racks. In each rack i would hang:
> * 1 MON
> * 1 MDS
> * 4 OSD's
> 
> Why 5 pools? This is because i would need a odd number of
> monitors. Yes,
> i could choose to place 3 monitors, but i would like to
> create a pool
> where al 6 machines are connected to the same switch. Is
> this
> reasonable? Or is that many monitors really overdone?
> 
> Now, the OSD's all have 4 to 6 harddisks (but lets stick to
> 4), now i
> have the option to run an OSD for each harddisk, which
> would give me
> shorter recover times when a disk fails, but would give me
> extra
> configuration / administration.
> 
> But i could also choose to make one btrfs stripe over these
> 4 disks and
> run one OSD. This would give me a higher recover time when
> a disk fails
> (since the whole stripe fails), but would keep my config
> smaller.
> 
> In the first setup i would only benefit if i could replace
> the failed
> disk hot-swap. If not, i would have to bring the whole
> system down,
> which would take the other 3 OSD's with it, thus leaving my
> cluster with
> 4 less OSD's.
> 
> I could buy more expensive hardware with hot-swap
> capabilities, but imho
> that is not really what i would like to do with Ceph.
> 
> I'd prefer the situation where i'd stripe over all 4 disks,
> giving me
> and extra pro. In this situation i could configure my node
> to panic
> whenever a disk is starting to give errors, so my cluster
> can take over
> immediately.
> 
> Am i right? Is this "the way to go"?

I don't know the way to go.
But I think that in the 1st case (1 OSD per hard disk) when a hard disk fails, it gets replicated elsewhere. During that time the other 3 OSDs on the same machine are still working fine and serving requests. And then some time later, you've got a brand new disk, you shutdown the machnie, that's 3 more OSDs down.
In the 2nd case, as soon as 1 disk starts failing, your OSD (which is 4 disks) gets taken down, that's approximately equivalent to 4 OSDs going down at the same time if we compare to your 1st case.

So in both cases you have to shutdown 1 machine, but in the 1st case your cluster gets replicated in 2 stages, first the failing OSD, then the 3 other (when you change the disk). And before the 2nd stage the 3 disks that stayed alive still work... If the network is a bottleneck, the 1st case might be better, because less data gets replicated at the same time.

About your 2nd case: as cheap as the hardware may be, having 3 perfectly operational disks not working has a cost...

What I don't know, in both cases, is: when the machines gets back online, will it hold the same data as before being shutdown, or will they get entirely new data? I can remember that crush was quite stable and designed to avoid that kind of full cluster rebalance on failing/new OSD...

I don't understand how - in the 2nd case - the btrfs pool of 4 disks would "repair" its missing data, so that the data on the 3 good disks does not need to get replicated over the network.

> Then there is the journaling topic.
> 
> When creating a filesystem you get a big warning if the
> drive cache is
> enabled on the journaling partition. Imho you don't want to
> have a drive
> cache on your journal, but you do want to have one on your
> data
> partition.
> 
> This forces you to use a seperate disk for your journaling.
> Assume that
> i would have 4 disks in a btrfs stripe, would a fifth disk
> for
> journaling only be sufficient? I assume so, since it only
> has to hold
> data for a few seconds.

Let me just copy/paste a question asked yesterday on irc, and Sage's answer:

me> sagewk, what is the best: - a jounal on a partition, same disk as osd data and disk write caching off, or - journal on a filesystem, same disk as osd data, write caching on?
sagewk> partition with write cache off, i suspect.
sagewk> hopefully someday we'll be able to flush the disk cache from userspace and that annoyance will go away
me> so you don't expect a performance penalty running btrfs on a disk with caching deacivated
sagewk> not really.  the writer threads should keep the disk busy, and the commit sequence has barriers that flushes the cache anyway.

My question was not exactly the same as yours, but I think the answer Sage gave is also valid in your case.

Fred


      

