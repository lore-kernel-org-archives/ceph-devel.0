From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Fri, 25 Jan 2013 21:16:29 +0100
Message-ID: <CAF6-1L7HJMwqDPWwpkbqyTNbGbVhm_5pCbR73nTtnk0eD8xB4g@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
	<CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
	<CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
	<CAOLwVUm-LOStdMRNJeuA8qSzy2x3twMssBFA43J0MYVrFPNcbA@mail.gmail.com>
	<CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:50024 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3AYUXu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 15:23:50 -0500
Received: by mail-oa0-f51.google.com with SMTP id n12so953788oag.38
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 12:23:50 -0800 (PST)
In-Reply-To: <CAOLwVUmMCX_jHBc5Fqs_emT5E4ThoHd3nhUxmwhEJAZN4H3t9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> Could provide those heaps? Is it possible?

We're updating this weekend to 0.56.1.

If it still happens after the update, I'll try and reproduce it on our
test infra and do the profile there, because unfortunately running the
profiler seem to make it eat up CPU and RAM a lot ...

I also need to test is it happens when I force a scrub myself because
I can't let the profile run the whole day and just wait for it to
happen naturally, so I need a way to trigger a scrub of all PGs on a
given pool.


Cheers,

    Sylvain
