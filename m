From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to deal with a single host with several harddisks
Date: Wed, 04 May 2011 18:35:43 +0200
Message-ID: <1304526943.4036.117.camel@wido-laptop.pcextreme.nl>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
	 <1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
	 <BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
	 <BANLkTikJQyqvC6MCYFyrV3T5=FZBHFatYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:54595 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1EDQfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 12:35:45 -0400
In-Reply-To: <BANLkTikJQyqvC6MCYFyrV3T5=FZBHFatYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: tsk <aixt2006@gmail.com>, ceph-devel@vger.kernel.org

Hi,
On Thu, 2011-05-05 at 00:10 +0800, Sylar Shen wrote:
> Hi,
> Recently I have encountered a similar situation just like you did.
> I got 20 servers as OSD. Each server has 1T * 12 disks, 8 cores CPU
> and 16 GB memory.
> I've thought that I can set each disk as a cosd or make disks as a LVM
> and run only one cosd on each server.
> Or maybe I can set 2 or 3 LVMs on each server.
> Then I wonder the differences between them about performance and functionality?
> Which way is better for both performance and functionality?

Yes, you could make a LVM "stripe" over all the disks with just one cosd
process. 2 or 3 VG's would also be possible, that's not the problem.

This would reduce the memory usage.

> 
> Wido said he recommended running one cosd process per disk because
> this way Ceph can take the full advantage of all the available
> diskspace
> Please forgive my foolishness, I don't quite understand what kind of
> full advantages Ceph can take by doing this?
> If I use LVM, would there be any possible problems?

If you would run 12 disks in one machine, I wouldn't recommend running
in a stripe setup, if just one disk fails, you would loose 12TB of data!

Sure, you could start up the array again with a fresh disk, but you
would then have to resync a lot of data (12TB at max).

You could also run RAID-5 over those 12 disks and run one OSD on top of
it, but then you would start wasting disk space, since you are already
replicating all your data with RADOS/Ceph, why waste space to RAID-5?

If you would run one OSD per disk you would only loose 1TB of data when
a disk fails, when you replace the disk you'd only have to re-sync 1TB
of data.

That's what I meant about Ceph taking the full advantage of the
available disk space when you have one cosd per disk.

Also, I wouldn't run 12 disks in one machine, IMHO I would stick to
small boxes with 4 ~ 6 disks and have a LOT of them.

> 
> Speaking of disks, I found using btrfs did good performance but bad stability.
> While doing performance(read/write speed) test it dropped a lot when
> using ext4, is it normal?

btrfs is still under development, so I'd recommend using a recent kernel
like the .38 or upcoming .39

Running on ext4 is indeed a bit slower.

Wido

> 
> Thanks!
> 
> 2011/5/4 tsk <aixt2006@gmail.com>:
> > 2011/5/4 Wido den Hollander <wido@widodh.nl>:
> >> Hi,
> >>
> >> On Wed, 2011-05-04 at 17:37 +0800, tsk wrote:
> >>> Hi folks,
> >>>
> >>>
> >>> May I know that,  if there is 6 harddisk available for btrfs in just a
> >>> single host,  there should be 6 cosd process in the host when the
> >>> disks are all working?
> >>
> >> Yes, that is the way common way.
> >>
> >>>
> >>> A single cosd process can not manage several disks?
> >>>
> >>
> >> Yes and no. A single cosd process simply wants a mount point. If you
> >> look closer, the init script simply mounts the device specified by
> >> 'btrfs devs' in the configuration.
> >>
> >> You could run LVM, mdadm or even a btrfs multi-disk volume under a
> >> mountpoint, this way you could have on cosd process per disk.
> >>
> >> I would recommend running one cosd process per disk, it takes a bit more
> >> memory (about 800M per cosd), but this way Ceph can take the full
> >> advantage of all the available diskspace.
> >
> >
> > 800M or 80M?
> > There is 12 disks in my hosts, 1TB each. 10 disks of every host can be
> > used for ceph.
> > If one cosd per disk, there will be 10 cosd processes, which need a
> > lot lot of memory!
> >
> > I note that new cosd process takes 35M memory, but another cosd which
> > run 5 days takes 112M memory.  Hoping there is no memory leak.
> >
> >
> >> If you have multiple hosts I would recommend making a CRUSH map which
> >> makes sure your data replicas are not stored within the same physical
> >> machine: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
> >>
> >> The newer versions of Ceph will make a basic CRUSH map based on the
> >> ceph.conf, as far as I know it will prevent saving replicas on the same
> >> node. However, I would recommended checking your CRUSH map to make sure
> >> it does.
> >>
> >>> How should the ceph.conf be configured for this scenario?
> >>
> >> For example:
> >>
> >> [osd.0]
> >>   host = node01
> >>   btrfs devs = /dev/sda
> >>
> >> [osd.1]
> >>   host = node01
> >>   btrfs devs = /dev/sdb
> >>
> >> [osd.2]
> >>   host = node01
> >>   btrfs devs = /dev/sdc
> >>
> >> etc, etc
> >>
> >> The init script and mkcephfs will then format the specified drives with
> >> btrfs and mount it when the OSD starts.
> >>
> >> I would also recommend running your journal on a separate drive:
> >> http://ceph.newdream.net/wiki/Troubleshooting#Performance
> >>
> >> Wido
> >>
> >>>
> >>>
> >>> Thx!
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 


