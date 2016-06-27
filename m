From: Sage Weil <sweil@redhat.com>
Subject: assert
Date: Mon, 27 Jun 2016 16:16:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbcF0QQx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 12:16:53 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 149DF3710C1
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 16:16:53 +0000 (UTC)
Received: from ovpn-112-100.phx2.redhat.com (ovpn-112-100.phx2.redhat.com [10.3.112.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5RGGp1Q014913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 12:16:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have a problem with assert.  Actually, a few problems.

1. Our code is written assuming that assert is never compiled out.  We 
have lots of assert(0) and assert(0 == "informative failure message") 
instances all over the code that should really be something like abort().  
If you compile out assert, things won't work (well, fail) as expected.

2. We have a special implementation of assert in include/assert.h that 
will log the assertion failure to the global debug log, along with a stack 
track, before crashing.  This is normally fine, except that lots of random 
library or system headers include the system assert 
(/usr/include/assert.h), which is written such that it does not lib nicely 
with another definition.  From /usr/include/assert.h:

#ifdef  _ASSERT_H

# undef _ASSERT_H
# undef assert
# undef __ASSERT_VOID_CAST

# ifdef __USE_GNU
#  undef assert_perror
# endif

#endif /* assert.h      */

#define _ASSERT_H       1

That means that if you include our assert, and then some other random 
header includes /usr/include/assert, it will (silently!) clobber ours.

3. This is all highlighted by the switch to cmake.  The current defautl 
build does not define NDEBUG, which means that assert is compiled away, 
and we get a bunch of unused variable warnings from code like

  r = read(...);
  assert(r > 0);

So... what do to?  We can fix these instances when we find them, but the 
#include order is inherently fragile.

Note that using the system assert isn't a total disaster: system assert 
will trigger an abort, which will trigger the SIGABRT handler which *also* 
dumps a stack trace to the debug log.  The problem is that it 
doesn't show the assertion condition and line number.


I suggest:

0. Switch cmake to a debug but optimized build.  Ensure the release builds 
do the same.

1. Do an audit and replace assert(0) et al with ceph_abort(const char 
*msg), or similar.

2. Replace all other instances of assert with ceph_assert.

That's a lot of work, though.  Other ideas?

sage
