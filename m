From: Sage Weil <sweil@redhat.com>
Subject: mempools everywhere
Date: Tue, 18 Oct 2016 16:52:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757192AbcJRQwZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Oct 2016 12:52:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: allen.samuels@sandisk.com

The mempool PR is more or less ready for final test/merge.  Once it's in 
place we'd love to use this all over the place so that we can tell 
where memory is going.  There's one major remaining roadblock, though: 
right now mempool is part of libglobal since it has global state (the 
mempools themselves).  This prevents us from putting anything in, say, 
osd_types.h (which is included in client code) in a mempool.  Which 
includes things like pg_log_t, a major consumer of memory.

We have a few options...

- Segregate types into different compilation units so that things that are 
server-side only can be built separately (and put in mempools).

- Just avoid these types :(

- Use mempools for client code as well.

The last one is the most appealing to me, but it's violating a big no-no 
of shared libraries (static state!).  However, I think that mempools may 
be one of those special things that all of the usual reasons that global 
variables are bad don't really apply to.  The main one being: if we have 
multiple users of, say, librados in the same process, it is totally fine 
(and possibly desired?) that they would share the same mempools.

What do you think?

FWIW, there is one bit of potentially shady initialization going on with 
the mempools.  Instead of statically defining the pools, we instead 
declare an array of pool pointers, and rely on the compiler and runtime 
environment to zero that for the process *before* any constructors are run 
for any compilation unit.  This allows pools to be allocated on-demand 
when needed by constructors in any compilation unit, regardless of the 
link order relative to mempool.cc.  This appears to be a safe thing to do 
(and avoids the very tedious process of ensuring that mempool.cc is always 
linked first so that it's ctors run first).

If we want to take the plunge and make this usable by librados and other 
client code, I think it may just work, modulo leaking the pool_t 
structures if the .so is ever unloaded (not sure any librados user does 
this?).  In that case, we could probably move the setup/teardown into the 
init/fini .so methods, although we'd need to confirm that these would run 
*before* any constructors for statically linked modules.

Anyway.. thoughts?

sage
