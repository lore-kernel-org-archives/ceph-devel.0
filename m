From: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v3 1/4] buffer: add an aligned buffer with less alignment
 than a page
Date: Thu, 2 Oct 2014 14:09:44 +0200
Message-ID: <20141002120944.GM2542@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
 <1411994072-18850-2-git-send-email-j@jannau.net>
 <54295ADA.2040606@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:38148 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaJBMJs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 08:09:48 -0400
Content-Disposition: inline
In-Reply-To: <54295ADA.2040606@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On 2014-09-29 15:12:58 +0200, Loic Dachary wrote:
> 
> 
> On 29/09/2014 14:34, Janne Grunau wrote:
> > SIMD optimized erasure code computation needs aligned memory. Buffers
> > aligned to a page boundary are not needed though. The buffers used
> > for the erasure code computation are typical smaller than a page.
> > 
> > The typical alignment requirements SIMD operations are 16 bytes for
> > SSE2 and NEON and 32 bytes for AVX/AVX2.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  configure.ac         |   9 +++++
> >  src/common/buffer.cc | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/include/buffer.h |  15 ++++++++
> >  3 files changed, 130 insertions(+)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index cccf2d9..1bb27c4 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -793,6 +793,15 @@ AC_MSG_RESULT([no])
> >  ])
> >  
> >  #
> > +# Check for functions to provide aligned memory
> > +#
> > +AC_CHECK_HEADERS([malloc.h])
> > +AC_CHECK_FUNCS([posix_memalign _aligned_malloc memalign aligned_malloc],
> > +               [found_memalign=yes; break])
> > +
> > +AS_IF([test "x$found_memalign" != "xyes"], [AC_MSG_WARN([No function for aligned memory allocation found])])
> > +
> > +#
> >  # Check for pthread spinlock (depends on ACX_PTHREAD)
> >  #
> >  saved_LIBS="$LIBS"
> > diff --git a/src/common/buffer.cc b/src/common/buffer.cc
> > index af298ac..dfe887e 100644
> > --- a/src/common/buffer.cc
> > +++ b/src/common/buffer.cc
> > @@ -30,6 +30,10 @@
> >  #include <sys/uio.h>
> >  #include <limits.h>
> >  
> > +#ifdef HAVE_MALLOC_H
> > +#include <malloc.h>
> > +#endif
> > +
> >  namespace ceph {
> >  
> >  #ifdef BUFFER_DEBUG
> > @@ -155,9 +159,17 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
> >      virtual int zero_copy_to_fd(int fd, loff_t *offset) {
> >        return -ENOTSUP;
> >      }
> > +    virtual bool is_aligned(unsigned align) {
> > +      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
> > +      return ((intptr_t)data & (align - 1)) == 0;
> > +    }
> >      virtual bool is_page_aligned() {
> >        return ((long)data & ~CEPH_PAGE_MASK) == 0;
> >      }
> > +    bool is_n_align_sized(unsigned align) {
> > +      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
> 
> This does not seem necessary in this context ?

it is not strictly necessary but I would still consider it a bug if 
is_n_align_sized() is called with an align parameter that is not 
supported for allocating buffers.

Janne
