From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: KeyFileStore ?
Date: Thu, 31 Jul 2014 17:49:48 +1200
Message-ID: <53D9D8FC.4070505@catalyst.net.nz>
References: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:45874 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaGaFx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 01:53:56 -0400
In-Reply-To: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 31/07/14 17:25, Sage Weil wrote:
> After the latest set of bug fixes to the FileStore file naming code I am
> newly inspired to replace it with something less complex.  Right now I'm
> mostly thinking about HDDs, although some of this may map well onto hybrid
> SSD/HDD as well.  It may or may not make sense for pure flash.
>
> Anyway, here are the main flaws with the overall approach that FileStore
> uses:
>
> - It tries to maintain a direct mapping of object names to file names.
> This is problematic because of 255 character limits, rados namespaces, pg
> prefixes, and the pg directory hashing we do to allow efficient split, for
> starters.  It is also problematic because we often want to do things like
> rename but can't make it happen atomically in combination with the rest of
> our transaction.
>
> - The PG directory hashing (that we do to allow efficient split) can have
> a big impact on performance, particularly when injesting lots of data.
> (And when benchmarking.)  It's also complex.
>
> - We often overwrite or replace entire objects.  These are "easy"
> operations to do safely without doing complete data journaling, but the
> current design is not conducive to doing anything clever (and it's complex
> enough that I wouldn't want to add any cleverness on top).
>
> - Objects may contain only key/value data, but we still have to create an
> inode for them and look that up first.  This only matters for some
> workloads (rgw indexes, cephfs directory objects).
>
> Instead, I think we should try a hybrid approach that more heavily
> leverages a key/value db in combination with the file system.  The kv db
> might be leveldb, rocksdb, LMDB, BDB, or whatever else; for now we just
> assume it provides transactional key/value storage and efficient range
> operations.  Here's the basic idea:
>
> - The mapping from names to object lives in the kv db.  The object
> metadata is in a structure we can call an "onode" to avoid confusing it
> with the inodes in the backing file system.  The mapping is simple
> ghobject_t -> onode map; there is no PG collection.  The PG collection
> still exist but really only as ranges of those keys.  We will need to be
> slightly clever with the coll_t to distinguish between "bare" PGs (that
> live in this flat mapping) and the other collections (*_temp and
> metadata), but that should be easy.  This makes PG splitting "free" as far
> as the objects go.
>
> - The onodes are relatively small.  They will contain the xattrs and
> basic metadata like object size.  They will also identify the file name of
> the backing file in the file system (if size > 0).
>
> - The backing file can be a random, short file name.  We can just make a
> one or two level deep set of directories, and let the directories get
> reasonably big... whatever we decide the backing fs can handle
> efficiently.  We can also store a file handle in the onode and use the
> open by handle API; this should let us go directly from onode (in our kv
> db) to the on-disk inode without looking at the directory at all, and fall
> back to using the actual file name only if that fails for some reason
> (say, someone mucked around with the backing files).  The backing file
> need not have any xattrs on it at all (except perhaps some simple id to
> verify it does it fact belong to the referring onode, just as a sanity
> check).
>
> - The name -> onode mapping can live in a disjunct part of the kv
> namespace so that the other kv stuff associated with the file (like omap
> pairs or big xattrs or whatever) don't blow up those parts of the
> db and slow down lookup.
>
> - We can keep a simple LRU of recent onodes in memory and avoid the kv
> lookup for hot objects.
>
> - Previously complicated operations like rename are now trivial: we just
> update the kv db with a transaction.  The backing file never gets renamed,
> ever, and the other object omap data is keyed by a unique (onode) id, not
> the name.
>
> Initially, for simplicity, we can start with the existing data journaling
> behavior.  However, I think there are opportunities to improve the
> situation there.  There is a pending wip-transactions branch in which I
> started to rejigger the ObjectStore::Transaction interface a bit so that
> you identify objects by handle and then operation on them.  Although it
> doesn't change the encoding yet, once it does, we can make the
> implementation take advantage of that, by avoid duplicate name lookups.
> It will also let us do things like clearly identify when an object is
> entirely new; in that case, we might forgo data journaling and instead
> write the data to the (new) file, fsync, and then commit the journal entry
> with the transaction that uses it.  (On remount a simple cleanup process
> can throw out new but unreferenced backing files.)  It would also make it
> easier to track all recently touched files and bulk fsync them instead of
> doing a syncfs (if we decide that is faster).
>
> Anyway, at the end of the day, small writes or overwrites would still be
> journaled, but large writes or large new objects would not, which would (I
> think) be a pretty big improvement.  Overall, I think the design will be
> much simpler to reason about, and there are several potential avenues to
> be clever and make improvements.  I'm not sure we can say the same about
> the FileStore design, which suffers from the fact that it has evolved
> slowly over the last 9 years or so.
>

Certainly makes sense to me - I can recall thinking "that stuff is 
actually a database" when looking at the on disk filestore object data 
layout.

regards

Mark

