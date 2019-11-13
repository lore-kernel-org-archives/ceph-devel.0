From: David Howells <dhowells@redhat.com>
Subject: FS-Cache/CacheFiles rewrite
Date: Wed, 13 Nov 2019 17:55:20 +0000
Message-ID: <24942.1573667720@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-ID: <24941.1573667720.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <sfrench@samba.org>, Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve Dickson <steved@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, v9fs-developer@lists.sourceforge.net, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-cachefs@redhat.com, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I've been rewriting the local cache for network filesystems with the aim of
simplifying it, speeding it up, reducing its memory overhead and making it
more understandable and easier to debug.

For the moment fscache support is disabled in all network filesystems that
were using, apart from afs.

To this end, I have so far made the following changes to fscache:

 (1) The fscache_cookie_def struct has gone, along with all the callback
     functions it used to contain.  The filesystem stores the auxiliary dat=
a
     and file size into the cookie and these are written back lazily (possi=
bly
     too lazily at the moment).  Any necessary information is passed in to
     fscache_acquire_cookie().

 (2) The object state machine has been removed and replaced by a much simpl=
er
     dispatcher that runs the entire cookie instantiation procedure, cookie
     teardown procedure or cache object withdrawal procedure in one go with=
out
     breaking it down into cancellable/abortable states.

     To avoid latency issues, a thread pool is created to which these
     operations will be handed off if any threads are idle; if no threads a=
re
     idle, the operation is run in the process that triggered it.

 (3) The entire I/O API has been deleted and replaced with one that *only*
     provides a "read cache to iter" function and a "write iter to cache"
     function.  The cache therefore neither knows nor cares where netfs pag=
es
     are - and indeed, reads and writes don't need to go to such places.

 (4) The netfs must allow the cache the opportunity to 'shape' a read from =
the
     server, both from ->readpages() and from ->write_begin(), so that the
     size and start of the read are of a suitably aligned for the cache
     granularity.  Cachefiles is currently using a 256KiB granule size.

     A helper is provided to do most of the work: fscache_read_helper().

 (5) An additional layer, an fscache_io_handle, has been interposed in the =
I/O
     API that allows the cache to store transient stuff, such as the open f=
ile
     struct pointer to the backing file for the duration of the netfs file
     being open.

     I'm tempted on one hand to merge this into the fscache_object struct a=
nd
     on the other hand to use this to get rid of 'cookie enablement' and al=
low
     already open files to be connected to the cache.

 (6) The PG_fscache bit is now set on a page to indicate that the page is
     being written to the cache and cleared upon completion.  write_begin,
     page_mkwrite, releasepage, invalidatepage, etc. can wait on this.

 (7) Cookie removal now read-locks the semaphore that is used to manage
     addition and removal of a cache.  This greatly simplifies the logic in
     detaching an object from a cookie and cleaning it up as relinquishment
     and withdrawal can't then happen simultaneously.

     It does mean, though, that cookie relinquishment is held up by cache
     removal.

And the following changes to cachefiles:

 (1) The I/O code has been replaced.  The page waitqueue snooping and defer=
red
     backing-page to netfs-page copy is now entirely gone and asynchronous
     direct I/O through kiocbs is now used instead to effect the transfer o=
f
     data to/from the cache.

     This affords a speed increase of something like 40-50% and reduces the
     amount of memory that is pinned during I/O.

 (2) bmap() is no longer used to detect the presence of blocks in the
     filesystem.  With a modern extent based filesystem, this may give both
     false positives and false negatives if the filesystem optimises an ext=
ent
     by eliminating a block of zeros or adds a block to bridge between two
     close neighbours.

     Instead, a content map is stored in an xattr on the backing file, with=
 1
     bit per 256KiB block.  The cache shapes the netfs's read requests to
     request multiple-of-256KiB reads from the server, which are then writt=
en
     back.

 (3) The content map and attributes are then stored lazily when the object =
is
     destroyed.  This may be too lazy.

To aid this I've added the following:

 (1) Wait/wake functions for the PG_fscache bit.

 (2) ITER_MAPPING iterator that refers to a contiguous sequence of pinned
     pages with no holes in a mapping.  This means you don't have to alloca=
te
     a sequence of bio_vecs to represent the same thing.

     As stated, the pages *must* be pinned - such as by PG_locked,
     PG_writeback or PG_fscache - before iov_iter_mapping() is called to se=
t
     the mapping up.

Things that still need doing:

 (1) afs (and any other netfs) needs to write changes to the cache at the s=
ame
     time it writes them to the server so that the cache doesn't get out of
     sync.  This is also necessary to implement write-back caching and
     disconnected operation.

 (2) The content map is limited by the maximum xattr size.  Is it possible =
to
     configure the backing filesystem so that it doesn't merge extents acro=
ss
     certain boundaries or eliminate blocks of zeros so that I don't need a
     content map?

 (3) Use O_TMPFILE in the cache to effect immediate invalidation.  I/O can
     then continue to progress whilst the cache driver replaces the linkage=
.

 (4) The file in the cache needs to be truncated if the netfs file is
     shortened by truncation.

 (5) Data insertion into the cache is not currently checked for space
     availability.

 (6) The stats need going over.  Some of them are obsolete and there are no
     I/O stats working at the moment.

 (7) Replacement I/O tracepoints are required.

Future changes:

 (1) Get rid of cookie enablement.

 (2) Frame the limit on the cache capacity in terms of an amount of data th=
at
     can be stored in it rather than an amount of free space that must be
     kept.

 (3) Move culling out of cachefilesd into the kernel.

 (4) Use the I/O handle to add caching to files that are already open, perh=
aps
     listing I/O handles from the cache tag.

Questions:

 (*) Does it make sense to actually permit multiple caches?

 (*) Do we want to allow multiple filesystem instances (think NFS) to use t=
he
     same cache objects?  fscache no longer knows about the netfs state, an=
d
     the netfs now just reads and writes to the cache, so it's kind of
     possible - but coherency management is tricky and would definitely be =
up
     to the netfs.

The patches can be found here:

=09https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dfscache-iter

I'm not going to post them for the moment unless someone really wants that.

David
