From: Alex Elder <elder@inktank.com>
Subject: Re: CephFS, multiple nodes sharing 1 cephfs mount, Kernel NULL pointer
 dereference
Date: Mon, 17 Dec 2012 10:40:24 -0600
Message-ID: <50CF4AF8.7080805@inktank.com>
References: <50CE0826.4080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46652 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab2LQQkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 11:40:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9586636ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 08:40:22 -0800 (PST)
In-Reply-To: <50CE0826.4080909@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Renfro <erenfro@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

On 12/16/2012 11:43 AM, Eric Renfro wrote:
> Hello.
> 
> I just recently started using Ceph FS, and by recommendation by the
> developers of it in the IRC channel, I decided to start off with 0.55,
> or rather whatever's closest to that in the latest git checkout from
> git's master on 12/12/2012.
> 
> So far, everything is good RBD-wise, very fast, in fact better than
> expected fast. But, I have found an issue in regards to CephFS in
> mounting it not through RBD, but from mount.ceph and ceph-fuse.
> 
> Before going into detail, I will explain the setup I have involved:

Eric posted images of the stack dumps he had to IRC.  For the record,
they are here (the log info they cover overlaps a bit):

    http://i.imgur.com/saC2e.png
    http://i.imgur.com/uuiqO.png
    http://i.imgur.com/YHJqN.png
    http://i.imgur.com/vR8Tj.png
    http://i.imgur.com/a2TDm.png

The problem is a null pointer dereference occurring at
ceph_d_prune+0x22, and that correlates to this line:

        di = ceph_dentry(dentry->d_parent);

The problem is that dentry->d_parent is a null pointer.
This condition passed the two tests before:

        if (IS_ROOT(dentry))
Which is
    #define IS_ROOT(x) ((x) == (x)->d_parent)
So not true, x is a valid pointer, d_parent is null.

        if (d_unhashed(dentry))
Which expands to
        return !dentry->d_hash.pprev;
which suggests it appeared to be a hashed dentry.


I don't have any more information about the particular dentry.
But somehow a dentry with a null d_parent pointer is found under
a ceph file system's sb->root tree (I suspect it's the root
dentry itself).

The problem still exists in the ceph kernel client as of
version 3.6.10.

					-Alex



> 3 dedicated storage servers. Each with 1 120 GB SSD which is used for
> the OS to boot from, plus it holds partitions for XFS logdev journals of
> each of the spindle drives, and partitions for each of the Ceph OSD's,
> and the mon and mds partitions are used for storage as well. Each server
> has 3 spindle drives, which are, on each server, 1 1TB SATA3, 1 500GB
> SATA2, 1 320GB SATA2, and are setup with whole-disk XFS and mounted in
> their OSD locations.
> 
> What utilizes these are 4 hypervisor servers using Proxmox VE 2.2.
> 
> The network in use is currently 1 1Gb dedicated private network for just
> the storage network. LAN traffic has it's own network separately.
> 
> Here's the problem I'm having:
> 
> I run 2 webservers that prior to Ceph, I would use NFSv4 for their
> /var/www mount. These servers are load-balanced under LVS using
> pacemaker+ldirectord on 2 dedicated LVS director server VM's. The
> webservers themselves are freshly upgraded from Ubuntu 10.04 to 12.04
> (since the Ceph apt repos did not have lucid packages). I started off
> with the stable ceph repo, then switched to the unstable repo. Both of
> which had the same problem.
> 
> When I get Webserver 1 to "mount.ceph mon1:/web1 /var/www" it is VERY
> fast, in fact, I have external monitoring reporting on my server, and my
> access time from NFSv4 to CephFS got shorter, from averaging 740ms to
> 610ms access time.
> 
> When I add Webserver 2 to the mount, using the same mount volume is when
> the trouble begins. Apache starts and locks up, even get a kernel
> message that apache2 has locked up for 120 seconds.
> 
> When I try to ls -lR /var/www from Webserver 2, it starts doing so, but
> locks up in the process. The only recovery for this is to shut down the
> VM entirely, which then starts spouting out kernel oops stack traces
> with ceph_d_prune+0x22/0x30 [ceph]
> 
> When I do the same with the Webserver 1, to make sure it's sane, it too
> causes a kernel oops stack trace when rebooting, but comes back up to
> normal when booted back up.
> 
> I took screenshots of the kernel stack dump and can send them if
> need-be. It's in 5 pieces due to the limits of the console viewer for
> Proxmox VE but it is complete.
> 
> I'm also on OFTC network's #ceph channel as Psi-Jack, to be able to
> discuss this during the times I am actively around.
> 
> Thank you,
> Eric Renfro
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

