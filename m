From: Sage Weil <sage@inktank.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 10:00:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304170957280.30041@cobra.newdream.net>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34597 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146Ab3DQRAb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 13:00:31 -0400
In-Reply-To: <516ECFB6.8090107@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: behlendorf1@llnl.gov, Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

Adding Brian Behlendorf to the CC list, as we were just talking about this 
yesterday at LUG.  :)

I suspect this is a bug; the posix docs indicate ERANGE is apprpriate 
here:

     [ERANGE]		value (as indicated by size) is too small to hold the
			extended attribute data.

from http://www.unix.com/man-page/all/2/GETXATTR/.

sage


On Wed, 17 Apr 2013, Jeff Mitchell wrote:
> Henry C Chang wrote:
> > I looked into this problem earlier. The problem is that zfs does not
> > return ERANGE when the size of value buffer passed to getxattr is too
> > small. zfs returns with truncated xattr value.
> 
> Is this a bug in ZFS, or simply different behavior?
> 
> I've used ZFSonLinux quite a bit and they do seem to be very eager to fix bugs
> related to improper behavior, so if it's actually a bug I/someone can talk to
> them and try to get them to look at it soonish.
> 
> --Jeff
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
