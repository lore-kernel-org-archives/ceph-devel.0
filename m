From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 10:34:20 -0400 (EDT)
Message-ID: <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to> <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com> <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:60161 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756500AbcHXOeV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 10:34:21 -0400
In-Reply-To: <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

Mark Nelson called attention to this topic again yesterday in #ceph-devel.

We favor retaining the ability to re-declare specific asserts such that they are, as with assert in general historically, compiled out.  I think it's reasonable if this is a marked case.

That seems to imply that if ceph_assert is the unmarked case, it won't be compiled out, so is essentially ceph_assert_always, as below (or else that form should be used...it's a little long).

Matt

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "John Spray" <jspray@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Monday, June 27, 2016 12:45:10 PM
> Subject: Re: assert
> 
> On Mon, 27 Jun 2016, John Spray wrote:
> > On Mon, Jun 27, 2016 at 5:16 PM, Sage Weil <sweil@redhat.com> wrote:
> > > We have a problem with assert.  Actually, a few problems.
> > >
> > > 1. Our code is written assuming that assert is never compiled out.  We
> > > have lots of assert(0) and assert(0 == "informative failure message")
> > > instances all over the code that should really be something like abort().
> > > If you compile out assert, things won't work (well, fail) as expected.
> > >
> > > 2. We have a special implementation of assert in include/assert.h that
> > > will log the assertion failure to the global debug log, along with a
> > > stack
> > > track, before crashing.  This is normally fine, except that lots of
> > > random
> > > library or system headers include the system assert
> > > (/usr/include/assert.h), which is written such that it does not lib
> > > nicely
> > > with another definition.  From /usr/include/assert.h:
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
> > > That means that if you include our assert, and then some other random
> > > header includes /usr/include/assert, it will (silently!) clobber ours.
> > >
> > > 3. This is all highlighted by the switch to cmake.  The current defautl
> > > build does not define NDEBUG, which means that assert is compiled away,
> > > and we get a bunch of unused variable warnings from code like
> > >
> > >   r = read(...);
> > >   assert(r > 0);
> > >
> > > So... what do to?  We can fix these instances when we find them, but the
> > > #include order is inherently fragile.
> > >
> > > Note that using the system assert isn't a total disaster: system assert
> > > will trigger an abort, which will trigger the SIGABRT handler which
> > > *also*
> > > dumps a stack trace to the debug log.  The problem is that it
> > > doesn't show the assertion condition and line number.
> > >
> > >
> > > I suggest:
> > >
> > > 0. Switch cmake to a debug but optimized build.  Ensure the release
> > > builds
> > > do the same.
> > >
> > > 1. Do an audit and replace assert(0) et al with ceph_abort(const char
> > > *msg), or similar.
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
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
