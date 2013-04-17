From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: test osd on zfs
Date: Thu, 18 Apr 2013 01:00:10 +0800
Message-ID: <CANExM-OJcBSTjTP7cqZqCMUHK9uKzWFNJd3_Xkq0qjCFFK6B7w@mail.gmail.com>
References: <516E7D5C.7080309@nazarianin.com>
	<alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
	<CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
	<516ECFB6.8090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:38958 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab3DQRAM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 13:00:12 -0400
Received: by mail-vc0-f177.google.com with SMTP id hr11so1521403vcb.36
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 10:00:11 -0700 (PDT)
In-Reply-To: <516ECFB6.8090107@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

getxattr linux man page says ERANGE will be returned if the size of
the value buffer is too small to hold the result. Thus, I think it is
a bug of ZFS (or ZOL, at least).

2013/4/18 Jeff Mitchell <jeffrey.mitchell@gmail.com>:
> Henry C Chang wrote:
>>
>> I looked into this problem earlier. The problem is that zfs does not
>> return ERANGE when the size of value buffer passed to getxattr is too
>> small. zfs returns with truncated xattr value.
>
>
> Is this a bug in ZFS, or simply different behavior?
>
> I've used ZFSonLinux quite a bit and they do seem to be very eager to fix
> bugs related to improper behavior, so if it's actually a bug I/someone can
> talk to them and try to get them to look at it soonish.
>
> --Jeff
>
