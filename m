From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 20:38:35 +0100
Message-ID: <56A679BB.4090801@digiware.nl>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
 <56A5E61E.80705@digiware.nl>
 <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
 <56A5FF84.8080107@digiware.nl>
 <20160125172252.GA2818@ultraspiritum.redhat.com>
 <56A66099.4030501@digiware.nl>
 <1523354716.24670379.1453744826329.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:44639 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933480AbcAYTjH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 14:39:07 -0500
In-Reply-To: <1523354716.24670379.1453744826329.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On 25-1-2016 19:00, Matt Benjamin wrote:
> Hi Willem,
> 
> This commit is by Adam.
Hi Matt,

Sorry about that, I'll send my personal remaks agin to him.

The point you raise here is a more generic question:
 -- How to wrap OS specifics into more generic code?

Sometimes overloading would be usefull. But in this case the function is
exactly oke, only the names of const values differ, and as such that
will not work. So a ceph::clock_gettime() would still have the same
problem.
Alternative is make different functions, but that would a lot of
functions, just to work around the naming.

> I have in OTHER PROJECTS mapped Linux CLOCK_MONOTONIC_COARSE to
> FreeBSD's CLOCK_MONOTONIC_FAST, but that's it.  In my Ceph code, I've
> been using clock_gettime() explicitly, but also
> CLOCK_MONOTONIC_COARSE, on the expectation to have this change in
> future.

'mmm sort of lost on what part of the code I then triggered and ended up
commenting on your code..

1)
Currently the code in Adam's looks like:
#if defined(CLOCK_MONOTONIC_COARSE)
        // Linux systems have _COARSE clocks.
        clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
#elif defined(CLOCK_MONOTONIC_FAST)
        // BSD systems have _FAST clocks.
        clock_gettime(CLOCK_MONOTONIC_FAST, &ts);
#else
        // And if we find neither, you may wish to consult your system's
        // documentation.
#warning Falling back to CLOCK_MONOTONIC, may be slow.
        clock_gettime(CLOCK_MONOTONIC, &ts);
#endif

And this is repeated in a few more locations.
Moreover, it will be required to do that a few times everytime
clock_getime is used.

Perhaps Matt solution is crude, but more convenient, which I think went
like:
#if defined(__FreeBSD__)
#define CLOCK_MONOTONIC_COARSE CLOCK_MONOTONIC_FAST
#endif
I keeps the code looking very Linux like, which works for this case.
But there could very well be that there is more difference than just
nameing, and tricky details of the implementation could bite.
It would also not work when there is more that just a nameing difference.

Put this in the compat.h or ceph_time.h file and this can tackle this
specific problem

> If you think the clock definition should be different, please suggest
> corrections (but again, I'm not the author of this proposed change).

I'm at the middle of the road of which version I like best.
The first one is 100% clear and obvious, but also very verbose.
The second one shines in elegance, but is not very transparent value wise.

If the second solution was put in ceph_time.h I think that that would
have my preference

--WjW

