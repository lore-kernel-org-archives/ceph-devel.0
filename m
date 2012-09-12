From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 6/6] build: provide libleveldb as a shared library
Date: Wed, 12 Sep 2012 09:38:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209120935540.5196@cobra.newdream.net>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de> <1347416527-19752-7-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48986 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758910Ab2ILQif (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 12:38:35 -0400
In-Reply-To: <1347416527-19752-7-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org

On Wed, 12 Sep 2012, Jan Engelhardt wrote:
> The library is used by ceph (main repo), and code share is a good
> thing, is it not?

I'm not sure making this a .so has much value in this case.  We can link 
against an installed libleveldb (and the upstream debian package does 
that).  It's present here to make build painless in other environments, 
and to get the libleveldb unit test stuff coverage in our automated 
builds.  Linking it statically to ceph-osd in that case makes sense.  I 
wouldn't want this to interfere at all with an installed libleveldb.so... 
would it?

The other patches look good, thanks!  I'd be particularly happy to see if 
similar cleanups are possible with the ceph Makefile.am.. :)

sage

> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  .gitignore    |    6 +++++-
>  Makefile.am   |   10 ++++++----
>  configure.ac  |    4 +++-
>  m4/.gitignore |    2 ++
>  4 files changed, 16 insertions(+), 6 deletions(-)
>  create mode 100644 m4/.gitignore
> 
> diff --git a/.gitignore b/.gitignore
> index bf40c93..972e902 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -7,14 +7,18 @@
>  /configure
>  
>  # created by ./configure
> -/.deps/
> +.deps/
> +.libs/
>  /Makefile
>  /config.h
>  /config.log
>  /config.status
> +/libtool
>  /stamp-h1
>  
>  # created by make
> +*.la
> +*.lo
>  *.o
>  *.a
>  /TAGS
> diff --git a/Makefile.am b/Makefile.am
> index 19b52a8..1d62bad 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -9,15 +9,15 @@ OPT ?= -O2 -DNDEBUG       # (A) Production use (optimized mode)
>  
>  # TODO maybe support android & chromium platforms via automake too?
>  
> +ACLOCAL_AMFLAGS = -I m4
>  AM_CFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
>  
>  AM_CXXFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
>  if CSTDATOMIC
>  AM_CXXFLAGS += -DLEVELDB_CSTDATOMIC_PRESENT -std=c++0x
>  endif
> -AM_LDFLAGS = -pthread
>  
> -LDADD = libleveldb.a
> +LDADD = libleveldb.la
>  if WITH_TCMALLOC
>  LDADD += -ltcmalloc
>  endif
> @@ -30,7 +30,7 @@ check_PROGRAMS = $(TESTS)
>  # target by target
>  TESTS =
>  
> -noinst_LIBRARIES = libleveldb.a
> +lib_LTLIBRARIES = libleveldb.la
>  noinst_HEADERS = \
>  	util/random.h \
>  	util/coding.h \
> @@ -86,7 +86,7 @@ noinst_HEADERS = \
>  	db/log_reader.h \
>  	db/version_edit.h
>  
> -libleveldb_a_SOURCES = \
> +libleveldb_la_SOURCES = \
>  	db/builder.cc \
>  	db/c.cc \
>  	db/db_impl.cc \
> @@ -123,6 +123,8 @@ libleveldb_a_SOURCES = \
>  	util/options.cc \
>  	util/status.cc
>  
> +libleveldb_la_LIBADD = -lpthread
> +
>  TESTUTIL = util/testutil.cc
>  TESTHARNESS = util/testharness.cc $(TESTUTIL)
>  
> diff --git a/configure.ac b/configure.ac
> index 6a26ab9..6b29da4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,5 +1,6 @@
>  AC_INIT([leveldb], [0.1], [leveldb@googlegroups.com])
>  AC_CONFIG_AUX_DIR([build-aux])
> +AC_CONFIG_MACRO_DIR([m4])
>  AM_INIT_AUTOMAKE([-Wall -Werror foreign])
>  m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])
>  AC_PROG_CC
> @@ -10,7 +11,8 @@ AC_CONFIG_FILES([
>    Makefile
>  ])
>  m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
> -AC_PROG_RANLIB
> +AC_DISABLE_STATIC
> +AC_PROG_LIBTOOL
>  
>  AC_MSG_CHECKING(whether compiler supports C++11 cstdatomic)
>  OLD_CXXFLAGS="$CXXFLAGS"
> diff --git a/m4/.gitignore b/m4/.gitignore
> new file mode 100644
> index 0000000..64d9bbc
> --- /dev/null
> +++ b/m4/.gitignore
> @@ -0,0 +1,2 @@
> +/libtool.m4
> +/lt*.m4
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
