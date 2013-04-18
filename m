From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: test osd on zfs
Date: Thu, 18 Apr 2013 13:07:18 -0700
Message-ID: <kkpjpj$vs5$1@ger.gmane.org>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag> <516F0321.2@inktank.com> <516F10BE.6020103@llnl.gov> <38892EC8-F082-4AC4-8B6D-F8A541DBC7B7@profihost.ag> <alpine.DEB.2.00.1304180747200.626@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34853 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936525Ab3DRUH2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Apr 2013 16:07:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USv79-0007ul-6v
	for ceph-devel@vger.kernel.org; Thu, 18 Apr 2013 22:07:27 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 22:07:27 +0200
Received: from eternaleye by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 22:07:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

<snip>
> The main things that come to mind:
> 
> - zfs checksumming
> - ceph can eventually use zfs snapshots similarly to how it uses btrfs
>   snapshots to create stable checkpoints as journal reference points,
>   allowing parallel (instead of writeahead) journaling
> - can use raidz beneath a single ceph-osd for better reliability (e.g., 2x
>   * raidz instead of 3x replication)
> 
> ZFS doesn't have a clone function that we can use to enable efficient
> cephfs/rbd/rados snaps, but maybe this will motivate someone to implement
> one. :)

Since Btrfs has implemented raid5/6 support (meaning raidz is only a feature 
gain if you want 3x parity, which is unlikely to be useful for an OSD[1]), 
the checksumming may be the only real benefit since it supports sha256 (in 
addition to the non-cryptographic fletcher2/fletcher4), whereas btrfs only 
has crc32c at this time.

[1] A raidz3 with 4 disks is basically raid1, at which point you may as well 
use Ceph-level replication. And a 5-or-more-disk OSD strikes me as a 
questionable way to set it up, considering Ceph's strengths.

