From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About _setattr() optimazation and recovery accelerate
Date: Sat, 7 Mar 2015 16:43:17 +0800
Message-ID: <CACJqLyaLHcpUHK5Cp9KKZAGvzGQ1-m7cMutn86ED3UfN2x5H0A@mail.gmail.com>
References: <CALZt5jxDEk2YJ+AK-NzgjiGY1JoukGW7+mQtQeZT3n+3p+N9dQ@mail.gmail.com>
	<alpine.DEB.2.00.1503060759190.18660@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42629 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbCGInS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Mar 2015 03:43:18 -0500
Received: by pdbfl12 with SMTP id fl12so50021506pdb.9
        for <ceph-devel@vger.kernel.org>; Sat, 07 Mar 2015 00:43:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1503060759190.18660@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nicheal <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Mar 7, 2015 at 12:03 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi!
>
> [copying ceph-devel]
>
> On Fri, 6 Mar 2015, Nicheal wrote:
>> Hi Sage,
>>
>> Cool for issue #3878, Duplicated pg_log write, which is post early in
>> my issue #3244 and Single omap_setkeys transaction improve the
>> performance in FileStore as in my previous testing (most of time cost
>> in FileStore is in the transaction omap_setkeys).
>
> I can't find #3244?

I think it's https://github.com/ceph/ceph/pull/3244

>
>> Well, I think another performance issue is to the strategy of setattrs.
>> Here is some kernel log achieve from xfs behavious.
>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>> ceph._(6), value =.259)
>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>> forks data: 1
>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
>> di_anextents=0, di_forkoff=239
>>
>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>> ceph._(6), value =.259)
>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>> forks data: 2
>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=1,
>> di_anextents=1, di_forkoff=239
>>
>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>> ceph._(6), value =.259)
>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>> forks data: 2
>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
>> di_anextents=1, di_forkoff=239
>>
>> typedef enum xfs_dinode_fmt {
>> XFS_DINODE_FMT_DEV, /* xfs_dev_t */
>> XFS_DINODE_FMT_LOCAL, /* bulk data */
>> XFS_DINODE_FMT_EXTENTS, /* struct xfs_bmbt_rec */
>> XFS_DINODE_FMT_BTREE, /* struct xfs_bmdr_block */
>> XFS_DINODE_FMT_UUID /* uuid_t */
>> } xfs_dinode_fmt_t;
>>
>> while attr forks data = 2 means XFS_DINODE_FMT_EXTENTS (xattr is
>> stored in extent format), while attr forks data =1 means
>> XFS_DINODE_FMT_LOCAL(xattr is stored as inline attribute).
>>
>> However, in most cases, xattr attribute is stored in extent, not
>> inline. Please note that, I have already formatted the partition with
>> -i size=2048.  when the number of xattrs is larger than 10, it uses
>> XFS_DINODE_FMT_BTREE to accelerate key searching.
>
> Did you by chance look at what size the typical xattrs are?  I expected
> that the usual _ and snapset attrs would be small enough to fit inline..
> but if they're not then we should at a minimum adjust our recommendation
> on xfs inode size.
>
>> So, in _setattr(), we may just get xattr_key by using chain_flistxattr
>> instead of  _fgetattrs, which retrieve (key, value) pair, as value is
>> exactly no use here. and furthermore, we may consider the strategies
>> that we need move spill_out xattr to omap, while xfs only restricts
>> that each xattr value < 64K and each xattr key < 255byte.  And
>> duplicated read for XATTR_SPILL_OUT_NAME also occurs in:
>> r = chain_fgetxattr(**fd, XATTR_SPILL_OUT_NAME, buf, sizeof(buf));
>> r = _fgetattrs(**fd, inline_set);
>> And I try to ignore the _fgetattrs() logic and just update xattr
>> update in _setattr(), my ssd cluster will be improved about 2% - 3%
>> performance.
>
> I'm not quite following... do you have a patch we can look at?

I think his meaning is that we can use minimal xattr attrs and avoid
xattr-chains but using omap.

>
>> Another issue about an idea of recovery is showed in
>> https://github.com/ceph/ceph/pull/3837
>> Can you give some suggestion about that?
>
> I think this direction has a lot of potential, although it will add a fair
> bit of complexity.
>
> I think you can avoid the truncate field and infer that from the dirtied
> interval and the new object size.  Need to look at the patch more closely
> still, though...

For xattr and omap optimization I expect this PR mostly
https://github.com/ceph/ceph/pull/2972


>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
