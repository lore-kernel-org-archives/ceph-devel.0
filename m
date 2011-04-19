From: Sage Weil <sage@newdream.net>
Subject: Re: Logging
Date: Tue, 19 Apr 2011 09:27:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104190921350.3238@cobra.newdream.net>
References: <4DAB77FD.4010804@provocation.net> <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
 <4DAC0EE7.4080001@provocation.net> <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
 <4DAC8021.6000701@provocation.net> <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
 <4DACA57E.2040609@provocation.net> <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com>
 <4DACD304.4010000@provocation.net> <Pine.LNX.4.64.1104182154160.13931@cobra.newdream.net>
 <4DAD6FCD.5070105@provocation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47001 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1DSQYL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 12:24:11 -0400
In-Reply-To: <4DAD6FCD.5070105@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

> > This is really interesting.  This is on the partitions that have _just_ 
> > the OSD data? 
> 
> Yes, with a couple of extra layers. node01 keeps its OSD data on an ext4
> filesystem on top of a dm-crypt encrypted native disk partition. node02
> on the other hand has an mdadm RAID0 of two partitions on separate disks
> with dm-crypt and ext4 on top of that. This layering - in particular the
> encryption - consumes CPU and can slow down things, but for the rest it's
> rock-solid; I've been running systems with these setups for years and
> never had a problem with them even once.
> 
> Here's an example from this morning:
> 
> node01:
> /dev/mapper/sda6        232003      5914    212830   3% /mnt/osd
> 
> node02:
> /dev/mapper/md4         225716      5704    207112   3% /mnt/osd
> 
> client:
> 192.168.178.100:6789:/
>                         232002      5913    212829   3% /mnt/n01

Oh... I suspect that only one of the OSDs is active.  The ceph client's 
df/statfs result is really just a sum over the statfs results on all of 
the OSDs.  The fact that is corresponds to node01 suggests that node02 
isn't part of the cluster.  Can you post the output from

	ceph osd dump -o -

> At this point I unmounted ceph on the client and restarted ceph. A few minutes
> later I see this:
> 
> node01:
> /dev/mapper/sda6        232003      5907    212837   3% /mnt/osd
> 
> node02:
> /dev/mapper/md4         225716      5626    207190   3% /mnt/osd
> 
> Note how disk usage went down on both nodes, considerably on node02.
> 
> Then they start exchanging data and an hour later or so they're back in sync:
> 
> node01:
> /dev/mapper/sda6        232003      5906    212838   3% /mnt/osd
> 
> node02:
> /dev/mapper/md4         225716      5906    206910   3% /mnt/osd

I wouldn't read into the disk utilizations too closely.  There is logging 
going on at a couple of different levels that can make the utilization 
fluctuate depending on the timing of trimming.

> > Do you see any OSD flapping (down/up cycles) during this 
> > period?
> 
> I've been running without logs since yesterday, but my experience is that
> they don't flap; once an OSD goes down it stays down until ceph is restarted.

Also, one thing you should do during these tests is keep a 

	ceph -w

running to monitor changes in the cluster state (to see, for example, if 
it's marking either osd down).

Thanks!
sage
