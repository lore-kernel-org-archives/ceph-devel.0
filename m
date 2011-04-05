From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Question about librados
Date: Tue, 5 Apr 2011 09:57:59 -0700
Message-ID: <20110405165759.GA1710@dreamer>
References: <incab7$gnn$1@dough.gmane.org>
 <BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
 <inedo0$3v2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51285 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab1DEQ6C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 12:58:02 -0400
Content-Disposition: inline
In-Reply-To: <inedo0$3v2$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Tue, Apr 05, 2011 at 08:44:15AM +0200, Rutger ter Borg wrote:
> >>I'm in the progress of evaluating librados as an object store. I'm using
> >>Debian's latest packages as of today, and noted that I need to define
> >>NO_ATOMIC_OPS to get something compiled that includes librados.hpp.
> >Hmmm, that's not right! Can you elaborate? It just doesn't build
> >librados.hpp unless you define NO_ATOMIC_OPS? Is there a build error
> >at some point?
> thanks for the elaborate answer! With respect to the compile error,
> I got this in an empty file with just including rados/librados.hpp
> 
> $ g++ ./rados.cpp
> In file included from /usr/include/rados/buffer.h:55:0,
>                  from /usr/include/rados/librados.hpp:10,
>                  from ./rados.cpp:6:
> /usr/include/rados/atomic.h:25:24: fatal error: atomic_ops.h: No
> such file or directory
> 
> compilation terminated.

Ahhh, now I got it. You're not trying to compile Ceph, you're trying
to build software using librados.

The problem here is that whatever our autoconf setup detects, and
whatever libraries it decides to use, might not be available at the
time the external software using librados is compiles. That is, Ceph
compilation environment is different from the end user compilation
environment.

And, even more so, we don't use the autoconfig results at all in the
include files; nothing defines __CEPH__ in this case.

     18 #ifdef __CEPH__
     19 # include "acconfig.h"
     20 #endif

So when atomic.h says:

     23 #ifndef NO_ATOMIC_OPS
     24 //libatomic_ops implementation
     25 #include <atomic_ops.h>
     26 namespace ceph {
     27 

Yup, that'll fail if you don't have atomic-ops development libraries
available.

And even if it compiles, there's no quarantee it works right! Because
what if the actual Ceph compilation really was *without* atomic-ops.

I need to file a few more bug reports next, but after that I'll look
into this more and try to come up with a better recommendation.

Short term, your best bet is to try to match the environment where the
Deb was compiled; install the packages listed on the Build-Depends
line at
http://ceph.newdream.net/git/?p=ceph.git;a=blob;f=debian/control;hb=HEAD
-- you can do that quickly with "sudo apt-get build-dep ceph"

-- 
:(){ :|:&};:
