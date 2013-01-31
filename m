From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Thu, 31 Jan 2013 14:20:16 +0100
Message-ID: <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com>
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
	<CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com>
	<alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:38062 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3AaNUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 08:20:17 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so2940641oag.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 05:20:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I disabled scrubbing using

> ceph osd tell \* injectargs '--osd-scrub-min-interval 1000000'
> ceph osd tell \* injectargs '--osd-scrub-max-interval 10000000'

and the leak seems to be gone.

See the graph at  http://i.imgur.com/A0KmVot.png  with the OSD memory
for the 12 osd processes over the last 3.5 days.
Memory was rising every 24h. I did the change yesterday around 13h00
and OSDs stopped growing. OSD memory even seems to go down slowly by
small blocks.

Of course I assume disabling scrubbing is not a long term solution and
I should re-enable it ... (how do I do that btw ? what were the
default values for those parameters)

Cheers,

   Sylvain
