From: Sage Weil <sage@inktank.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Sun, 27 Jan 2013 09:47:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com> <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com> <CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
 <CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com> <CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com> <CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43015 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab3A0RrC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jan 2013 12:47:02 -0500
In-Reply-To: <CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 27 Jan 2013, Sylvain Munaut wrote:
> Hi,
> 
> Just to keep you posted,  upgraded our cluster yesterday to a custom
> compiled 0.56.1 and it has now been more than 24h and there is no sign
> on memory leak anymore. Previously it would rise by ~ 100 M every 24h
> almost like clock work and now, it's been slightly more than 24h and
> memory is stable. (it fluctuates, but no large jumps that stay
> forever).

That's great news.  We've been trying to replicate the argonaut leak here 
on argonaut and haven't succeeded so far.

sage
