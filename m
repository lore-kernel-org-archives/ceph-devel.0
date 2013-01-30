From: Sage Weil <sage@inktank.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Wed, 30 Jan 2013 01:18:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301300116210.4449@cobra.newdream.net>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com> <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com> <CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
 <CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com> <CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com> <CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com> <alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net>
 <CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47713 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab3A3JSR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 04:18:17 -0500
In-Reply-To: <CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Jan 2013, Sylvain Munaut wrote:
> >> Just to keep you posted,  upgraded our cluster yesterday to a custom
> >> compiled 0.56.1 and it has now been more than 24h and there is no sign
> >> on memory leak anymore. Previously it would rise by ~ 100 M every 24h
> >> almost like clock work and now, it's been slightly more than 24h and
> >> memory is stable. (it fluctuates, but no large jumps that stay
> >> forever).
> >
> > That's great news.  We've been trying to replicate the argonaut leak here
> > on argonaut and haven't succeeded so far.
> 
> I'm sorry to report that my excitement was premature ...  it didn't
> grow during the first 24h but each day since then has seen a 100 M
> increase of OSD memory, so pretty much the same behavior as before.
> And again, happens when scrubbing PGs from the rbd pool.

Can you try disabling scrubbing and see if the leak stops?

	ceph osd tell \* injectargs '--osd-scrub-load-threshold .01'

(that will work for 0.56.1, but is fixed in later versions, btw.)  On 
newer code,

	ceph osd tell \* injectargs '--osd-scrub-min-interval 1000000'
	ceph osd tell \* injectargs '--osd-scrub-max-interval 10000000'

Tracking this via

	http://tracker.ceph.com/issues/3883

Thanks!
sage

