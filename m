From: Christoph Hellwig <hch@infradead.org>
Subject: Re: newstore direction
Date: Thu, 22 Oct 2015 01:31:15 -0700
Message-ID: <20151022083115.GA26798@infradead.org>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com>
 <1445415736.1809.71.camel@redhat.com>
 <56277468.5000504@redhat.com>
 <alpine.DEB.2.00.1510210543110.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60768 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbbJVIbQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 04:31:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1510210543110.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, Orit Wasserman <owasserm@redhat.com>, ceph-devel@vger.kernel.org

On Wed, Oct 21, 2015 at 10:30:28AM -0700, Sage Weil wrote:
> For example: we need to do an overwrite of an existing object that is 
> atomic with respect to a larger ceph transaction (we're updating a bunch 
> of other metadata at the same time, possibly overwriting or appending to 
> multiple files, etc.).  XFS and ext4 aren't cow file systems, so plugging 
> into the transaction infrastructure isn't really an option (and even after 
> several years of trying to do it with btrfs it proved to be impractical).  

Not that I'm disagreeing with most of your points, but we can do things
like that with swapext-like hacks.  Below is my half year old prototype
of an O_ATOMIC implementation for XFS that gives you atomic out of place
writes.

diff --git a/fs/fcntl.c b/fs/fcntl.c
index ee85cd4..001dd49 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -740,7 +740,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ != HWEIGHT32(
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ != HWEIGHT32(
 		O_RDONLY	| O_WRONLY	| O_RDWR	|
 		O_CREAT		| O_EXCL	| O_NOCTTY	|
 		O_TRUNC		| O_APPEND	| /* O_NONBLOCK	| */
@@ -748,6 +748,7 @@ static int __init fcntl_init(void)
 		O_DIRECT	| O_LARGEFILE	| O_DIRECTORY	|
 		O_NOFOLLOW	| O_NOATIME	| O_CLOEXEC	|
 		__FMODE_EXEC	| O_PATH	| __O_TMPFILE	|
+		O_ATOMIC	|
 		__FMODE_NONOTIFY
 		));
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index aeffeaa..8eafca6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4681,14 +4681,14 @@ xfs_bmap_del_extent(
 	xfs_btree_cur_t		*cur,	/* if null, not a btree */
 	xfs_bmbt_irec_t		*del,	/* data to remove from extents */
 	int			*logflagsp, /* inode logging flags */
-	int			whichfork) /* data or attr fork */
+	int			whichfork, /* data or attr fork */
+	bool			free_blocks) /* free extent at end of routine */
 {
 	xfs_filblks_t		da_new;	/* new delay-alloc indirect blocks */
 	xfs_filblks_t		da_old;	/* old delay-alloc indirect blocks */
 	xfs_fsblock_t		del_endblock=0;	/* first block past del */
 	xfs_fileoff_t		del_endoff;	/* first offset past del */
 	int			delay;	/* current block is delayed allocated */
-	int			do_fx;	/* free extent at end of routine */
 	xfs_bmbt_rec_host_t	*ep;	/* current extent entry pointer */
 	int			error;	/* error return value */
 	int			flags;	/* inode logging flags */
@@ -4712,8 +4712,8 @@ xfs_bmap_del_extent(
 
 	mp = ip->i_mount;
 	ifp = XFS_IFORK_PTR(ip, whichfork);
-	ASSERT((*idx >= 0) && (*idx < ifp->if_bytes /
-		(uint)sizeof(xfs_bmbt_rec_t)));
+	ASSERT(*idx >= 0);
+	ASSERT(*idx < ifp->if_bytes / sizeof(xfs_bmbt_rec_t));
 	ASSERT(del->br_blockcount > 0);
 	ep = xfs_iext_get_ext(ifp, *idx);
 	xfs_bmbt_get_all(ep, &got);
@@ -4746,10 +4746,13 @@ xfs_bmap_del_extent(
 			len = del->br_blockcount;
 			do_div(bno, mp->m_sb.sb_rextsize);
 			do_div(len, mp->m_sb.sb_rextsize);
-			error = xfs_rtfree_extent(tp, bno, (xfs_extlen_t)len);
-			if (error)
-				goto done;
-			do_fx = 0;
+			if (free_blocks) {
+				error = xfs_rtfree_extent(tp, bno,
+						(xfs_extlen_t)len);
+				if (error)
+					goto done;
+				free_blocks = 0;
+			}
 			nblks = len * mp->m_sb.sb_rextsize;
 			qfield = XFS_TRANS_DQ_RTBCOUNT;
 		}
@@ -4757,7 +4760,6 @@ xfs_bmap_del_extent(
 		 * Ordinary allocation.
 		 */
 		else {
-			do_fx = 1;
 			nblks = del->br_blockcount;
 			qfield = XFS_TRANS_DQ_BCOUNT;
 		}
@@ -4777,7 +4779,7 @@ xfs_bmap_del_extent(
 		da_old = startblockval(got.br_startblock);
 		da_new = 0;
 		nblks = 0;
-		do_fx = 0;
+		free_blocks = 0;
 	}
 	/*
 	 * Set flag value to use in switch statement.
@@ -4963,7 +4965,7 @@ xfs_bmap_del_extent(
 	/*
 	 * If we need to, add to list of extents to delete.
 	 */
-	if (do_fx)
+	if (free_blocks)
 		xfs_bmap_add_free(del->br_startblock, del->br_blockcount, flist,
 			mp);
 	/*
@@ -5291,7 +5293,7 @@ xfs_bunmapi(
 			goto error0;
 		}
 		error = xfs_bmap_del_extent(ip, tp, &lastx, flist, cur, &del,
-				&tmp_logflags, whichfork);
+				&tmp_logflags, whichfork, true);
 		logflags |= tmp_logflags;
 		if (error)
 			goto error0;
@@ -5936,3 +5938,291 @@ out:
 	xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
 	return error;
 }
+
+/*
+ * Create an extent tree pointing to an existing allocation.
+ * This is a small subset of the functionality in xfs_bmap_add_extent_hole_real.
+ *
+ * Note: we don't bother merging with neighbours.
+ */
+STATIC int
+xfs_bmap_insert_extent_real(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*new,
+	struct xfs_btree_cur	*cur,
+	xfs_extnum_t		idx,
+	xfs_fsblock_t		*firstblock,
+	struct xfs_bmap_free	*flist,
+	int			*logflags)
+{
+	struct xfs_mount	*mp = tp->t_mountp;
+	int			error = 0, rval = 0, i;
+
+	ASSERT(idx >= 0);
+	ASSERT(idx <= ip->i_df.if_bytes / sizeof(struct xfs_bmbt_rec));
+	ASSERT(!isnullstartblock(new->br_startblock));
+	ASSERT(!cur || !(cur->bc_private.b.flags & XFS_BTCUR_BPRV_WASDEL));
+
+	XFS_STATS_INC(xs_add_exlist);
+
+	xfs_iext_insert(ip, idx, 1, new, 0);
+	ip->i_d.di_nextents++;
+	ip->i_d.di_nblocks += new->br_blockcount;
+
+	if (cur == NULL) {
+		rval = XFS_ILOG_CORE | XFS_ILOG_DEXT;
+	} else {
+		rval = XFS_ILOG_CORE;
+		error = xfs_bmbt_lookup_eq(cur,
+				new->br_startoff,
+				new->br_startblock,
+				new->br_blockcount, &i);
+		if (error)
+			goto done;
+		XFS_WANT_CORRUPTED_GOTO(mp, i == 0, done);
+		cur->bc_rec.b.br_state = new->br_state;
+		error = xfs_btree_insert(cur, &i);
+		if (error)
+			goto done;
+		XFS_WANT_CORRUPTED_GOTO(mp, i == 1, done);
+	}
+
+	/* convert to a btree if necessary */
+	if (xfs_bmap_needs_btree(ip, XFS_DATA_FORK)) {
+		int	tmp_logflags;	/* partial log flag return val */
+
+		ASSERT(cur == NULL);
+		error = xfs_bmap_extents_to_btree(tp, ip, firstblock, flist,
+				&cur, 0, &tmp_logflags, XFS_DATA_FORK);
+		*logflags |= tmp_logflags;
+		if (error)
+			goto done;
+	}
+
+	/* clear out the allocated field, done with it now in any case. */
+	if (cur)
+		cur->bc_private.b.allocated = 0;
+
+	xfs_bmap_check_leaf_extents(cur, ip, XFS_DATA_FORK);
+done:
+	*logflags |= rval;
+	return error;
+}
+
+int
+xfs_bmapi_insert(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*new,
+	xfs_fsblock_t		*firstblock,
+	struct xfs_bmap_free	*flist)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, XFS_DATA_FORK);
+	int			whichfork = XFS_DATA_FORK;
+	int			eof;
+	int			error;
+	char			inhole;	
+	char			wasdelay;
+	struct xfs_bmbt_irec	got;
+	struct xfs_bmbt_irec	prev;
+	struct xfs_btree_cur	*cur = NULL;
+	xfs_extnum_t		idx;
+	int			logflags = 0;
+
+	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+
+	if (unlikely(XFS_TEST_ERROR(
+	    (XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_EXTENTS &&
+	     XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_BTREE),
+	     mp, XFS_ERRTAG_BMAPIFORMAT, XFS_RANDOM_BMAPIFORMAT))) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, mp);
+		return -EFSCORRUPTED;
+	}
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	XFS_STATS_INC(xs_blk_mapw);
+
+	if (!(ifp->if_flags & XFS_IFEXTENTS)) {
+		error = xfs_iread_extents(tp, ip, whichfork);
+		if (error)
+			goto error0;
+	}
+
+	xfs_bmap_search_extents(ip, new->br_startoff, whichfork,
+			&eof, &idx, &got, &prev);
+
+	inhole = eof || got.br_startoff > new->br_startoff;
+	wasdelay = !inhole && isnullstartblock(got.br_startblock);
+	ASSERT(!wasdelay);
+	ASSERT(inhole);
+
+	if (ifp->if_flags & XFS_IFBROOT) {
+		cur = xfs_bmbt_init_cursor(mp, tp, ip, whichfork);
+		cur->bc_private.b.flist = flist;
+		cur->bc_private.b.firstblock = *firstblock;
+		cur->bc_private.b.flags = 0;
+	}
+
+	error = xfs_bmap_insert_extent_real(tp, ip, new, cur, idx, firstblock,
+			flist, &logflags);
+	if (error)
+		return error;
+
+	/*
+	 * Transform from btree to extents, give it cur.
+	 */
+	if (xfs_bmap_wants_extents(ip, whichfork)) {
+		int		tmp_logflags = 0;
+
+		ASSERT(cur);
+		error = xfs_bmap_btree_to_extents(tp, ip, cur,
+			&tmp_logflags, whichfork);
+		logflags |= tmp_logflags;
+		if (error)
+			goto error0;
+	}
+
+	ASSERT(XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_BTREE ||
+	       XFS_IFORK_NEXTENTS(ip, whichfork) >
+		XFS_IFORK_MAXEXT(ip, whichfork));
+	error = 0;
+error0:
+	/*
+	 * Log everything.  Do this after conversion, there's no point in
+	 * logging the extent records if we've converted to btree format.
+	 */
+	if ((logflags & xfs_ilog_fext(whichfork)) &&
+	    XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_EXTENTS)
+		logflags &= ~xfs_ilog_fext(whichfork);
+	else if ((logflags & xfs_ilog_fbroot(whichfork)) &&
+		 XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_BTREE)
+		logflags &= ~xfs_ilog_fbroot(whichfork);
+	/*
+	 * Log whatever the flags say, even if error.  Otherwise we might miss
+	 * detecting a case where the data is changed, there's an error,
+	 * and it's not logged so we don't shutdown when we should.
+	 */
+	if (logflags)
+		xfs_trans_log_inode(tp, ip, logflags);
+
+	if (cur) {
+		if (!error) {
+			ASSERT(*firstblock == NULLFSBLOCK ||
+			       XFS_FSB_TO_AGNO(mp, *firstblock) ==
+			       XFS_FSB_TO_AGNO(mp,
+				       cur->bc_private.b.firstblock) ||
+			       (flist->xbf_low &&
+				XFS_FSB_TO_AGNO(mp, *firstblock) <
+				XFS_FSB_TO_AGNO(mp,
+					cur->bc_private.b.firstblock)));
+			*firstblock = cur->bc_private.b.firstblock;
+		}
+		xfs_btree_del_cursor(cur,
+			error ? XFS_BTREE_ERROR : XFS_BTREE_NOERROR);
+	}
+	return error;
+}
+
+/*
+ * Remove the extent pointed to by del from the extent map, but do not free
+ * the blocks for it.
+ */
+int
+xfs_bmapi_unmap(
+	struct xfs_trans	*tp,		/* transaction pointer */
+	struct xfs_inode	*ip,		/* incore inode */
+	xfs_extnum_t		idx,		/* extent number to update/delete */
+	struct xfs_bmbt_irec	*del,		/* extent being deleted */
+	xfs_fsblock_t		*firstblock,	/* first allocated block
+						   controls a.g. for allocs */
+	struct xfs_bmap_free	*flist)		/* i/o: list extents to free */
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_ifork	*ifp = &ip->i_df;
+	int			whichfork = XFS_DATA_FORK;
+	struct xfs_btree_cur	*cur;
+	int			error;
+	int			logflags = 0;
+
+	if (unlikely(
+	    XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_EXTENTS &&
+	    XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_BTREE)) {
+		XFS_ERROR_REPORT("xfs_bunmapi", XFS_ERRLEVEL_LOW,
+				 ip->i_mount);
+		return -EFSCORRUPTED;
+	}
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+
+	if (!(ifp->if_flags & XFS_IFEXTENTS)) {
+		error = xfs_iread_extents(tp, ip, whichfork);
+		if (error)
+			return error;
+	}
+
+	XFS_STATS_INC(xs_blk_unmap);
+
+	if (ifp->if_flags & XFS_IFBROOT) {
+		ASSERT(XFS_IFORK_FORMAT(ip, whichfork) == XFS_DINODE_FMT_BTREE);
+		cur = xfs_bmbt_init_cursor(mp, tp, ip, whichfork);
+		cur->bc_private.b.firstblock = *firstblock;
+		cur->bc_private.b.flist = flist;
+		cur->bc_private.b.flags = 0;
+	} else
+		cur = NULL;
+
+	ASSERT(!isnullstartblock(del->br_startblock));
+	error = xfs_bmap_del_extent(ip, tp, &idx, flist, cur, del,
+			&logflags, whichfork, false);
+	if (error)
+		goto error0;
+
+	/*
+	 * transform from btree to extents, give it cur
+	 */
+	if (xfs_bmap_wants_extents(ip, whichfork)) {
+		int tmp_logflags = 0;
+
+		ASSERT(cur != NULL);
+		error = xfs_bmap_btree_to_extents(tp, ip, cur, &tmp_logflags,
+			whichfork);
+		logflags |= tmp_logflags;
+		if (error)
+			goto error0;
+	}
+
+error0:
+	/*
+	 * Log everything.  Do this after conversion, there's no point in
+	 * logging the extent records if we've converted to btree format.
+	 */
+	if ((logflags & xfs_ilog_fext(whichfork)) &&
+	    XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_EXTENTS)
+		logflags &= ~xfs_ilog_fext(whichfork);
+	else if ((logflags & xfs_ilog_fbroot(whichfork)) &&
+		 XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_BTREE)
+		logflags &= ~xfs_ilog_fbroot(whichfork);
+	/*
+	 * Log inode even in the error case, if the transaction
+	 * is dirty we'll need to shut down the filesystem.
+	 */
+	if (logflags)
+		xfs_trans_log_inode(tp, ip, logflags);
+	if (cur) {
+		if (!error) {
+			*firstblock = cur->bc_private.b.firstblock;
+			cur->bc_private.b.allocated = 0;
+		}
+		xfs_btree_del_cursor(cur,
+			error ? XFS_BTREE_ERROR : XFS_BTREE_NOERROR);
+	}
+	return error;
+}
+		
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 6aaa0c1..394843f 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -221,5 +221,11 @@ int	xfs_bmap_shift_extents(struct xfs_trans *tp, struct xfs_inode *ip,
 		struct xfs_bmap_free *flist, enum shift_direction direction,
 		int num_exts);
 int	xfs_bmap_split_extent(struct xfs_inode *ip, xfs_fileoff_t split_offset);
