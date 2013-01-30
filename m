From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Wed, 30 Jan 2013 14:26:06 +0100
Message-ID: <CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
	<CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
	<CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
	<CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
	<CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com>
	<CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com>
	<CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com>
	<alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net>
	<CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com>
	<alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48067 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3A3N0H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 08:26:07 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so1605523obb.17
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 05:26:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,


> Can you try disabling scrubbing and see if the leak stops?
>
>         ceph osd tell \* injectargs '--osd-scrub-load-threshold .01'
>
> (that will work for 0.56.1, but is fixed in later versions, btw.)  On
> newer code,
>
>         ceph osd tell \* injectargs '--osd-scrub-min-interval 1000000'
>         ceph osd tell \* injectargs '--osd-scrub-max-interval 10000000'

Ok, I just did that.
(I have 0.56.1 + a few more patches from the bobtail branch (up to
c5fe0965572c07... )

I'll report back tomorrow.


> Tracking this via
>
>         http://tracker.ceph.com/issues/3883

Should I post the updates on the ML or on the ticket ?

Cheers,

   Sylvain
