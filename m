From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Fri, 02 Dec 2011 17:24 +0100
Message-ID: <2356347.ajsbJfnmVK@pc10>
References: <4366451.BU1d1YAr76@pc10> <4ECFE472.9020603@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:47141 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757001Ab1LBQYI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Dec 2011 11:24:08 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id DE7F810C866
	for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2011 17:24:05 +0100 (CET)
In-Reply-To: <4ECFE472.9020603@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Am Freitag, 25. November 2011, 19:54:42 schrieb Wido den Hollander:
> Hi Guido,
> 
> On 11/25/2011 05:53 PM, Guido Winkelmann wrote:
> > Hi,
> > 
> > When trying to mount a Ceph filesystem with "mount.ceph 10.3.1.33:6789:/
> > /mnt", the command hangs for several minutes and then fails with the
> > message
> > 
> > mount error 5 = Input/output error
> 
> Does "ceph -s" work? If so, what is the output?

It works. This is the output:

# ceph -s
2011-11-28 18:51:32.018383    pg v60: 6 pgs: 6 active+clean+degraded; 0 KB 
data, 1292 KB used, 1750 GB / 1752 GB avail
2011-11-28 18:51:32.018610   mds e11: 1/1/1 up {0=alpha=up:creating}
2011-11-28 18:51:32.018698   osd e22: 1 osds: 1 up, 1 in
2011-11-28 18:51:32.018767   log 2011-11-28 18:50:16.299822 mon.0 
10.3.1.33:6789/0 3 : [INF] mds.? 10.3.1.33:6800/21218 up:boot
2011-11-28 18:51:32.018833   mon e1: 1 mons at {ceph1=10.3.1.33:6789/0}

> 
> > Background:
> > 
> > I'm trying to set up a small 3-machine Ceph cluster, to be used for
> > network- transparent block- and file storage for Qemu server
> > virtualization. This is the first time I'm doing anything at all with
> > Ceph, so many of the concepts are still new and a bit confusing to me.
> > 
> > My plan was to set up each of the three machines equally with one mon,
> > one osd and one mds, and to add more servers, or replace the existing
> > ones with bigger machines, as need arises.
> 
> If should be enough to have 3 OSD's and 1 MON and 1 MDS, for basic
> testing that is all you'd need.

Well as long as I have three machines, I might as well go for some more 
redundancy... No need to have the whole cluster fail just because the one node 
with the mon or mds daemon goes down.
 
[...]
> > - make&&  make install
> > - Copy src/init-ceph to /etc/init.d/
> > - Create /usr/local/etc/ceph/ceph.conf with this content:
> > 
> > [global]
> > 
> >          max open files = 131072
> >          log file = /var/log/ceph/$name.log
> >          log_to_syslog = true
> >          pid file = /var/run/ceph/$name.pid
> 
> You want to log to syslog and files simultaneously? That will cause
> double the I/O on that system.

Well, I've switched off the syslog part now.

> > [mon]
> > 
> >          mon data = /mondata/$name
> > 
> > [mon.ceph1]
> > 
> >          host = ceph1
> >          mon addr = 10.3.1.33:6789
> > 
> > [mds]
> > 
> >          keyring = /cephxdata/keyring.$name
> 
> Why did you specify a keyring here? You did not enable the cephx
> authentication.

I suppose I just forgot that particular part. It doesn't seem to make any 
difference though - I tried removing that line and restart ceph, it did not 
change anything.

At first, I tried starting with Cephx, but that let to other errors, so I 
disabled it to remove one variable when looking for the problem.
The biggest problem I still have with Cephx is lacking documentation. So far, 
the best I have found is some offhand mention in the "Cluster_configuration" 
page on the wiki and the man page to ceph-authtool. Maybe I've missed 
something, but so far, I haven't anything that really explains how this is 
supposed to work.

One thing in particular I don't get yet is why all example config files seem to 
give each component a different keyring file. As far as I understood the design, 
each client will have to connect directly to every component (mon/mds/osd) 
directly, so how can authentication still work if they each have their own 
keyring?
 
> > [mds.alpha]
> > 
> >          host = ceph1
> > 
> > [osd]
> > 
> >          osd data = /data/$name
> >          osd journal = /data/$name/journal
> >          osd journal size = 1000 ; journal size, in megabytes
> > 
> > [osd.0]
> > 
> >          host = ceph1
> >          btrfs devs = /dev/sda5 /dev/sdb5
> 
> Does that actually work? Never tested with specifying to devices. What
> are you trying to do? Create a striped filesystem?

Well, mostly I was just trying to use the storage space from both harddisks in 
this machine. Since the built-in multi-device capability of btrfs is one of 
the most advertised features, this looked like the logical solution to me.

It looks like it's working, too. btrfs-show shows me a filesystem with two 
devices, and twice the storage space of just one of them. The mounted 
filesystem under /data can be used like any other filesystem...

Would you say I should go about this differently?
 
> > (Slightly adjusted from src/sample.ceph.conf, comments removed for
> > brevity)
> > 
> > - Run mkcephfs -c /usr/local/etc/ceph/ceph.conf --mkbtrfs -a -k \
> > /usr/local/etc/ceph/keyring.bin
> > - Run /etc/init.d/ceph start
> > 
> > After these steps, I tried to mount the ceph filesystem (on the same
> > machine) with "mount.ceph 10.3.1.33:6789:/ /mnt" and got the
> > aforementioned error.
> Mounting the Ceph filesystem on the same host as where your OSD is
> running is not recommended. Although it should probably work, you could
> run into some trouble.

Really? That's the first I've heard of that, and it seems quite counter-
intuitive, too.

Anyway, I've tried mounting the ceph filesystem from a different host, and the 
result is exactly the same.

BTW, when I'm issuing the mount command, I can see these lines in dmesg:

libceph: client4602 fsid c8dd60a6-3dc7-6188-3f84-c58ff04f244a
libceph: mon0 10.3.1.33:6789 session established
 
> You could take a look at my ceph.conf: http://zooi.widodh.nl/ceph/ceph.conf
> 
> That might give you some more clues!

Hm, I'm afraid it doesn't. It's neat to see a working cluster with 10 storage 
nodes and IPv6, but it gives me no pointers as to why /my/ installation isn't 
working.

	Guido

