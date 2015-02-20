From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: NewStore update
Date: Fri, 20 Feb 2015 18:01:44 +0800
Message-ID: <CACJqLyaYOoMhWKnARwH6afYYCuwXMtK7Fw8W7kmo=rZ1Nn+fGg@mail.gmail.com>
References: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36373 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbbBTKBp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 05:01:45 -0500
Received: by pdjp10 with SMTP id p10so6625902pdj.3
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 02:01:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

So cool!

A little notes:

1. What about sync thread in NewStore?
2. Could we consider skipping WAL for large overwrite(backfill, RGW)?
3. Sorry, what means [aio_]fsync?


On Fri, Feb 20, 2015 at 7:50 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi everyone,
>
> We talked a bit about the proposed "KeyFile" backend a couple months back.
> I've started putting together a basic implementation and wanted to give
> people and update about what things are currently looking like.  We're
> calling it NewStore for now unless/until someone comes up with a better
> name (KeyFileStore is way too confusing). (*)
>
> You can peruse the incomplete code at
>
>         https://github.com/liewegas/ceph/tree/wip-newstore/src/os/newstore
>
> This is a bit of a brain dump.  Please ask questions if anything isn't
> clear.  Also keep in mind I'm still at the stage where I'm trying to get
> it into a semi-working state as quickly as possible so the implementation
> is pretty rough.
>
> Basic design:
>
> We use a KeyValueDB (leveldb, rocksdb, ...) for all of our metadata.
> Object data is stored in files with simple names (%d) in a simple
> directory structure (one level deep, default 1M files per dir).  The main
> piece of metadata we store is a mapping from object name (ghobject_t) to
> onode_t, which looks like this:
>
>  struct onode_t {
>    uint64_t size;                       ///< object size
>    map<string, bufferptr> attrs;        ///< attrs
>    map<uint64_t, fragment_t> data_map;  ///< data (offset to fragment mapping)
>
> i.e., it's what we used to rely on xattrs on the inode for.  Here, we'll
> only lean on the file system for file data and it's block management.
>
> fragment_t looks like
>
>  struct fragment_t {
>    uint32_t offset;   ///< offset in file to first byte of this fragment
>    uint32_t length;   ///< length of fragment/extent
>    fid_t fid;         ///< file backing this fragment
>
> and fid_t is
>
>  struct fid_t {
>    uint32_t fset, fno;   // identify the file name: fragments/%d/%d
>
> To start we'll keep the mapping pretty simple (just one fragment_t) but
> later we can go for varying degrees of complexity.
>
> We lean on the kvdb for our transactions.
>
> If we are creating new objects, we write data into a new file/fid,
> [aio_]fsync, and then commit the transaction.
>
> If we are doing an overwrite, we include a write-ahead log (wal)
> item in our transaction, and then apply it afterwards.  For example, a 4k
> overwrite would make whatever metadata changes are included, and a wal
> item that says "then overwrite this 4k in this fid with this data".  i.e.,
> the worst case is more or less what FileStore is doing now with its
> journal, except here we're using the kvdb (and its journal) for that.  On
> restart we can queue up and apply any unapplied wal items.
>
> An alternative approach here that we discussed a bit yesterday would be to
> write the small overwrites into the kvdb adjacent to the onode.  Actually
> writing them back to the file could be deferred until later, maybe when
> there are many small writes to be done together.
>
> But right now the write behavior is very simple, and handles just 3 cases:
>
>         https://github.com/liewegas/ceph/blob/wip-newstore/src/os/newstore/NewStore.cc#L1339
>
> 1. New object: create a new file and write there.
>
> 2. Append: append to an existing fid.  We store the size in the onode so
> we can be a bit sloppy and in the failure case (where we write some
> extra data to the file but don't commit the onode) just ignore any
> trailing file data.
>
> 3. Anything else: generate a WAL item.
>
> 4. Maybe later, for some small [over]writes, we instead put the new data
> next to the onode.
>
> There is no omap yet.  I think we should do basically what DBObjectMap did
> (with a layer of indirection to allow clone etc), but we need to rejigger
> it so that the initial pointer into that structure is embedded in the
> onode.  We may want to do some other optimization to avoid extra
> indirection in the common case.  Leaving this for later, though...
>
> We are designing for the case where the workload is already sharded across
> collections.  Each collection gets an in-memory Collection, which has its
> own RWLock and its own onode_map (SharedLRU cache).  A split will
> basically amount to registering the new collection in the kvdb and
> clearing the in-memory onode cache.
>
> There is a TransContext structure that is used to track the progress of a
> transaction.  It'll list which fd's need to get synced pre-commit, which
> onodes need to get written back in the transaction, and any WAL items to
> include and queue up after the transaction commits.  Right now the
> queue_transaction path does most of the work synchronously just to get
> things working.  Looking ahead I think what it needs to do is:
>
>  - assemble the transaction
>  - start any aio writes (we could use O_DIRECT here if the new hints
> include WONTNEED?)
>  - start any aio fsync's
>  - queue kvdb transaction
>  - fire onreadable[_sync] notifications (I suspect we'll want to do this
> unconditionally; maybe we avoid using them entirely?)
>
> On transaction commit,
>  - fire commit notifications
>  - queue WAL operations to a finisher
>
> The WAL ops will be linked to the TransContext so that if you want to do a
> read on the onode you can block until it completes.  If we keep the
> (currently simple) locking then we can use the Collection rwlock to block
> new writes while we want for previous ones to apply.  Or we can get more
> granular with the read vs write locks, but I'm not sure it'll be any use
> until we make major changes in the OSD (like dispatching parallel reads
> within a PG).
>
> Clone is annoying; if the FS doesn't support it natively (anything not
> btrfs) I think we should just do a sync read and then write for
> simplicity.
>
> A few other thoughts:
>
> - For a fast kvdb, we may want to do the transaction commit synchronously.
> For disk backends I think we'll want it async, though, to avoid blocking
> the caller.
>
> - The fid_t has a inode number stashed in it.  The idea is to use
> open_by_handle to avoid traversing the (shallow) directory and go straight
> to the inode.  On XFS this means we traverse the inode btree to verify it
> is in fast a valid ino, which isn't totally ideal but probably what we
> have to live with.  Note that open_by_handle will work on any other
> (NFS-exportable) filesystem as well so this is in no way XFS-specific.
> This is implemented yet, but when we do, we'll probably want to verify we
> got the right file by putting some id in an xattr; that way you could
> safely copy the whole thing to another filesystem and it could gracefully
> fall back to opening using the file names.
>
> - I think we could build a variation on this implementation on top of an
> NVMe device instead of a file system. It could pretty trivially lay out
> writes in the address space as a linear sweep across the virutal address
> space.  If the NVMe address space is big enough, maybe we could even avoid
> thinking about reusing addresses for deleted object?  We'd just send a
> discard and then forget about it.  Not sure if the address space is really
> that big, though...  If not, we'd need to do make a simple allocator
> (blah).
>
> sage
>
>
> * This follows in the Messenger's naming footsteps, which went like this:
> MPIMessenger, NewMessenger, NewerMessenger, SimpleMessenger (which ended
> up being anything but simple).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
