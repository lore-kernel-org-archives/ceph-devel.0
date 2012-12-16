From: Eric Renfro <erenfro@gmail.com>
Subject: CephFS, multiple nodes sharing 1 cephfs mount, Kernel NULL pointer
 dereference
Date: Sun, 16 Dec 2012 12:43:02 -0500
Message-ID: <50CE0826.4080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56825 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2LPRms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Dec 2012 12:42:48 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so978297ggd.19
        for <ceph-devel@vger.kernel.org>; Sun, 16 Dec 2012 09:42:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello.

I just recently started using Ceph FS, and by recommendation by the 
developers of it in the IRC channel, I decided to start off with 0.55, 
or rather whatever's closest to that in the latest git checkout from 
git's master on 12/12/2012.

So far, everything is good RBD-wise, very fast, in fact better than 
expected fast. But, I have found an issue in regards to CephFS in 
mounting it not through RBD, but from mount.ceph and ceph-fuse.

Before going into detail, I will explain the setup I have involved:

3 dedicated storage servers. Each with 1 120 GB SSD which is used for 
the OS to boot from, plus it holds partitions for XFS logdev journals of 
each of the spindle drives, and partitions for each of the Ceph OSD's, 
and the mon and mds partitions are used for storage as well. Each server 
has 3 spindle drives, which are, on each server, 1 1TB SATA3, 1 500GB 
SATA2, 1 320GB SATA2, and are setup with whole-disk XFS and mounted in 
their OSD locations.

What utilizes these are 4 hypervisor servers using Proxmox VE 2.2.

The network in use is currently 1 1Gb dedicated private network for just 
the storage network. LAN traffic has it's own network separately.

Here's the problem I'm having:

I run 2 webservers that prior to Ceph, I would use NFSv4 for their 
/var/www mount. These servers are load-balanced under LVS using 
pacemaker+ldirectord on 2 dedicated LVS director server VM's. The 
webservers themselves are freshly upgraded from Ubuntu 10.04 to 12.04 
(since the Ceph apt repos did not have lucid packages). I started off 
with the stable ceph repo, then switched to the unstable repo. Both of 
which had the same problem.

When I get Webserver 1 to "mount.ceph mon1:/web1 /var/www" it is VERY 
fast, in fact, I have external monitoring reporting on my server, and my 
access time from NFSv4 to CephFS got shorter, from averaging 740ms to 
610ms access time.

When I add Webserver 2 to the mount, using the same mount volume is when 
the trouble begins. Apache starts and locks up, even get a kernel 
message that apache2 has locked up for 120 seconds.

When I try to ls -lR /var/www from Webserver 2, it starts doing so, but 
locks up in the process. The only recovery for this is to shut down the 
VM entirely, which then starts spouting out kernel oops stack traces 
with ceph_d_prune+0x22/0x30 [ceph]

When I do the same with the Webserver 1, to make sure it's sane, it too 
causes a kernel oops stack trace when rebooting, but comes back up to 
normal when booted back up.

I took screenshots of the kernel stack dump and can send them if 
need-be. It's in 5 pieces due to the limits of the console viewer for 
Proxmox VE but it is complete.

I'm also on OFTC network's #ceph channel as Psi-Jack, to be able to 
discuss this during the times I am actively around.

Thank you,
Eric Renfro

