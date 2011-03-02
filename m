From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] configure.ac: Fix up --with-profiler test
Date: Wed, 2 Mar 2011 13:09:35 -0700
Message-ID: <1299096575.4750.24.camel@sale659.sandia.gov>
References: <1299095521-20220-1-git-send-email-jaschut@sandia.gov>
 <AANLkTimsChcqrjzvYJc7bSb9o8XP5gEv6OYOyJa-E3jD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:52155 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab1CBUJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 15:09:49 -0500
In-Reply-To: <AANLkTimsChcqrjzvYJc7bSb9o8XP5gEv6OYOyJa-E3jD@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 13:01 -0700, Colin McCabe wrote:
> Hmm. Does this handle --without-profiler correctly?

Well, it does on my RHEL 5 box.  I don't have
the profiler library, and when the default build
failed for me, I tried --without-profiler, and
that failed too.

With this patch, all of --with-profiler, --with-profiler=no,
--without-profiler work as expected, given that I don't
have the library.

FWIW my autoconf version on that system is 2.59.

-- Jim


> 
> I have a vague memory that you need to check "withval" to do that...
> (As with most of the other automake memories, I'm trying to repress it.)
> 
> cheers,
> Colin
> 
> 
> On Wed, Mar 2, 2011 at 11:52 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > According to http://www.gnu.org/software/autoconf/manual/autoconf.html,
> > the <action-if-given> test for AC_ARG_WITH is done if either of
> > --with-package or --without-package is on the configure line.
> > The <action-if-not-given> is done if neither is present on
> > the command line.
> >
> > This commit causes both --without-profiler and --with-profiler=no
> > to work correctly.  It also allows a default configure/build
> > (i.e. --with-profiler not specified) to work correctly on a system
> > that does not have the appropriate profiling library.
> >
> > Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> > ---
> >  configure.ac |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index c76f605..9357a47 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -37,9 +37,9 @@ PKG_CHECK_MODULES([CRYPTOPP], [libcrypto++], [], [
> >  # profiler?
> >  AC_ARG_WITH([profiler],
> >             [AS_HELP_STRING([--with-profiler], [build extra profiler binaries])],
> > -           [with_profiler=yes],
> > +           [],
> >             [with_profiler=no])
> > -AS_IF([test "x$with_profiler" != xyes],
> > +AS_IF([test "x$with_profiler" != xno],
> >            [AC_CHECK_LIB([profiler], [ProfilerFlush], [],
> >                          [AC_MSG_FAILURE([--with-profiler was given but libprofiler (libgoogle-perftools-dev on debian) not found])])],
> >            [])
> > --
> > 1.6.6
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


