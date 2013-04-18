From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: test osd on zfs
Date: Thu, 18 Apr 2013 07:56:34 +0200
Message-ID: <38892EC8-F082-4AC4-8B6D-F8A541DBC7B7@profihost.ag>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag> <516F0321.2@inktank.com> <516F10BE.6020103@llnl.gov>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:53734 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab3DRF4k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 01:56:40 -0400
In-Reply-To: <516F10BE.6020103@llnl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Behlendorf <behlendorf1@llnl.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 17.04.2013 um 23:14 schrieb Brian Behlendorf <behlendorf1@llnl.gov>:

> On 04/17/2013 01:16 PM, Mark Nelson wrote:
>> I'll let Brian talk about the virtues of ZFS,
> 
> I think the virtues of ZFS have been discussed at length in various other forums.  But in short it brings some nice functionality to the table which may be useful to ceph and that's worth exploring.
Sure I know about the advantages of zfs.

I just thought about how ceph can benefit. Right now I've no idea. The osds should be single disks so zpool, zraid does not matter. Ceph does it own scrubbing and check summing and instead of btrfs ceph does not know how to use snapshots with zfs. That's why I'm asking.

Greets,
Stefan