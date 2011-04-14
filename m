From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: It's not a bug of ceph, but
Date: Thu, 14 Apr 2011 10:08:29 -0700
Message-ID: <2B548686BA1D4CDD996A068F689C1B0A@gmail.com>
References: <4DA58180.7090701@ufm.su>
 <BANLkTim_rn4uzJSBp+oNVst7nYyVrU3Q=g@mail.gmail.com>
 <Pine.LNX.4.64.1104130922120.13408@cobra.newdream.net>
 <4DA5FA4C.7030205@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65369 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277Ab1DNRId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 13:08:33 -0400
Received: by iwn34 with SMTP id 34so1581472iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 10:08:33 -0700 (PDT)
In-Reply-To: <4DA5FA4C.7030205@ufm.su>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: Sage Weil <sage@newdream.net>, Henry Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On Wednesday, April 13, 2011 at 12:32 PM, Fyodor Ustinov wrote:
On this kernel (2.6.38-8-server ubuntu 11.04) i have trouble with ext4 also.
> 
> I mount fresh ceph partition on client, test by bonnie++, unmount, stop 
> ceph cluster, umount osd ext4 partition and forced fsck this partition.
> 
> Mount string on OSD:
> 
> /dev/md127 /mfs auto rw,noatime,nodiratime,async,noexec,nodev,user_xattr 0 0
> 
> No any messages in kernel log. But:
> 
> root@stc1:/home/ufm# umount /mfs
> root@stc1:/home/ufm# fsck /dev/md127
> fsck from util-linux-ng 2.17.2
> e2fsck 1.41.14 (22-Dec-2010)
> /dev/md127: clean, 29779/59834368 files, 3887821/239314496 blocks
> 
> root@stc1:/home/ufm# fsck -f /dev/md127
> fsck from util-linux-ng 2.17.2
> e2fsck 1.41.14 (22-Dec-2010)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 4456487, i_blocks is 8200, should be 8208. Fix<y>? yes
> 
> Inode 4456499, i_blocks is 8208, should be 8200. Fix<y>? yes
> 
> Inode 4456549, i_blocks is 24, should be 16. Fix<y>? yes
> 
> Inode 4456579, i_blocks is 24, should be 16. Fix<y>? yes
> 
> Inode 4456580, i_blocks is 8, should be 16. Fix<y>? yes
> 
> Inode 4456591, i_blocks is 8, should be 16. Fix<y>? yes
> 
> Inode 4456601, i_blocks is 24, should be 16. Fix<y>? /dev/md127: e2fsck 
> canceled.
> 
> /dev/md127: ***** FILE SYSTEM WAS MODIFIED *****
> 
> May be md. I test now without md.

So Ceph worked fine and you got no complaints until you ran fsck? That's odd but I don't think we've gotten any reports of data corruption or anything with Ceph on ext4. You should probably report this to the ext4 devs as Ceph doesn't do anything that should be able to break that stuff, but it does use some less-common code paths in a lot of filesystems.
-Greg




