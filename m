From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Don't understand why space usage keeps growing
Date: Tue, 14 Jun 2011 10:30:05 -0700
Message-ID: <F635901F-428A-4CE4-B478-085234F80281@dreamhost.com>
References: <BANLkTiny=PO5eq=ok_ad6T94YfAK-Tk=CA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57309 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1FNRaG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2011 13:30:06 -0400
In-Reply-To: <BANLkTiny=PO5eq=ok_ad6T94YfAK-Tk=CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Jun 11, 2011, at 4:24 PM, Wilfrid Allembrand wrote:

> Hi,
> 
> So I have my small test cluster with 2 OSD nodes. In each OSD node,
> there is one disk (5 GB) and one cosd.
> When I mount the FS on a client, I see it's 10 GB in total. Fine.
> I copied a small set of multimedia files (135 MB) and that's all. So
> why do I see the space used is getting higher and higher ?
> 
> root@client:/mnt/osd$ df -h .
> Filesystem            Size  Used Avail Use% Mounted on
> 10.1.56.232:6789:/     10G  5.2G  3.9G  57% /mnt/osd
> 
> and like 2 hours later :
> 
> root@client:/mnt/osd$ df -h .
> Filesystem            Size  Used Avail Use% Mounted on
> 10.1.56.232:6789:/     10G  6.8G  2.3G  76% /mnt/osd
> 
> 
> I'm using btrfs to store the files and I made no creation/modification
> of files; i just run some bench with "ceph osd tell [12] bench"
> Does the bench create files and do note delete them ?
The OSD bench that you're invoking definitely does delete files. You shouldn't be seeing large growth like that with your ceph.conf, though.

Are you sure there's nothing else accessing your mount and doing writes to it? What I'd expect to see from 135MB of writes is ~570MB used (135MB written on each OSD, for the replication, doubled because you've got a 512MB journal recording the data too; and then plus a little bit extra for the MDS journaling and data).

You're not using the rados bench, are you? That one doesn't clean up after itself.


> 
> Extract of ceph -w :
> root@test2:/data/mon1# ceph -w
> 2011-06-11 19:16:09.186416 7fbefd01e700 -- :/14931 >>
> 10.1.56.233:6789/0 pipe(0x1e58540 sd=4 pgs=0 cs=0 l=0).fault first
> fault
> 2011-06-11 19:16:12.191439    pg v1990: 594 pgs: 594 active+clean;
> 2066 MB data, 6906 MB used, 2286 MB / 10240 MB avail
> 2011-06-11 19:16:12.193479   mds e48: 1/1/1 up {0=test4=up:active}, 1 up:standby
> 2011-06-11 19:16:12.193551   osd e44: 2 osds: 2 up, 2 in
> 2011-06-11 19:16:12.193658   log 2011-06-12 00:55:42.389017 osd2
> 10.1.56.237:6800/1744 307 : [INF] bench: wrote 1024 MB in blocks of
> 4096 KB in 12.438478 sec at 84300 KB/sec
> 2011-06-11 19:16:12.193757   mon e1: 3 mons at
> {0=10.1.56.231:6789/0,1=10.1.56.232:6789/0,2=10.1.56.233:6789/0}
> 
> 
> Attached is my ceph.conf
> 
> Thanks !
> Wilfrid
> <ceph.conf>

