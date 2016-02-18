From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Thu, 18 Feb 2016 12:29:32 +0100
Message-ID: <2614739.NQCKcEKS6M@wuerfel>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com> <13047587.yVxNh7PhNK@wuerfel> <CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58403 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425268AbcBRL3l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 06:29:41 -0500
In-Reply-To: <CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

On Thursday 18 February 2016 01:35:25 Deepa Dinamani wrote:
> On Thu, Feb 18, 2016 at 1:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 17 February 2016 22:02:11 Deepa Dinamani wrote:
> >>
> >> I checked the server side code.
> >> So the server side also reads whatever is sent over wire as u32 and
> >> then assigns it to a time_t.
> >
> > I think the more important question is whether the server actually
> > does anything with the timestamp other than pass it back to the
> > client. If not, the interpretation it totally up to the client
> > and the type on the server has no meaning (as long as it can store
> > at least as many bits as the wire protocol, and passes all bits
> > back the same way).
> 
> Timestamps do get interpreted and written to on the server according to the
> files in the mds directory.

Ok. I see they are stored internally as a __u32/__u32 pair in "class utime_t",
I just couldn't figure out whether this is used on the server at all, or
stored in a timespec or time_t.

> >> Do you have any documentation about the wire protocol?
> >>
> >> To me, the wire protocol seems to have been designed to support only
> >> positive time values(u32).
> >
> > I think assigning to a time_t usually just means that this wasn't
> > completely thought through when it got implemented (which we already
> > know from the fact that it started out using a 32-bit number from
> > the time). It's totally possible that this code originated on a 32-bit
> > machine and was meant to encode a signed number and that the behavior
> > changed without anyone noticing when it got ported to a 64-bit
> > architecture for the first time.
> >
> >> This means ceph can represent times from 1970 - 2106 as long as both
> >> server and client are 64 bit machines.
> >> Or, client is 64 bit and server does not operate on time values.
> >> And, on 32 bit machines implementation will be broken in 2038.
> >
> >> I will change back the above code to not use any casts(as they are a
> >> no-op) as on the server side and note the above
> >> things in the file and changelog:
> >>
> >>  static inline void ceph_decode_timespec(struct timespec *ts,
> >>                                          const struct ceph_timespec *tv)
> >>  {
> >>  -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
> >>  -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
> >>  +       ts->tv_sec = le32_to_cpu(tv->tv_sec);
> >>  +       ts->tv_nsec = le32_to_cpu(tv->tv_nsec);
> >>   }
> >
> > Ok. I really like to have an explicit range-extension as well, but
> > as you say, your patch above does not change behavior.
> 
> You mean change the functions and data types on both sides?
> Not sure if this is meant for me or the Ceph team.

I meant it should be part of your patch.

	Arnd
