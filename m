From: Nicheal <zay11022@gmail.com>
Subject: Fwd: About _setattr() optimazation and recovery accelerate
Date: Tue, 10 Mar 2015 11:39:56 +0800
Message-ID: <CALZt5jyJkywh6ki580h9f8P=xcVJ5XpxaS3uO0JN5fmzs2GqAA@mail.gmail.com>
References: <CALZt5jxDEk2YJ+AK-NzgjiGY1JoukGW7+mQtQeZT3n+3p+N9dQ@mail.gmail.com>
	<alpine.DEB.2.00.1503060759190.18660@cobra.newdream.net>
	<CACJqLyaLHcpUHK5Cp9KKZAGvzGQ1-m7cMutn86ED3UfN2x5H0A@mail.gmail.com>
	<CALZt5jzCwdod0E-OVQ9SsxQHSiQi9ZuTyY=eXS9QQNsMNX_h_A@mail.gmail.com>
	<CACJqLyaUyKRdnJGSRv9xA5q8EeATnFPhKy_bjL8SuKMRYcxJqQ@mail.gmail.com>
	<CALZt5jzvu6DnHWe0fnNKs2ZN=+gA_41MZuBpebGaH2Ns5=q0AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45446 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbbCJDj5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 23:39:57 -0400
Received: by obbnt9 with SMTP id nt9so13504900obb.12
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 20:39:57 -0700 (PDT)
In-Reply-To: <CALZt5jzvu6DnHWe0fnNKs2ZN=+gA_41MZuBpebGaH2Ns5=q0AQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

>Yeah, I agree with this. So this is a little dive into XFS internal if
>we want to
>do better this xattrs. If xfs can export this or boundary of xattr
>type(btree, inline or list)
>would be great.
yeah, but need modified version of kernel and self-defined system
call. I do not prefer this way

>So do you have any detail about xfs xattr size client usage and how to
>optimize FileStore xattr decision? In other word, is it make sense
>that FileStore
>can aware of XFS xattr layout online or when initing FileStore and so
>we can decide the right way to store it
>at least.
Based on my analysis result, inline attribute should be the value <
254bytes if we make the inode size maximum(says -i size=2048 when
mkfs).
Before version 0.80.5, the value of ceph._ is less than 250bytes which
is definitely inline, while after version 0.87, the value of ceph._ is
259bytes so that it becomes extent formats. The reason is that
local_mtime and filestore_hobject_key_t is added.  One of the solution
is doing compression for object_info_t encoding value. Or clearing the
unused elements in object_info_t. Any other suggestions?
Anohter thing is that if we take snapshot, then we need to keep the
value of ceph.snapset < 254bytes, which means if there exits too many
fragment, do not record the overlaps.


Regards
Ning Yao


