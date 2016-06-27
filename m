From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: assert
Date: Mon, 27 Jun 2016 16:52:48 +0000
Message-ID: <BLUPR0201MB15248BD2EDB131BF28C23C7AE8210@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0075.outbound.protection.outlook.com ([157.56.110.75]:62144
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751764AbcF0Qw5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 12:52:57 -0400
In-Reply-To: <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I'm with John, converting the code is a bit tedious but low risk. It can be scripted.

I'd also like to see assert(0) replaced with more meaningful error messages. But not at the expense of delaying the conversion to cmake.


Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, June 27, 2016 9:45 AM
> To: John Spray <jspray@redhat.com>
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: assert
> 
> On Mon, 27 Jun 2016, John Spray wrote:
> > On Mon, Jun 27, 2016 at 5:16 PM, Sage Weil <sweil@redhat.com> wrote:
> > > We have a problem with assert.  Actually, a few problems.
> > >
> > > 1. Our code is written assuming that assert is never compiled out.
> > > We have lots of assert(0) and assert(0 == "informative failure
> > > message") instances all over the code that should really be something like
> abort().
> > > If you compile out assert, things won't work (well, fail) as expected.
> > >
> > > 2. We have a special implementation of assert in include/assert.h
> > > that will log the assertion failure to the global debug log, along
> > > with a stack track, before crashing.  This is normally fine, except
> > > that lots of random library or system headers include the system
> > > assert (/usr/include/assert.h), which is written such that it does
> > > not lib nicely with another definition.  From /usr/include/assert.h:
> > >
> > > #ifdef  _ASSERT_H
> > >
> > > # undef _ASSERT_H
> > > # undef assert
> > > # undef __ASSERT_VOID_CAST
> > >
> > > # ifdef __USE_GNU
> > > #  undef assert_perror
> > > # endif
> > >
> > > #endif /* assert.h      */
> > >
> > > #define _ASSERT_H       1
> > >
> > > That means that if you include our assert, and then some other
> > > random header includes /usr/include/assert, it will (silently!) clobber
> ours.
> > >
> > > 3. This is all highlighted by the switch to cmake.  The current
> > > defautl build does not define NDEBUG, which means that assert is
> > > compiled away, and we get a bunch of unused variable warnings from
> > > code like
> > >
> > >   r = read(...);
> > >   assert(r > 0);
> > >
> > > So... what do to?  We can fix these instances when we find them, but
> > > the #include order is inherently fragile.
> > >
> > > Note that using the system assert isn't a total disaster: system
> > > assert will trigger an abort, which will trigger the SIGABRT handler
> > > which *also* dumps a stack trace to the debug log.  The problem is
> > > that it doesn't show the assertion condition and line number.
> > >
> > >
> > > I suggest:
> > >
> > > 0. Switch cmake to a debug but optimized build.  Ensure the release
> > > builds do the same.
> > >
> > > 1. Do an audit and replace assert(0) et al with ceph_abort(const
> > > char *msg), or similar.
> >
> > Definitely support this: I find the assert(0)s kind of ugly anyway.
> >
> > > 2. Replace all other instances of assert with ceph_assert.
> >
> > Annoying but probably necessary.  assert() amongst other things bit me
> > recently when importing Python.h from Ceph code.
> >
> > > That's a lot of work, though.  Other ideas?
> >
> > Down the line from this, I would also like us to distinguish "high
> > level" asserts that indicate logical inconsistency rather than e.g.
> > malformed structures, so that we can dump even more info in these
> > cases (http://tracker.ceph.com/issues/11174).
> 
> That makes sense.  I have a related question too whether or not we want to
> make a distinction between asserts that we can compile out in a
> release/performance build and those we cannot.  For example, stuff in
> peering we would probably never want to compile out, and we are using
> assert only because it is a convenient shorthand for "if (!x) crash".
> 
> Maybe ceph_assert_always vs ceph_assert?
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
