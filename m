From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: OSD::mkfs: couldn't mount FileStore: error -22
Date: Mon, 15 Oct 2012 21:35:02 +1000
Message-ID: <k5gsd6$e0b$1@ger.gmane.org>
References: <k5dqro$s4d$1@ger.gmane.org> <507B2E71.4040706@inktank.com> <k5fha7$h3l$1@ger.gmane.org> <alpine.DEB.2.00.1210142044060.3424@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51365 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab2JOLfR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Oct 2012 07:35:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TNix7-0004Y5-4W
	for ceph-devel@vger.kernel.org; Mon, 15 Oct 2012 13:35:21 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 13:35:21 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 13:35:21 +0200
In-Reply-To: <alpine.DEB.2.00.1210142044060.3424@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> current/ is a btrfs subvolume.. 'btrfs sub delete current' will remove it.

Ah, that worked, thanks.  Unfortunately mkcephfs still fails with the same error.

> The warning in the previous email suggets you're running a fairly old
> kernel.. there is probably something handled incorrectly during the fs
> init process.  Exactly which kernel are you running?

2.6.32 - apparently the latest in Debian stable.  I figured this was workable 
since ceph.com offers packages for Debian stable.

> In any case, btrfs isn't going to work particularly well on something that
> old; I suggest running something newer (3.5 or 3.6) or switching to XFS.

Ok fair enough.  I'll have to see how practical it is to get a more recent 
kernel going, otherwise I'll go down the XFS route.

Thanks again,
Adam.


