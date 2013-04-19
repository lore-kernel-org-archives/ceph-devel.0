From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: test osd on zfs
Date: Fri, 19 Apr 2013 06:47:24 -0400
Message-ID: <517120BC.8060205@gmail.com>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag> <516F0321.2@inktank.com> <516F10BE.6020103@llnl.gov> <38892EC8-F082-4AC4-8B6D-F8A541DBC7B7@profihost.ag> <alpine.DEB.2.00.1304180747200.626@cobra.newdream.net> <kkpjpj$vs5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:65188 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757487Ab3DSKr2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 06:47:28 -0400
Received: by mail-vb0-f45.google.com with SMTP id w15so3448997vbf.4
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 03:47:27 -0700 (PDT)
In-Reply-To: <kkpjpj$vs5$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

Alex Elsayed wrote:
> Since Btrfs has implemented raid5/6 support (meaning raidz is only a feature
> gain if you want 3x parity, which is unlikely to be useful for an OSD[1]),
> the checksumming may be the only real benefit since it supports sha256 (in
> addition to the non-cryptographic fletcher2/fletcher4), whereas btrfs only
> has crc32c at this time.

Plus (in my real-world experience) *far* better robustness. If Ceph 
could use either and both had feature parity, I'd choose ZFS in a 
heartbeat. I've had too many simple Btrfs filesystems go corrupt, not 
even using any fancy RAID features.

I wasn't aware that Ceph was using btrfs' file-scope clone command. ZFS 
doesn't have that, although in theory with the new capabilities system 
it could be supported in one implementation without requiring an on-disk 
format change.

--Jeff
