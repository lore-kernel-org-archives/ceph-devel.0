From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 12:37:10 -0400
Message-ID: <516ECFB6.8090107@gmail.com>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:43058 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3DQQhP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 12:37:15 -0400
Received: by mail-vc0-f181.google.com with SMTP id ia10so1506252vcb.12
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 09:37:14 -0700 (PDT)
In-Reply-To: <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

Henry C Chang wrote:
> I looked into this problem earlier. The problem is that zfs does not
> return ERANGE when the size of value buffer passed to getxattr is too
> small. zfs returns with truncated xattr value.

Is this a bug in ZFS, or simply different behavior?

I've used ZFSonLinux quite a bit and they do seem to be very eager to 
fix bugs related to improper behavior, so if it's actually a bug 
I/someone can talk to them and try to get them to look at it soonish.

--Jeff

