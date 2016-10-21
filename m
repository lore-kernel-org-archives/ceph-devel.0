From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bluestore performance degradation for the latest master
Date: Fri, 21 Oct 2016 19:27:59 +0300
Message-ID: <5c335169-9b11-66c9-2837-4508a6b6a60b@mirantis.com>
References: <BY2PR02MB3966F0CF4E7F1AD850C1E2BF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
 <0753374c-8909-596b-b060-fe249a027db4@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34387 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbcJUQ2C (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2016 12:28:02 -0400
Received: by mail-yw0-f172.google.com with SMTP id w3so101664784ywg.1
        for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2016 09:28:02 -0700 (PDT)
In-Reply-To: <0753374c-8909-596b-b060-fe249a027db4@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, in the second case we should never have encode_some returning true 
since we pass the full range.

Hence an assert there will be sufficient.

Will submit a patch shortly...


On 21.10.2016 19:09, Igor Fedotov wrote:
> IMHO one bug is at
>
> bool BlueStore::ExtentMap::update(Onode *o, KeyValueDB::Transaction t,
>                                   bool force)
> {
>
> ...
>
>       if (!force && len > g_conf->bluestore_extent_map_shard_max_size) {
> >>>>        inline_bl.clear();
>         return true;
>       }
>
> inline_bl should be preserved for proper functioning at
>
> void BlueStore::ExtentMap::reshard(Onode *o, uint64_t min_alloc_size)
> ...
>
>   unsigned bytes = 0;
>   if (o->onode.extent_map_shards.empty()) {
> >>>    bytes = inline_bl.length();
> Commenting out inline_bl.clear seems to be enough in this case.
>
> Second suspicious place is two lines above:
>
> bool BlueStore::ExtentMap::update(Onode *o, KeyValueDB::Transaction t,
>                                   bool force)
> {
>
> ...
>
>     if (inline_bl.length() == 0) {
>       unsigned n;
>       if (encode_some(0, OBJECT_MAX_SIZE, inline_bl, &n)) {
>     return true;
>       }
>
> Looks like encode_some might return true and leave inline_bl empty...
> Still thinking how to fix that...
>
> Thanks,
> Igor
>
> On 21.10.2016 18:29, Somnath Roy wrote:
>> Hi Sage,
>> I am profiling yesterday's master and seeing significant performance 
>> degradation both for bigger block seq write and 4K RW.
>>
>> See the write amp (~5X) it is introducing for 4K RW (with 
>> min_alloc_size = 4K)
>>
>> ----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
>> usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
>>   52   8  32   6   0   2|  98M  504M| 122M   81M|   0     0 | 318k  361k
>>   53   8  31   6   0   2|  91M  517M| 123M   83M|   0     0 | 358k  357k
>>   53   8  30   6   0   2|  90M  572M| 123M   81M|   0     0 | 339k  348k
>>   53   8  30   6   0   2|  95M  560M| 123M   81M|   0     0 | 321k  354k
>>   53   8  31   6   0   2|  97M  509M| 125M   82M|   0     0 | 315k  365k
>>   53   8  30   6   0   2|  87M  567M| 122M   81M|   0     0 | 322k  355k
>>   53   9  30   6   0   2|  92M  547M| 122M   81M|   0     0 | 345k  361k
>>
>> I think the reason is, it seems the extent sharding logic is broken. 
>> See the tx we are writing after 10 min run (4K rw on 100G image after 
>> 1M preconditioning). Onode key is 18K , no shard key..
>>
>> 2016-10-21 08:24:35.666549 7fd3ac701700 30 submit_transaction Rocksdb 
>> transaction:
>> Put( Prefix = M key = 
>> 0x0000000000000490'.0000000016.00000000000000019834' Value size = 182)
>> Put( Prefix = M key = 0x0000000000000490'._fastinfo' Value size = 186)
>> Put( Prefix = O key = 
>> 0x7f800000000000000139748c93217262'd_data.10156b8b4567.000000000000324c!='0xfffffffffffffffeffffffffffffffff'o' 
>> Value size = 18616)
>> Merge( Prefix = b key = 0x0000004590180000 Value size = 16)
>> Merge( Prefix = b key = 0x00000046df380000 Value size = 16)
>>
>> Thanks & Regards
>> Somnath
>> PLEASE NOTE: The information contained in this electronic mail 
>> message is intended only for the use of the designated recipient(s) 
>> named above. If the reader of this message is not the intended 
>> recipient, you are hereby notified that you have received this 
>> message in error and that any review, dissemination, distribution, or 
>> copying of this message is strictly prohibited. If you have received 
>> this communication in error, please notify the sender by telephone or 
>> e-mail (as shown above) immediately and destroy any and all copies of 
>> this message in your possession (whether hard copies or 
>> electronically stored copies).
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

