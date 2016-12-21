From: Sage Weil <sage@newdream.net>
Subject: Re: Bug in mempool::map?
Date: Wed, 21 Dec 2016 21:43:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612212055110.10615@piezo.novalocal>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com> <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal> <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com> <alpine.DEB.2.11.1612201824140.10615@piezo.novalocal> <aa0fa487-ffed-cc4a-eae0-226ef038f1d4@mirantis.com>
 <alpine.DEB.2.11.1612202010280.10615@piezo.novalocal> <00754a82-e01d-09d8-f879-991c3faca025@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39095 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbcLUVwY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 16:52:24 -0500
In-Reply-To: <00754a82-e01d-09d8-f879-991c3faca025@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 21 Dec 2016, Igor Fedotov wrote:
> On 12/20/2016 11:15 PM, Sage Weil wrote:
> > It seems like we have a few common cases...
> > 
> > 1) big blob, single ref (e.g., immutable large object, and then the entire
> > thing is referenced, modulo the last block).
> > 
> > 2) tiny blob, single alloc unit.  a counter is sufficient.
> > 
> > 3) everything else in between...
> > 
> > We could probably get away with special-case efficient representations of
> > just 1 and 2?
> I'd say 1) = entire blob is referenced just once. And 2) = single alloc unit
> and partially referenced.
> 
> Then we need at minimum a bit flag for 1), 'int' for 2) and vector<int> for
> 3).
> 
> Possible implementations are
> A.{
> int standalone_counter;  //this covers 1 & 2, value greater than alloc unit
> means 1)
> vector<int> per_au_counters; // and this one for 3 with the first counter
> stored in standalone_counter
> }
> vs.
> B.{
> //reuse some blob flag for 1)
> vector<int> per_au_counters; //for 2) and 3)
> }
> vs.
> C.{
> vector<int> per_au_counters; //for all cases
> }
> 
> A. Saves one allocation for 1 & 2, wastes 4 bytes for 1. Plus requires some
> simple tricks to use both standalone counter and vector.
> B. Saves 1 allocation and 4 bytes for 1. Unified counter vector processing but
> some minor tricks with a flag.
> C. Needs +1 allocation for 1 & 2. And wastes 4 bytes for 1. Unified counter
> processing
> 
> I'd rather prefer B. implementation.

vector<int> is 24 bytes.  So if we're worried about memory, I think we 
want to have an alternative strategy.  Something like:

 uint8_t au_order;  ///< size of allocation unit (min_alloc_size may change)
 union {
   long *ref_by_au;  ///< dynamically allocated array of bytes per au
   long ref_in_single_au;  ///< refs if blob is a single au (au_order=0?)
 }

Something simple like that?

I suspect get_ref/put_ref will get quite a bit simpler and more efficient 
with per-au buckets.

Also, for compressed blobs, we can use the ref_in_single_au mode since we 
can't deallocate it piecewise anyway...

sage




