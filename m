From: kefu chai <tchaikov@gmail.com>
Subject: Re: assert
Date: Tue, 28 Jun 2016 22:10:05 +0800
Message-ID: <CAJE9aOMghjY2H01sxD8Cf4Heuhjqi_QgQx53hHg-rT-vRnfi+w@mail.gmail.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34986 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcF1OQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 10:16:00 -0400
Received: by mail-qk0-f173.google.com with SMTP id a125so31297341qkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 07:15:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 12:16 AM, Sage Weil <sweil@redhat.com> wrote:
> We have a problem with assert.  Actually, a few problems.
>
> 1. Our code is written assuming that assert is never compiled out.  We
> have lots of assert(0) and assert(0 == "informative failure message")
> instances all over the code that should really be something like abort().
> If you compile out assert, things won't work (well, fail) as expected.
>
> 2. We have a special implementation of assert in include/assert.h that
> will log the assertion failure to the global debug log, along with a stack
> track, before crashing.  This is normally fine, except that lots of random
> library or system headers include the system assert
> (/usr/include/assert.h), which is written such that it does not lib nicely
> with another definition.  From /usr/include/assert.h:
>
> #ifdef  _ASSERT_H
>
> # undef _ASSERT_H
> # undef assert
> # undef __ASSERT_VOID_CAST
>
> # ifdef __USE_GNU
> #  undef assert_perror
> # endif
>
> #endif /* assert.h      */
>
> #define _ASSERT_H       1
>
> That means that if you include our assert, and then some other random
> header includes /usr/include/assert, it will (silently!) clobber ours.
>
> 3. This is all highlighted by the switch to cmake.  The current defautl
> build does not define NDEBUG, which means that assert is compiled away,
> and we get a bunch of unused variable warnings from code like
>
>   r = read(...);
>   assert(r > 0);
>
> So... what do to?  We can fix these instances when we find them, but the
> #include order is inherently fragile.
>
> Note that using the system assert isn't a total disaster: system assert
> will trigger an abort, which will trigger the SIGABRT handler which *also*
> dumps a stack trace to the debug log.  The problem is that it
> doesn't show the assertion condition and line number.
>
>
> I suggest:
>
> 0. Switch cmake to a debug but optimized build.  Ensure the release builds
> do the same.

yeah, we do need this. some of the tests are actually using assert()
as ASSERT_TRUE().
i posted a PR for it: https://github.com/ceph/ceph/pull/9975.

>
> 1. Do an audit and replace assert(0) et al with ceph_abort(const char
> *msg), or similar.
>
> 2. Replace all other instances of assert with ceph_assert.
>
> That's a lot of work, though.  Other ideas?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
