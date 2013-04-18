From: Sage Weil <sage@inktank.com>
Subject: Re: test osd on zfs
Date: Thu, 18 Apr 2013 07:50:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304180747200.626@cobra.newdream.net>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com>
 <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag>
 <516F0321.2@inktank.com> <516F10BE.6020103@llnl.gov> <38892EC8-F082-4AC4-8B6D-F8A541DBC7B7@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46007 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966390Ab3DROuW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 10:50:22 -0400
In-Reply-To: <38892EC8-F082-4AC4-8B6D-F8A541DBC7B7@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Brian Behlendorf <behlendorf1@llnl.gov>, Mark Nelson <mark.nelson@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 18 Apr 2013, Stefan Priebe - Profihost AG wrote:
> Am 17.04.2013 um 23:14 schrieb Brian Behlendorf <behlendorf1@llnl.gov>:
> 
> > On 04/17/2013 01:16 PM, Mark Nelson wrote:
> >> I'll let Brian talk about the virtues of ZFS,
> > 
> > I think the virtues of ZFS have been discussed at length in various other forums.  But in short it brings some nice functionality to the table which may be useful to ceph and that's worth exploring.
> Sure I know about the advantages of zfs.
> 
> I just thought about how ceph can benefit. Right now I've no idea. The 
> osds should be single disks so zpool, zraid does not matter. Ceph does 
> it own scrubbing and check summing and instead of btrfs ceph does not 
> know how to use snapshots with zfs. That's why I'm asking.

The main things that come to mind:

- zfs checksumming
- ceph can eventually use zfs snapshots similarly to how it uses btrfs 
  snapshots to create stable checkpoints as journal reference points, 
  allowing parallel (instead of writeahead) journaling
- can use raidz beneath a single ceph-osd for better reliability (e.g., 2x 
  * raidz instead of 3x replication)

ZFS doesn't have a clone function that we can use to enable efficient 
cephfs/rbd/rados snaps, but maybe this will motivate someone to implement 
one. :)

sage

