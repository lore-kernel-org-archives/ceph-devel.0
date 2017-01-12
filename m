From: Mark Nelson <mnelson@redhat.com>
Subject: Re: resharding behavior in bluestore
Date: Thu, 12 Jan 2017 11:26:02 -0600
Message-ID: <40920eb1-6cd6-ada4-01a4-17b9daa9d14c@redhat.com>
References: <d7927e46-c340-0f41-7a83-a290aa628944@redhat.com>
 <5E3E05AED7F0F044904275810D0CB465054C6A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdALR0D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 12:26:03 -0500
In-Reply-To: <5E3E05AED7F0F044904275810D0CB465054C6A@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 01/12/2017 10:37 AM, Somnath Roy wrote:
> Mark,
> Could you check what condition it is triggering reshard for you ?
> Under following circumstances it could trigger reshard.
>
> 1. Shard size > bluestore_extent_map_shard_max_size
>
> 2. Shard size < bluestore_extent_map_shard_min_size and non-last shard
>
> 3. And from BlueStore::Extent *BlueStore::ExtentMap::set_lextent() if extents spans shard

 From the code, it looks to me like the only place where needs_reshard 
gets set to true is in set_lextent() when spans_shard is true:

if (!needs_reshard && spans_shard(logical_offset, length)) {
   needs_reshard = true;
}

spans_shard basically just looks for the shard at the given offset, the 
checks that the offset+length doesn't overlap with the next shard's offset.