+int	xfs_bmapi_insert(struct xfs_trans *tp, struct xfs_inode *ip,
+		struct xfs_bmbt_irec *new, xfs_fsblock_t *firstblock,
+		struct xfs_bmap_free *flist);
+int	xfs_bmapi_unmap(struct xfs_trans *tp, struct xfs_inode *ip,
+		xfs_extnum_t idx, struct xfs_bmbt_irec *del,
+		xfs_fsblock_t *firstblock, struct xfs_bmap_free *flist);
 
 #endif	/* __XFS_BMAP_H__ */
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a56960d..e64ffd80 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1365,6 +1365,9 @@ __xfs_get_blocks(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
+	if (ip->i_cow && !ip->i_df.if_bytes && !create)
+		ip = ip->i_cow;
+
 	offset = (xfs_off_t)iblock << inode->i_blkbits;
 	ASSERT(bh_result->b_size >= (1 << inode->i_blkbits));
 	size = bh_result->b_size;
@@ -1372,6 +1375,7 @@ __xfs_get_blocks(
 	if (!create && direct && offset >= i_size_read(inode))
 		return 0;
 
+retry:
 	/*
 	 * Direct I/O is usually done on preallocated files, so try getting
 	 * a block mapping without an exclusive lock first.  For buffered
@@ -1397,6 +1401,13 @@ __xfs_get_blocks(
 	if (error)
 		goto out_unlock;
 
+	if (!create && ip->i_cow &&
+	    (!nimaps || imap.br_startblock == HOLESTARTBLOCK)) {
+		xfs_iunlock(ip, lockmode);
+		ip = ip->i_cow;
+		goto retry;
+	}
+
 	if (create &&
 	    (!nimaps ||
 	     (imap.br_startblock == HOLESTARTBLOCK ||
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a52bbd3..c45f15e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1918,3 +1918,262 @@ out_trans_cancel:
 	xfs_trans_cancel(tp, 0);
 	goto out;
 }
+
+static int
+xfs_remove_extent(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*del,
+	bool			*done)
+{
+	struct xfs_trans	*tp = *tpp, *ntp;
+	struct xfs_ifork	*ifp = &ip->i_df;
+	struct xfs_bmap_free	free_list;
+	xfs_fsblock_t		firstblock;
+	int			error, committed;
+	xfs_extnum_t		nextents, idx;
+
+	xfs_trans_ijoin(tp, ip, 0);
+
+	/*
+	 * Always delete the first last extents, this avoids shifting around
+	 * the extent list every time.
+	 *
+	 * XXX: find a way to avoid the transaction allocation without extents?
+	 */
+	nextents = ifp->if_bytes / sizeof(struct xfs_bmbt_rec);
+	if (!nextents) {
+		*done = true;
+		return 0;
+	}
+	idx = nextents - 1;
+	xfs_bmbt_get_all(xfs_iext_get_ext(ifp, idx), del);
+
+	xfs_bmap_init(&free_list, &firstblock);
+	error = xfs_bmapi_unmap(tp, ip, idx, del, &firstblock, &free_list);
+	if (error)
+		goto out_bmap_cancel;
+
+	error = xfs_bmap_finish(&tp, &free_list, &committed);
+	if (error)
+		goto out_bmap_cancel;
+
+	if (committed) {
+		xfs_trans_ijoin(tp, ip, 0);
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	}
+
+	ntp = xfs_trans_dup(tp);
+	error = xfs_trans_commit(tp, 0);
+	tp = ntp;
+	xfs_trans_ijoin(tp, ip, 0);
+
+	if (error) {
+		xfs_trans_cancel(tp, 0);
+		goto out_error;
+	}
+
+	xfs_log_ticket_put(tp->t_ticket);
+	error = xfs_trans_reserve(tp, &M_RES(ip->i_mount)->tr_write, 0, 0);
+	if (error) {
+		xfs_trans_cancel(tp, 0);
+		goto out_error;
+	}
+
+	*tpp = tp;
+	return 0;
+
+out_bmap_cancel:
+	xfs_bmap_cancel(&free_list);
+	xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
+out_error:
+	*tpp = NULL;
+	return error;
+}
+
+static int
+xfs_free_range(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*del)
+{
+	struct xfs_trans	*tp = *tpp, *ntp;
+	struct xfs_bmap_free	free_list;
+	int			committed;
+	int			done;
+	int			error = 0;
+	xfs_fsblock_t		firstfsb;
+
+	while (!error && !done) {
+		xfs_trans_ijoin(tp, ip, 0);
+
+		xfs_bmap_init(&free_list, &firstfsb);
+		error = xfs_bunmapi(tp, ip, del->br_startoff,
+				del->br_blockcount, 0, 2,
+				&firstfsb, &free_list, &done);
+		if (error)
+			goto out_bmap_cancel;
+
+		error = xfs_bmap_finish(&tp, &free_list, &committed);
+		if (error)
+			goto out_bmap_cancel;
+
+		if (committed) {
+			xfs_trans_ijoin(tp, ip, 0);
+			xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+		}
+
+		ntp = xfs_trans_dup(tp);
+		error = xfs_trans_commit(tp, 0);
+		tp = ntp;
+		xfs_trans_ijoin(tp, ip, 0);
+
+		if (error) 
+			goto out_error;
+
+		xfs_log_ticket_put(tp->t_ticket);
+		error = xfs_trans_reserve(tp, &M_RES(ip->i_mount)->tr_write, 0, 0);
+		if (error)
+			goto out_error;
+	}
+
+	*tpp = tp;
+	return 0;
+
+out_bmap_cancel:
+	xfs_bmap_cancel(&free_list);
+out_error:
+	xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
+	*tpp = NULL;
+	return error;
+}
+
+static int
+xfs_insert_extent(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*r)
+{
+	struct xfs_trans	*tp = *tpp, *ntp;
+	struct xfs_bmap_free	free_list;
+	xfs_fsblock_t		firstblock;
+	int			error, committed;
+
+	xfs_trans_ijoin(tp, ip, 0);
+	xfs_bmap_init(&free_list, &firstblock);
+	error = xfs_bmapi_insert(tp, ip, r, &firstblock, &free_list);
+	if (error)
+		goto out_bmap_cancel;
+
+	error = xfs_bmap_finish(&tp, &free_list, &committed);
+	if (error)
+		goto out_bmap_cancel;
+
+	ntp = xfs_trans_dup(tp);
+	error = xfs_trans_commit(tp, 0);
+	tp = ntp;
+	xfs_trans_ijoin(tp, ip, 0);
+
+	if (error)
+		goto out_error;
+
+	xfs_log_ticket_put(tp->t_ticket);
+	error = xfs_trans_reserve(tp, &M_RES(ip->i_mount)->tr_write, 0, 0);
+	if (error)
+		goto out_error;
+
+	*tpp = tp;
+	return 0;
+
+out_bmap_cancel:
+	xfs_bmap_cancel(&free_list);
+out_error:
+	xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES | XFS_TRANS_ABORT);
+	*tpp = NULL;
+	return error;
+}
+
+int
+xfs_commit_clone(
+	struct file		*file,
+	loff_t			start,
+	loff_t			end)
+{
+	struct xfs_inode	*dest = XFS_I(file_inode(file));
+	struct xfs_inode	*clone = XFS_I(file->f_mapping->host);
+	struct xfs_mount	*mp = clone->i_mount;
+	struct xfs_trans	*tp;
+	uint			lock_flags;
+	bool			done = false;
+	int			error = 0;
+
+	error = xfs_qm_dqattach(clone, 0);
+	if (error)
+		return error;
+
+	error = xfs_qm_dqattach(dest, 0);
+	if (error)
+		return error;
+
+	/*
+	 * Lock the inodes against other IO, page faults and truncate to
+	 * begin with.
+	 */
+	lock_flags = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+	xfs_lock_two_inodes(dest, clone, XFS_IOLOCK_EXCL);
+	xfs_lock_two_inodes(dest, clone, XFS_MMAPLOCK_EXCL);
+
+	inode_dio_wait(VFS_I(clone));
+	error = filemap_write_and_wait(VFS_I(clone)->i_mapping);
+	if (error)
+		goto out_unlock;
+
+	inode_dio_wait(VFS_I(dest));
+	error = filemap_write_and_wait(VFS_I(dest)->i_mapping);
+	if (error)
+		goto out_unlock;
+	truncate_pagecache_range(VFS_I(dest), 0, -1);
+	WARN_ON(VFS_I(dest)->i_mapping->nrpages);
+
+	tp = xfs_trans_alloc(mp, XFS_TRANS_DIOSTRAT);
+	error = xfs_trans_reserve(tp, &M_RES(mp)->tr_write, 0, 0);
+	if (error) {
+		xfs_trans_cancel(tp, 0);
+		return error;
+	}
+
+	xfs_lock_two_inodes(dest, clone, XFS_ILOCK_EXCL);
+	lock_flags |= XFS_ILOCK_EXCL;
+
+	for (;;) {
+		struct xfs_bmbt_irec	del;
+
+		error = xfs_remove_extent(&tp, clone, &del, &done);
+		if (error)
+			goto out_unlock;
+		if (done)
+			break;
+
+		error = xfs_free_range(&tp, dest, &del);
+		if (error)
+			goto out_unlock;
+
+		error = xfs_insert_extent(&tp, dest, &del);
+		if (error)
+			goto out_unlock;
+	}
+
+	xfs_trans_ijoin(tp, dest, 0);
+	xfs_trans_log_inode(tp, dest, XFS_ILOG_CORE);
+
+	i_size_write(VFS_I(dest), VFS_I(clone)->i_size);
+	dest->i_d.di_size = VFS_I(clone)->i_size;
+	xfs_trans_ichgtime(tp, dest, XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+
+	error = xfs_trans_commit(tp, XFS_TRANS_RELEASE_LOG_RES);
+
+out_unlock:
+	xfs_iunlock(dest, lock_flags);
+	xfs_iunlock(clone, lock_flags);
+	return error;
+}
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index af97d9a..1f4de38 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -65,6 +65,7 @@ int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
+int	xfs_commit_clone(struct file *file, loff_t start, loff_t end);
 
 /* EOF block manipulation functions */
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 8121e75..11f60ca 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -199,7 +199,7 @@ xfs_file_fsync(
 	loff_t			end,
 	int			datasync)
 {
-	struct inode		*inode = file->f_mapping->host;
+	struct inode		*inode = file_inode(file);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error = 0;
@@ -208,13 +208,20 @@ xfs_file_fsync(
 
 	trace_xfs_file_fsync(ip);
 
-	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
-	if (error)
-		return error;
-
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
+	if (file->f_mapping->host != inode) {
+		error = xfs_commit_clone(file, start, end);
+		if (error)
+			return error;
+	} else {
+		error = filemap_write_and_wait_range(inode->i_mapping,
+				start, end);
+		if (error)
+			return error;
+	}
+
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 
 	if (mp->m_flags & XFS_MOUNT_BARRIER) {
@@ -1002,6 +1009,36 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
+
+	if (file->f_flags & O_ATOMIC) {
+		struct dentry *parent;
+		struct xfs_inode *clone;
+		int error;
+	
+		if (XFS_IS_REALTIME_INODE(XFS_I(inode)))
+			return -EINVAL;
+
+		// XXX: also need to prevent setting O_DIRECT using fcntl.
+		if (file->f_flags & O_DIRECT)
+			return -EINVAL;
+
+		error = filemap_write_and_wait(inode->i_mapping);
+		if (error)
+			return error;
+
+		parent = dget_parent(file->f_path.dentry);
+		error = xfs_create_tmpfile(XFS_I(parent->d_inode), NULL,
+				file->f_mode, &clone);
+		dput(parent);
+
+		if (error)
+			return error;
+
+		VFS_I(clone)->i_size = inode->i_size;
+		clone->i_cow = XFS_I(inode);
+		file->f_mapping = VFS_I(clone)->i_mapping;
+		xfs_finish_inode_setup(clone);
+	}
 	return 0;
 }
 
@@ -1032,8 +1069,14 @@ xfs_dir_open(
 STATIC int
 xfs_file_release(
 	struct inode	*inode,
-	struct file	*filp)
+	struct file	*file)
 {
+	if (file->f_mapping->host != inode) {
+		XFS_I(file->f_mapping->host)->i_cow = NULL;
+		IRELE(XFS_I(file->f_mapping->host));
+		return 0;
+	}
+	
 	return xfs_release(XFS_I(inode));
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 76a9f27..a43e83a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -80,6 +80,7 @@ xfs_inode_alloc(
 	ip->i_flags = 0;
 	ip->i_delayed_blks = 0;
 	memset(&ip->i_d, 0, sizeof(xfs_icdinode_t));
+	ip->i_cow = NULL;
 
 	return ip;
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 8f22d20..a7c3f78 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -52,6 +52,8 @@ typedef struct xfs_inode {
 	/* operations vectors */
 	const struct xfs_dir_ops *d_ops;		/* directory ops vector */
 
+	struct xfs_inode	*i_cow;
+
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
 	mrlock_t		i_lock;		/* inode lock */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 38e633b..d9e177c 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -268,6 +268,13 @@ xfs_iomap_eof_want_preallocate(
 		return 0;
 
 	/*
+	 * Don't preallocate if this a clone for an O_ATOMIC open, as we'd
+	 * overwrite space in the original file with garbage on a commit.
+	 */
+	if (ip->i_cow)
+		return 0;
+
+	/*
 	 * If the file is smaller than the minimum prealloc and we are using
 	 * dynamic preallocation, don't do any preallocation at all as it is
 	 * likely this is the only write to the file that is going to be done.
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index e063eff..26ab762 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -92,6 +92,8 @@
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
 
+#define O_ATOMIC	040000000
+
 #ifndef O_NDELAY
 #define O_NDELAY	O_NONBLOCK
 #endif
