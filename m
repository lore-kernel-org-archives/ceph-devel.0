From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 16:49:53 -0400
Message-ID: <CAOx6V3aLJkcwsK=B8UKVCZMjuYWE_W+U_LbCgMLWVK4BmzCt8w@mail.gmail.com>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
 <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
 <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com>
 <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com>
 <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com>
 <516EF34E.5000000@profihost.ag> <516F0321.2@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:47098 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966570Ab3DQUuP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 16:50:15 -0400
Received: by mail-ve0-f176.google.com with SMTP id cz11so1811414veb.7
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 13:50:14 -0700 (PDT)
In-Reply-To: <516F0321.2@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Brian Behlendorf <behlendorf1@llnl.gov>, Sage Weil <sage@inktank.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

> On 04/17/2013 02:09 PM, Stefan Priebe wrote:
>>
>> Sorry to disturb, but what is the raeson / advantage of using zfs for
>> ceph?

A few things off the top of my head:

1) Very mature filesystem with full xattr support (this bug
notwithstanding) and copy-on-write snapshots. While the port to Linux
sometimes has some rough edges (but in my experience over the past few
years is generally very good), the main code from Solaris (and now the
Illumos project) is well-tested and very well regarded. Btrfs has many
of the same features, but in my real-world experience I've had
multiple btrfs filesystems go corrupt with very innocuous usage
patterns and across a variety of kernel versions. The zfsonlinux bugs
don't tend to be data-destructive, once data is written to it.
2) Very intelligent caching; also supports external devices (like
SSDs) for a level 2 cache. This speeds up reads dramatically.
3) Very robust error-checking. There are lots of stories of ZFS
finding bad memory, bad controllers, and bad hard drives because of
its checksumming (which you can optionally turn off for speed). If you
set up the OSDs such that each OSD is based off of a ZFS mirror, you
get these benefits locally. For some people, especially when heavy on
reads (due to the intelligent caching), a solution that knocks the
remote replication level down by one but uses local mirrors for OSDs
may provide good functionality and safety compromises.

--Jeff