Mark

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Thursday, January 12, 2017 7:32 AM
> To: ceph-devel
> Subject: resharding behavior in bluestore
>
> Hi All,
>
> I spent some time this week digging into the resharding code in bluestore.  I confess I still don't totally understand how it is supposed to work with regard to min_alloc_size, however I suspect that the current behavior is likely not expected.  To determine this, I added logging to dump the shard_info vector before and after the swap in BlueStore::ExtentMap::reshard.
>
> No matter what settings I tested with, the initial reshard always goes from 0 shards to 8, always with the exact same offsets ala:
>
>> 2017-01-11 16:44:39.359340 7f92d6cbe700  6
>> bluestore.onode(0x5644152dfb80) *** old shards ***
>> 2017-01-11 16:44:39.359356 7f92d6cbe700  6
>> bluestore.onode(0x5644152dfb80) *** new shards ***
>> 2017-01-11 16:44:39.359358 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 0, offset: 0, bytes: 0
>> 2017-01-11 16:44:39.359360 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 1, offset: 524288, bytes: 0
>> 2017-01-11 16:44:39.359362 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 2, offset: 1048576, bytes: 0
>> 2017-01-11 16:44:39.359364 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 3, offset: 1572864, bytes: 0
>> 2017-01-11 16:44:39.359365 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 4, offset: 2097152, bytes: 0
>> 2017-01-11 16:44:39.359366 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 5, offset: 2621440, bytes: 0
>> 2017-01-11 16:44:39.359367 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 6, offset: 3145728, bytes: 0
>> 2017-01-11 16:44:39.359368 7f92d6cbe700  1
>> bluestore.onode(0x5644152dfb80) shard: 7, offset: 3670016, bytes: 0
>
> When a 16k min_alloc size is used, subsequent reshards always reshard into 8 shards with the same offsets:
>
>> 2017-01-11 17:00:00.000835 7f92d54bb700  6
>> bluestore.onode(0x56446937ef80) *** old shards ***
>> 2017-01-11 17:00:00.000839 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 0, offset: 0, bytes: 529
>> 2017-01-11 17:00:00.000841 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 1, offset: 524288, bytes: 531
>> 2017-01-11 17:00:00.000843 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 2, offset: 1048576, bytes: 531
>> 2017-01-11 17:00:00.000844 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 3, offset: 1572864, bytes: 531
>> 2017-01-11 17:00:00.000846 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 4, offset: 2097152, bytes: 531
>> 2017-01-11 17:00:00.000847 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 5, offset: 2621440, bytes: 531
>> 2017-01-11 17:00:00.000849 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 6, offset: 3145728, bytes: 531
>> 2017-01-11 17:00:00.000850 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 7, offset: 3670016, bytes: 531
>> 2017-01-11 17:00:00.000852 7f92d54bb700  6
>> bluestore.onode(0x56446937ef80) *** new shards ***
>> 2017-01-11 17:00:00.000853 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 0, offset: 0, bytes: 0
>> 2017-01-11 17:00:00.000855 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 1, offset: 524288, bytes: 0
>> 2017-01-11 17:00:00.000856 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 2, offset: 1048576, bytes: 0
>> 2017-01-11 17:00:00.000858 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 3, offset: 1572864, bytes: 0
>> 2017-01-11 17:00:00.000859 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 4, offset: 2097152, bytes: 0
>> 2017-01-11 17:00:00.000860 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 5, offset: 2621440, bytes: 0
>> 2017-01-11 17:00:00.000862 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 6, offset: 3145728, bytes: 0
>> 2017-01-11 17:00:00.000863 7f92d54bb700  1
>> bluestore.onode(0x56446937ef80) shard: 7, offset: 3670016, bytes: 0
>>
>
> This is true no matter what the ExtentMap max/target shard sizes are.
> However with smaller sizes, this reshard process happens far more often.
>   With 4K min_alloc_size, the initial reshard still goes from 0 to 8, but subsequent reshards are more as expected:
>
>> 2017-01-12 09:35:41.923467 7ff4e4e28700  6
>> bluestore.onode(0x55fcc45e8a00) *** old shards ***
>> 2017-01-12 09:35:41.923484 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 0, offset: 0, bytes: 529
>> 2017-01-12 09:35:41.923487 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 1, offset: 524288, bytes: 531
>> 2017-01-12 09:35:41.923488 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 2, offset: 1048576, bytes: 531
>> 2017-01-12 09:35:41.923489 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 3, offset: 1572864, bytes: 531
>> 2017-01-12 09:35:41.923491 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 4, offset: 2097152, bytes: 531
>> 2017-01-12 09:35:41.923491 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 5, offset: 2621440, bytes: 531
>> 2017-01-12 09:35:41.923495 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 6, offset: 3145728, bytes: 531
>> 2017-01-12 09:35:41.923496 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 7, offset: 3670016, bytes: 531
>> 2017-01-12 09:35:41.923499 7ff4e4e28700  6
>> bluestore.onode(0x55fcc45e8a00) *** new shards ***
>> 2017-01-12 09:35:41.923500 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 0, offset: 0, bytes: 0
>> 2017-01-12 09:35:41.923501 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 1, offset: 520192, bytes: 0
>> 2017-01-12 09:35:41.923501 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 2, offset: 528384, bytes: 0
>> 2017-01-12 09:35:41.923502 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 3, offset: 1048576, bytes: 0
>> 2017-01-12 09:35:41.923503 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 4, offset: 1572864, bytes: 0
>> 2017-01-12 09:35:41.923504 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 5, offset: 2097152, bytes: 0
>> 2017-01-12 09:35:41.923505 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 6, offset: 2621440, bytes: 0
>> 2017-01-12 09:35:41.923506 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 7, offset: 3145728, bytes: 0
>> 2017-01-12 09:35:41.923507 7ff4e4e28700  1
>> bluestore.onode(0x55fcc45e8a00) shard: 8, offset: 3670016, bytes: 0
>
> larger extentmap shard target/max sizes result in much fewer reshards, while smaller values result in very rapid resharding and much larger shard counts as expected.  Also, you can see here that each reshard only produces marginally different offsets.  Leaving the old offsets in place and inserting new shards in the middle (or having a tree structure) I think would result in far higher reshard performance as Sage suggested.
>
> This is what I've got right now.  More to come.
>
> Mark
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml=
>
