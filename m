From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: assert
Date: Mon, 27 Jun 2016 16:20:55 +0000
Message-ID: <CY1PR0201MB182065A6E2A8123D33D5A70985210@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:32416
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751905AbcF0Qx0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 12:53:26 -0400
In-Reply-To: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, June 27, 2016 9:47 PM
> To: ceph-devel@vger.kernel.org
> Subject: assert
>
> We have a problem with assert.  Actually, a few problems.
>
> 1. Our code is written assuming that assert is never compiled out.  We have
> lots of assert(0) and assert(0 == "informative failure message") instances all
> over the code that should really be something like abort().
> If you compile out assert, things won't work (well, fail) as expected.
>
> 2. We have a special implementation of assert in include/assert.h that will log
> the assertion failure to the global debug log, along with a stack track, before
> crashing.  This is normally fine, except that lots of random library or system
> headers include the system assert (/usr/include/assert.h), which is written
> such that it does not lib nicely with another definition.  From
> /usr/include/assert.h:
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
> 3. This is all highlighted by the switch to cmake.  The current defautl build
> does not define NDEBUG, which means that assert is compiled away, and we
> get a bunch of unused variable warnings from code like
>
>   r = read(...);
>   assert(r > 0);
>
> So... what do to?  We can fix these instances when we find them, but the
> #include order is inherently fragile.
>
> Note that using the system assert isn't a total disaster: system assert will
> trigger an abort, which will trigger the SIGABRT handler which *also* dumps a
> stack trace to the debug log.  The problem is that it doesn't show the
> assertion condition and line number.
>
>
> I suggest:
>
> 0. Switch cmake to a debug but optimized build.  Ensure the release builds do
> the same.
>
> 1. Do an audit and replace assert(0) et al with ceph_abort(const char *msg),
> or similar.
>
> 2. Replace all other instances of assert with ceph_assert.

I think doing this should be more simple and portable. Hide all details in ceph_assert.

>
> That's a lot of work, though.  Other ideas?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
