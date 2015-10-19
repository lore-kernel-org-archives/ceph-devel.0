From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: newstore direction
Date: Mon, 19 Oct 2015 14:22:28 -0600
Message-ID: <CAANLjFrRg_G8s2qMd+Ck7b262k4=qu3M11NqkTwbwL94u55nkA@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33912 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbbJSUW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 16:22:29 -0400
Received: by vkat63 with SMTP id t63so111555110vka.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 13:22:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I think there is a lot that can be gained by Ceph managing a raw block
device. As I mentioned on ceph-users, I've given this some though and
a lot of optimizations could be done that is conducive to storing
objects. I didn't think however to bypass VFS all together by opening
the raw device directly, but this would make things simpler as you
don't have to program things for VFS that don't make sense.

Some of my thoughts were to employ a hashing algorithm for inode
lookup (CRUSH like). Is there a good use case for listing a directory?
We may need to keep a list for deletion, but there may be a better way
to handle this. Is there a need to do snapshots at the block layer if
operations can be atomic? Is there a real advantage to have an
allocation as small as 4K, or does it make since to use something like
512K?

I'm interested in how this might pan out.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWJVEACRDmVDuy+mK58QAAIQEQAK9GUmGQBP1wYa9yXNEp
juofzj5SCxxiNCBdY3kkdHXELCWkLGn331JX2El8h1lPaqH8/nWNy4U6hx0s
7A5EBgQp7+LN03OLroSfiSccPhEe5B/OB1cnyZjmxwDXyaMJzqXwn231f5ev
lBEzvU5PpHrMdNIIGxNFEHgduxfPIw5ciOokP27Tle1JdAGSn6fL6nRLtQfd
HmVLnnXJT9zaGRyxnL8ZQU8IlfjfhMpIc1bM3QKkQkBmXanzCaNaULrlO35L
XtIy0fEXAjkcGHpxOTz4yx5OFKwkpirFduU2PBn+5kqxPRvGL/eEzIxTV89c
SfhAkyBFpl+g7G+q532i7L/34r2wXOL7wcn9seLdOZIt1LVnb059r0tpy4Fz
X/V2/ao1Fua2BFMYzMskPXiKFzxLu/jOS12CjvYWkNhN4C2pGUbRxhqYnC0k
gjRpoOZHDr+RogQdlzXeUmcbZzvtwWqk2uECIX2mLR1aHTVgnpegJhvvHdl3
Nm7jxLyTof2bcXQgSwO5YEXvWO3dNfQynrb5zE+aIVM5ps9D95Mmm94lJtda
47zraQNwrL1OVS7Fd4ot9VepLcQ4orCUZPSqrm5FBlBWj5G+/U0F8VQl8u/g
/nSZrxMXjHJWRhFvzFMYC3yUp59N75LXR5wId8RkAkgZVM+PftB4LmB7spHC
WcGR
=j3i1
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Oct 19, 2015 at 1:49 PM, Sage Weil <sweil@redhat.com> wrote:
> The current design is based on two simple ideas:
>
>  1) a key/value interface is better way to manage all of our internal
> metadata (object metadata, attrs, layout, collection membership,
> write-ahead logging, overlay data, etc.)
>
>  2) a file system is well suited for storage object data (as files).
>
> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
> things:
>
>  - We currently write the data to the file, fsync, then commit the kv
> transaction.  That's at least 3 IOs: one for the data, one for the fs
> journal, one for the kv txn to commit (at least once my rocksdb changes
> land... the kv commit is currently 2-3).  So two people are managing
> metadata, here: the fs managing the file metadata (with its own
> journal) and the kv backend (with its journal).
>
>  - On read we have to open files by name, which means traversing the fs
> namespace.  Newstore tries to keep it as flat and simple as possible, but
> at a minimum it is a couple btree lookups.  We'd love to use open by
> handle (which would reduce this to 1 btree traversal), but running
> the daemon as ceph and not root makes that hard...
>
>  - ...and file systems insist on updating mtime on writes, even when it is
> a overwrite with no allocation changes.  (We don't care about mtime.)
> O_NOCMTIME patches exist but it is hard to get these past the kernel
> brainfreeze.
>
>  - XFS is (probably) never going going to give us data checksums, which we
> want desperately.
>
> But what's the alternative?  My thought is to just bite the bullet and
> consume a raw block device directly.  Write an allocator, hopefully keep
> it pretty simple, and manage it in kv store along with all of our other
> metadata.
>
> Wins:
>
>  - 2 IOs for most: one to write the data to unused space in the block
> device, one to commit our transaction (vs 4+ before).  For overwrites,
> we'd have one io to do our write-ahead log (kv journal), then do
> the overwrite async (vs 4+ before).
>
>  - No concern about mtime getting in the way
>
>  - Faster reads (no fs lookup)
>
>  - Similarly sized metadata for most objects.  If we assume most objects
> are not fragmented, then the metadata to store the block offsets is about
> the same size as the metadata to store the filenames we have now.
>
> Problems:
>
>  - We have to size the kv backend storage (probably still an XFS
> partition) vs the block storage.  Maybe we do this anyway (put metadata on
> SSD!) so it won't matter.  But what happens when we are storing gobs of
> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
> a different pool and those aren't currently fungible.
>
>  - We have to write and maintain an allocator.  I'm still optimistic this
> can be reasonbly simple, especially for the flash case (where
> fragmentation isn't such an issue as long as our blocks are reasonbly
> sized).  For disk we may beed to be moderately clever.
>
>  - We'll need a fsck to ensure our internal metadata is consistent.  The
> good news is it'll just need to validate what we have stored in the kv
> store.
>
> Other thoughts:
>
>  - We might want to consider whether dm-thin or bcache or other block
> layers might help us with elasticity of file vs block areas.
>
>  - Rocksdb can push colder data to a second directory, so we could have a
> fast ssd primary area (for wal and most metadata) and a second hdd
> directory for stuff it has to push off.  Then have a conservative amount
> of file space on the hdd.  If our block fills up, use the existing file
> mechanism to put data there too.  (But then we have to maintain both the
> current kv + file approach and not go all-in on kv + block.)
>
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
