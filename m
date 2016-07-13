From: Sage Weil <sweil@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Wed, 13 Jul 2016 16:05:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607131459370.30974@piezo.us.to>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com> <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1607121658240.497@piezo.us.to> <0b770e1d-5b3a-b9d1-175c-ccec29ee1737@redhat.com>
 <20160713063300.GA32333@predictor>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-342998219-1468425965=:30974"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcGMQGN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jul 2016 12:06:13 -0400
In-Reply-To: <20160713063300.GA32333@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>
Cc: Mark Nelson <mnelson@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-342998219-1468425965=:30974
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Jul 2016, Piotr Dałek wrote:
> On Tue, Jul 12, 2016 at 10:13:14PM -0500, Mark Nelson wrote:
> > 
> > 
> > On 07/12/2016 08:50 PM, Sage Weil wrote:
> > >On Tue, 12 Jul 2016, Allen Samuels wrote:
> > >>[..]
> > >>I believe we need to revisit the idea of custom encode/decode paths for
> > >>high-usage cases, only now the gains need to be focused on CPU
> > >>utilization as well as space efficiency.
> > >
> > >I still think we can get most or all of the way there in a generic way by
> > >revising the way that we interact with bufferlist for encode and decode.
> > >We haven't actually tried to optimize this yet, and the current code is
> > >pretty horribly inefficient (asserts all over the place, and many layers
> > >of pointer indirection to do a simple append).  I think we need to do two
> > >things:
> > >
> > >1) decode path: optimize the iterator class so that it has a const char
> > >*current and const char *current_end that point into the current
> > >buffer::ptr.  This way any decode will have a single pointer
> > >add+comparison to ensure there is enough data to copy before falling into
> > >the slow path (partial buffer, move to next buffer, etc.).
> > 
> > I don't have a good sense yet for how much this is hurting us in the
> > read path.  We screwed something up in the last couple of weeks and
> > small reads are quite slow.
> 
> The main issue with decode using bufferlist is that we cannot assume
> anything regarding internal data memory layout. We can't do anything like
> 
>  int j = *((int*) bufferptr.c_str());
> 
> because bufferptr may be too short for "j" to be read in one go.
> Possible solution would be to ensure that bufferptrs contain contiguous
> blocks large enough to store one unit of data (be it, for example, onode
> info).
> 
> > >2) Having that comparison is still not ideal, but we shoudl consider ways
> > >to get around that too.  For example, if we know that we are going to
> > >decode N M-byte things, we could do an iterator 'reserve' or 'check' that
> > >ensures we have a valid pointer for that much and then proceed without
> > >checks.  The interface here would be tricky, though, since in the slow
> > >case we'll span buffers and need to magically fall back to a different
> > >decode path (hard to maintain) or do a temporary copy (probably faster but
> > >we need to ensure the iterator owns it and frees is later).  I'd say this
> > >is step 2 and optional; step 1 will have the most benefit.
> 
> Exactly my point.
> Regarding a copy, we could just do something like rebuild_contiguous() and
> make sure bufferlist is a one, large bufferptr or it is split on logical
> data unit boundary instead of random places that are messenger/underyling
> I/O store dependent. That will take care of both memory ownership and
> bufferlist continuity.

In practice, it is pretty much always contiguous: msgr allocates a whole 
chunk, and when we read stuff off disk or out of kv store it is one chunk.  
Pretty much the only time it isn't is when you just encoded it... and we 
generaly don't decode in that case.

Anyway, the point is that we can do something pretty simple and 
non-optimal in the non-contiguous case (like rebuild()) and it 
shouldn't really matter.

> > >3) encode path: currently all encode methods take a bufferlist& and the
> > >bufferlist itself as an append buffer.  I think this is flawed and
> > >limiting.  Instead, we should make a new class called
> > >buffer::list::appender (or similar) and templatize the encode methods so
> > >they can take a safe_appender (which does bounds checking) or an
> > >unsafe_appender (which does not).  For the latter, the user takes
> > >responsibility for making sure there is enough space by doing a reserve()
> > >type call which returns an unsafe_appender, and it's their job to make
> > >sure they don't shove too much data into it.  That should make the encode
> > >path a memcpy + ptr increment (for savvy/optimized callers).
> > 
> > Seems reasonable and similar in performance to what Piotr and I were
> > discussing this morning.  As a very simple test I was thinking of
> > doing a quick size computation and then passing that in to increase
> > the append_buffer size when the bufferlist is created in
> > Bluestore::_txc_write_nodes.  His idea went a bit farther to break
> > the encapsulation, compute the fully encoded message, and dump it
> > directly into a buffer of a computed size without the extra assert
> > checks or bounds checking.  Obviously his idea would be faster but
> > more work.
> > 
> > It sounds like your solution would be similar but a bit more formalized.
> 
> I like the idea, because that way we could add extra checks to debug builds
> (added via preprocessor define) and have the ability to find bugs easier,
> retaining performance on release/optimized builds.
> Or we could go that way all-in, have single kind of appender and do bounds
> check only on debug builds.

Yeah--I'd go for debug asserts that compile out of release builds.  (We 
should either create a new assert macro, or go do teh work to change 
current assert()'s to ceph_assert_always() or whatever.)

> > >I suggest we use bluestore as a test case to make the interfaces work and
> > >be fast.  If we succeed we can take advantage of it across the reset of
> > >the code base as well.
> > 
> > Do we have other places in the code with similar byte append
> > behavior? That's what's really killing us I think, especially with
> > how small the new append_buffer is when you run out of space when
> > appending bytes.
> 
> I still recommend doing a dry bench and measure how fast _txc_write_nodes
> is. We may be spending a lot of time optimizing bufferlist API, when the
> real issue lies in another place. Creation and destruction of bufferlist is
> one of my point of concerns in _txc_write_nodes, but then, I have no clue on
> how many times that happen per entire call.
> If the following
> 
>    // (KeyValueDB::Transaction t, set<OnodeRef>::iterator p)
>    t->set(PREFIX_OBJ, (*p)->key, bl);
> 
> performs synchronously (i.e. doesn't do anything else with bl contents after
> leaving t->set call), we could just rewind bl and start overwriting it. In
> worst case, we would alloc extra memory, which is still one case out of 3
> possible (remaining being new onode/bnode of the same or smaller sizes
> than previous one).

Almost certain it does make a copy of the buffer.  Maybe a bufferlist 
method that clears ptr list but keeps one of them as the append buffer if 
it has no more references.  clear_keep_append() or something.

sage
--8323329-342998219-1468425965=:30974--
