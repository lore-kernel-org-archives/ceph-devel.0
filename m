From: Sage Weil <sweil@redhat.com>
Subject: Re: About _setattr() optimazation and recovery accelerate
Date: Fri, 6 Mar 2015 08:03:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503060759190.18660@cobra.newdream.net>
References: <CALZt5jxDEk2YJ+AK-NzgjiGY1JoukGW7+mQtQeZT3n+3p+N9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55671 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339AbbCFQDd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Mar 2015 11:03:33 -0500
In-Reply-To: <CALZt5jxDEk2YJ+AK-NzgjiGY1JoukGW7+mQtQeZT3n+3p+N9dQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi!

[copying ceph-devel]

On Fri, 6 Mar 2015, Nicheal wrote:
> Hi Sage,
> 
> Cool for issue #3878, Duplicated pg_log write, which is post early in
> my issue #3244 and Single omap_setkeys transaction improve the
> performance in FileStore as in my previous testing (most of time cost
> in FileStore is in the transaction omap_setkeys).

I can't find #3244?

> Well, I think another performance issue is to the strategy of setattrs.
> Here is some kernel log achieve from xfs behavious.
> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
> ceph._(6), value =.259)
> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
> forks data: 1
> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
> di_anextents=0, di_forkoff=239
> 
> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
> ceph._(6), value =.259)
> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
> forks data: 2
> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=1,
> di_anextents=1, di_forkoff=239
> 
> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
> ceph._(6), value =.259)
> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
> forks data: 2
> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
> di_anextents=1, di_forkoff=239
> 
> typedef enum xfs_dinode_fmt {
> XFS_DINODE_FMT_DEV, /* xfs_dev_t */
> XFS_DINODE_FMT_LOCAL, /* bulk data */
> XFS_DINODE_FMT_EXTENTS, /* struct xfs_bmbt_rec */
> XFS_DINODE_FMT_BTREE, /* struct xfs_bmdr_block */
> XFS_DINODE_FMT_UUID /* uuid_t */
> } xfs_dinode_fmt_t;
> 
> while attr forks data = 2 means XFS_DINODE_FMT_EXTENTS (xattr is
> stored in extent format), while attr forks data =1 means
> XFS_DINODE_FMT_LOCAL(xattr is stored as inline attribute).
> 
> However, in most cases, xattr attribute is stored in extent, not
> inline. Please note that, I have already formatted the partition with
> -i size=2048.  when the number of xattrs is larger than 10, it uses
> XFS_DINODE_FMT_BTREE to accelerate key searching.

Did you by chance look at what size the typical xattrs are?  I expected 
that the usual _ and snapset attrs would be small enough to fit inline.. 
but if they're not then we should at a minimum adjust our recommendation 
on xfs inode size.

> So, in _setattr(), we may just get xattr_key by using chain_flistxattr
> instead of  _fgetattrs, which retrieve (key, value) pair, as value is
> exactly no use here. and furthermore, we may consider the strategies
> that we need move spill_out xattr to omap, while xfs only restricts
> that each xattr value < 64K and each xattr key < 255byte.  And
> duplicated read for XATTR_SPILL_OUT_NAME also occurs in:
> r = chain_fgetxattr(**fd, XATTR_SPILL_OUT_NAME, buf, sizeof(buf));
> r = _fgetattrs(**fd, inline_set);
> And I try to ignore the _fgetattrs() logic and just update xattr
> update in _setattr(), my ssd cluster will be improved about 2% - 3%
> performance.

I'm not quite following... do you have a patch we can look at?

> Another issue about an idea of recovery is showed in
> https://github.com/ceph/ceph/pull/3837
> Can you give some suggestion about that?

I think this direction has a lot of potential, although it will add a fair 
bit of complexity.  

I think you can avoid the truncate field and infer that from the dirtied 
interval and the new object size.  Need to look at the patch more closely 
still, though...

sage

