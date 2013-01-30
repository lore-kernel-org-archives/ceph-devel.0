From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Wed, 30 Jan 2013 10:12:12 +0100
Message-ID: <CAF6-1L76dwdxGp2MGJTWFF4VwmzMT3a62tSTZhE8P1b-OOSBuw@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
	<CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
	<CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
	<CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
	<CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com>
	<CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com>
	<CAF6-1L4SfogRx0=46A8YR4dW1f-qOLNSh-7mT9HS_NKz9CjCZQ@mail.gmail.com>
	<alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39709 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab3A3JMN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 04:12:13 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so1409742oag.20
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 01:12:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301270946190.16117@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

>> Just to keep you posted,  upgraded our cluster yesterday to a custom
>> compiled 0.56.1 and it has now been more than 24h and there is no sign
>> on memory leak anymore. Previously it would rise by ~ 100 M every 24h
>> almost like clock work and now, it's been slightly more than 24h and
>> memory is stable. (it fluctuates, but no large jumps that stay
>> forever).
>
> That's great news.  We've been trying to replicate the argonaut leak here
> on argonaut and haven't succeeded so far.

I'm sorry to report that my excitement was premature ...  it didn't
grow during the first 24h but each day since then has seen a 100 M
increase of OSD memory, so pretty much the same behavior as before.
And again, happens when scrubbing PGs from the rbd pool.


:(

Cheers,

    Sylvain
