From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: subdir-objects
Date: Sat, 7 Sep 2013 20:36:11 -0400 (EDT)
Message-ID: <1692710180.24.1378600571331.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CA+Hcz58E7OKaGto0pF_ZYoge-FcDLtc66cbqx9a9+z-=Op3YWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1082 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab3IHAgQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 7 Sep 2013 20:36:16 -0400
In-Reply-To: <CA+Hcz58E7OKaGto0pF_ZYoge-FcDLtc66cbqx9a9+z-=Op3YWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Roald van Loon <roaldvanloon@gmail.com>

Thanks for doing this.  Also in the same interest of building Ceph faster, we've
been experimenting with a CMake translation of the current AM build.  I have no
idea yet if it will be any help ;).

Matt

----- "Noah Watkins" <noah.watkins@inktank.com> wrote:

> I'm so excited to have a refactored automake setup :)
> 
> I was just looking through build-refactor, and it doesn't really look
> like there is much that could be reused for the non-recrusive
> approach. I'll leave it up for a few days, just in case.
> 
> On Sat, Sep 7, 2013 at 1:11 PM, Roald van Loon
> <roaldvanloon@gmail.com> wrote:
> > On Sat, Sep 7, 2013 at 7:47 PM, Noah Watkins
> <noah.watkins@inktank.com> wrote:
> >> Oh, and one question about the non-recursive approach. If I stick
> a
> >> Makefile.am in the test/ directory I can do things like:
> >>
> >>   LDADD = all-the-test-dependencies
> >>
> >> and then avoid redundant per-target primaries like test_LDADD =
> (deps)
> >> $(LDADD), because it applies to everything in the Makefile.
> >>
> >> Is that possible with the include approach, or would a naked LDADD
> in
> >> an included Makefile fragment affect all the targets in the file
> >> including it?
> >
> > LDADD = xyz would indeed affect all targets. However, it's not
> > something you want to do anyway; using an _LDADD at a target is
> less
> > confusing and less prone to errors because you know exactly what
> > libraries a target needs.
> >
> > For instance, in test/Makefile.am you can have a debug target
> > depending on libglobal, which has dependencies set by libglobal
> > itself;
> >
> > CEPH_GLOBAL = $(LIBGLOBAL) $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS)
> $(EXTRALIBS)
> >
> > And then in test/Makefile.am;
> >
> > ceph_test_crypto_SOURCES = test/testcrypto.cc
> > ceph_test_crypto_LDADD = $(CEPH_GLOBAL)
> > bin_DEBUGPROGRAMS += ceph_test_crypto
> >
> > And a unittest also depending on libosd;
> >
> > unittest_pglog_SOURCES = test/osd/TestPGLog.cc
> > unittest_pglog_LDADD = $(LIBOSD) $(CEPH_GLOBAL)
> > check_PROGRAMS += unittest_pglog
> >
> > However, libosd requires libos and libosdc, but that dependency is
> set
> > by libosd;
> >
> > LIBOSD += $(LIBOSDC) $(LIBOS)
> >
> > This way, you have the dependencies in the right place. With
> recusive
> > builds you'll need an "LDADD = libosd.la libosdc.la libos.la
> > libglobal.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)", so
> > basically you're setting the dependencies of the required libraries
> in
> > the makefile requiring those libraries, which is IMHO way to
> complex.
> >
> >>> I think the benefits of using recursive builds are that it may be
> >>> familiar to the most people, it reflects the methods/suggestions
> in
> >>> the automake manual, and, most importantly, it would seem that its
> use
> >>> forces good decomposition where as a non-recursive approach relies
> on
> >>> guidelines that are easily broken.
> >
> > I don't know how which method is more familiar, but I personally
> think
> > that anyone understanding recursive automake is capable of
> > understanding a simple include :-)
> >
> > The decomposition is a valid argument. I think that there are some
> > libraries which might benefit from complete separation, like
> librados
> > and a "libceph_client" or something like it. Those can be
> separated,
> > but most other can't. The mon, mds, os, and osd subdirs have
> > inter-dependencies for instance.
> >
> > We might need to restructure the source tree anyway because at some
> > points it has grown messy (for instance, libcommon including stuff
> > from mds, mon but also from include). However, I think implementing
> a
> > recursive automake right now forces us to do two things at once;
> > cleanup the makefiles and do some restructuring in the subdirs. I
> > personally think it's best to start with cleaning up makefiles and
> use
> > an include per subdir, so we can restructure the subdirs into
> > segregated libraries later on.
> >
> > So I all boils down to; what to do first :-) Because I agree some
> > things are better of with recursive builds, but it might be wise
> not
> > to do that before we have revisited the source tree layout.
> >
> > Roald
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