2015-03-09 13:35 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
> On Mon, Mar 9, 2015 at 1:26 PM, Nicheal <zay11022@gmail.com> wrote:
>> 2015-03-07 16:43 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>>> On Sat, Mar 7, 2015 at 12:03 AM, Sage Weil <sweil@redhat.com> wrote:
>>>> Hi!
>>>>
>>>> [copying ceph-devel]
>>>>
>>>> On Fri, 6 Mar 2015, Nicheal wrote:
>>>>> Hi Sage,
>>>>>
>>>>> Cool for issue #3878, Duplicated pg_log write, which is post early in
>>>>> my issue #3244 and Single omap_setkeys transaction improve the
>>>>> performance in FileStore as in my previous testing (most of time cost
>>>>> in FileStore is in the transaction omap_setkeys).
>>>>
>>>> I can't find #3244?
>>>
>>> I think it's https://github.com/ceph/ceph/pull/3244
>>>
>> Yeah, exactly it is.
>>>>
>>>>> Well, I think another performance issue is to the strategy of setattrs.
>>>>> Here is some kernel log achieve from xfs behavious.
>>>>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>>>>> ceph._(6), value =.259)
>>>>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>>>>> forks data: 1
>>>>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
>>>>> di_anextents=0, di_forkoff=239
>>>>>
>>>>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>>>>> ceph._(6), value =.259)
>>>>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>>>>> forks data: 2
>>>>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=1,
>>>>> di_anextents=1, di_forkoff=239
>>>>>
>>>>> Mar  6 17:19:37 ceph2 kernel: start_xfs_attr_set_int: name =
>>>>> ceph._(6), value =.259)
>>>>> Mar  6 17:19:37 ceph2 kernel: format of di_c data: 2, format of attr
>>>>> forks data: 2
>>>>> Mar  6 17:19:37 ceph2 kernel: di_extsize=0, di_nextents=0,
>>>>> di_anextents=1, di_forkoff=239
>>>>>
>>>>> typedef enum xfs_dinode_fmt {
>>>>> XFS_DINODE_FMT_DEV, /* xfs_dev_t */
>>>>> XFS_DINODE_FMT_LOCAL, /* bulk data */
>>>>> XFS_DINODE_FMT_EXTENTS, /* struct xfs_bmbt_rec */
>>>>> XFS_DINODE_FMT_BTREE, /* struct xfs_bmdr_block */
>>>>> XFS_DINODE_FMT_UUID /* uuid_t */
>>>>> } xfs_dinode_fmt_t;
>>>>>
>>>>> while attr forks data = 2 means XFS_DINODE_FMT_EXTENTS (xattr is
>>>>> stored in extent format), while attr forks data =1 means
>>>>> XFS_DINODE_FMT_LOCAL(xattr is stored as inline attribute).
>>>>>
>>>>> However, in most cases, xattr attribute is stored in extent, not
>>>>> inline. Please note that, I have already formatted the partition with
>>>>> -i size=2048.  when the number of xattrs is larger than 10, it uses
>>>>> XFS_DINODE_FMT_BTREE to accelerate key searching.
>>>>
>>>> Did you by chance look at what size the typical xattrs are?  I expected
>>>> that the usual _ and snapset attrs would be small enough to fit inline..
>>>> but if they're not then we should at a minimum adjust our recommendation
>>>> on xfs inode size.
>>>>
>>>>> So, in _setattr(), we may just get xattr_key by using chain_flistxattr
>>>>> instead of  _fgetattrs, which retrieve (key, value) pair, as value is
>>>>> exactly no use here. and furthermore, we may consider the strategies
>>>>> that we need move spill_out xattr to omap, while xfs only restricts
>>>>> that each xattr value < 64K and each xattr key < 255byte.  And
>>>>> duplicated read for XATTR_SPILL_OUT_NAME also occurs in:
>>>>> r = chain_fgetxattr(**fd, XATTR_SPILL_OUT_NAME, buf, sizeof(buf));
>>>>> r = _fgetattrs(**fd, inline_set);
>>>>> And I try to ignore the _fgetattrs() logic and just update xattr
>>>>> update in _setattr(), my ssd cluster will be improved about 2% - 3%
>>>>> performance.
>>>>
>>>> I'm not quite following... do you have a patch we can look at?
>>>
>>> I think his meaning is that we can use minimal xattr attrs and avoid
>>> xattr-chains but using omap.
>>>
>> Yes, make a basic assumption, for example, we just allow user.ceph._
>> and user.ceph.snapset as xattr attrs. Then we may simplify the logic a
>> lots. Actually, the purpose to implement automatic decision to
>> redirect the xattr into omap is served for cephfs, which may save user
>> defined xattrs.  For rbd case, no this problem since it is just two
>> xattr attrs (user.ceph._  and user.ceph.snapset), and for ecpool, one
>> more for hash, which is predictable. Furthermore, I prefer to stop
>> recording user.ceph.snapset when there is too much fragment. There is
>> a huge performance penalty when user.ceph.snapset is large.
>> Since both of Extent and BTREE layout is remote xattr, not inline
>> xattr in xfs, I think using omap will not cause much performance
>> penalty, especially for HDD based FileStore.
>
> Yeah, I agree with this. So this is a little dive into XFS internal if
> we want to
> do better this xattrs. If xfs can export this or boundary of xattr
> type(btree, inline or list)
> would be great.
>
> So do you have any detail about xfs xattr size client usage and how to
> optimize FileStore xattr decision? In other word, is it make sense
> that FileStore
> can aware of XFS xattr layout online or when initing FileStore and so
> we can decide the right way to store it
> at least.
>>
>>>>
>>>>> Another issue about an idea of recovery is showed in
>>>>> https://github.com/ceph/ceph/pull/3837
>>>>> Can you give some suggestion about that?
>>>>
>>>> I think this direction has a lot of potential, although it will add a fair
>>>> bit of complexity.
>>>>
>>>> I think you can avoid the truncate field and infer that from the dirtied
>>>> interval and the new object size.  Need to look at the patch more closely
>>>> still, though...
>> Uh, Yeah, the purpose I use truncate field is to deal with the situation below:
>>     1) A is down
>>     2) B do the truncate operation to truncate the entirely 4M object
>> to 3M, then do some  write may extend the object to 4M again, but with
>> lots of holes between [3M - 4M]
>>     3) calling recovery will find two objects are both 4M so that
>> there is no need to truncate, but a partially data recovery between
>> [3M - 4M] may cause data inconsistency, so we also need to do a
>> truncate operation for the object in A.
>>     We can still infer those cases if we mark [3M-4M] dirty when
>> truncate occurs in B, while it will be incompatible with sparse
>> read/write since we need to read out all holes between [3M-4M] and
>> write it to A. How do you think that? @Haomai Wang.
>>
>>>
>>> For xattr and omap optimization I expect this PR mostly
>>> https://github.com/ceph/ceph/pull/2972
>>>
>>>
>> This is patch submitted by my teammate. But we do more, this is one of
>> the patch we exactly confirm that it can work well under any
>> circumstance(either HDD or SSD). And we do some other effects liking
>> moving pg_info and epoch to per pg xattr attrs. It works better better
>> under SSD environment but not HDD. Writing data in Omap will be
>> costing since huge write amplification. It exhausts bandwidth of the
>> SSD, especially under 4k-write cases (every write operation need to
>> update pg_info and epoch to Omap). But using file-system xattr attrs
>> can benefit from the system page cache and update pg_info once when we
>> call sync().
>> An alternative is that we keep the newest pg_info on-disk content in
>> cache and flush them on disk when we before call sync (sync_entry in
>> FileStore) and still use omap to store pg_info.
>>
>> we actually do lots of affects and testing on the performance on how
>> to dealing with xattrs. Under SSD cluster, it is much better to store
>> information as extent attribute of a file-system, while under HDD
>> cluster, omap always performs better because remote extent attribute
>> need to read or store the contents of xattr in other disk blocks, not
>> containing in inode. So when we call open("file_name"), it just load
>> the inode but the value of xattr is not load into memory and we need a
>> second disk read operation when we call getattr(), which becomes a
>> random read/write issue for HDD. Also double write operations when
>> calling sync(), omap use LOG to bypass those effects.
>>
>>>>
>>>> sage
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>
>
>
> --
> Best Regards,
>
> Wheat
