From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 12:50:01 -0400
Message-ID: <20110730165001.GI7361@thunk.org>
References: <4E33D101.1050504@ufm.su>
 <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
 <4E3432FC.9030204@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from li9-11.members.linode.com ([67.18.176.11]:59644 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab1G3QuE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 12:50:04 -0400
Content-Disposition: inline
In-Reply-To: <4E3432FC.9030204@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sat, Jul 30, 2011 at 07:36:12PM +0300, Fyodor Ustinov wrote:
> As it is written in subject - 3.0.0 release.
> 
> It's Ubuntu 11.04 with custom kernel

Right, sorry, I missed that.  And just to be clear this wasn't an -rc
kernel but 3.0 final, right?

Hmm, looking through recent commits which will shortly be merged into
3.1, this one leaps out, but I'm not sure it's the cause --- how full
was your disk at the end of this exercise?

I haven't looked at Ceph in quite a while.  As I recall it was
primarily doing Direct I/O writes, correct?  Or does it use buffered
I/O?  And does it use the new "punch" ioctl to release blocks from the
middle of a file?  Ext4 added punch support in 3.0, and there are some
bug fixes that are going into 3.1, but I don't think there were any
that would lead to the failure mode you are seeing.

					- Ted

commit 7132de744ba76930d13033061018ddd7e3e8cd91
Author: Maxim Patlasov <maxim.patlasov@gmail.com>
Date:   Sun Jul 10 19:37:48 2011 -0400

    ext4: fix i_blocks/quota accounting when extent insertion fails
    
    The current implementation of ext4_free_blocks() always calls
    dquot_free_block This looks quite sensible in the most cases: blocks
    to be freed are associated with inode and were accounted in quota and
    i_blocks some time ago.
    
    However, there is a case when blocks to free were not accounted by the
    time calling ext4_free_blocks() yet:
    
    1. delalloc is on, write_begin pre-allocated some space in quota
    2. write-back happens, ext4 allocates some blocks in ext4_ext_map_blocks()
    3. then ext4_ext_map_blocks() gets an error (e.g.  ENOSPC) from
       ext4_ext_insert_extent() and calls ext4_free_blocks().
    
    In this scenario, ext4_free_blocks() calls dquot_free_block() who, in
    turn, decrements i_blocks for blocks which were not accounted yet (due
    to delalloc) After clean umount, e2fsck reports something like:
    
    > Inode 21, i_blocks is 5080, should be 5128.  Fix<y>?
    because i_blocks was erroneously decremented as explained above.
    
    The patch fixes the problem by passing the new flag
    EXT4_FREE_BLOCKS_NO_QUOT_UPDATE to ext4_free_blocks(), to request
    that the dquot_free_block() call be skipped.
    
    Signed-off-by: Maxim Patlasov <maxim.patlasov@gmail.com>
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
    Cc: stable@kernel.org

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 49d2cea..d13f3b5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -526,6 +526,7 @@ struct ext4_new_group_data {
 #define EXT4_FREE_BLOCKS_METADATA	0x0001
 #define EXT4_FREE_BLOCKS_FORGET		0x0002
 #define EXT4_FREE_BLOCKS_VALIDATED	0x0004
+#define EXT4_FREE_BLOCKS_NO_QUOT_UPDATE	0x0008
 
 /*
  * ioctl commands
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 31ae5fb..a862138 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3565,12 +3565,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 
 	err = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
 	if (err) {
+		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
+			EXT4_FREE_BLOCKS_NO_QUOT_UPDATE : 0;
 		/* free data blocks we just allocated */
 		/* not a good idea to call discard here directly,
 		 * but otherwise we'd need to call it every free() */
 		ext4_discard_preallocations(inode);
 		ext4_free_blocks(handle, inode, NULL, ext4_ext_pblock(&newex),
-				 ext4_ext_get_actual_len(&newex), 0);
+				 ext4_ext_get_actual_len(&newex), fb_flags);
 		goto out2;
 	}
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 389386b..1900ec7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4637,7 +4637,7 @@ do_more:
 	}
 	ext4_mark_super_dirty(sb);
 error_return:
-	if (freed)
+	if (freed && !(flags & EXT4_FREE_BLOCKS_NO_QUOT_UPDATE))
 		dquot_free_block(inode, freed);
 	brelse(bitmap_bh);
 	ext4_std_error(sb, err);
