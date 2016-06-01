From: Haomai Wang <haomai@xsky.com>
Subject: Re: RocksDB Incorrect API Usage
Date: Wed, 1 Jun 2016 10:38:23 +0800
Message-ID: <CACJqLyY=5oFP+5i3KLdCcYO5N9pze69ke7mqb1kX6q9KwbBZww@mail.gmail.com>
References: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
	<3F3468645DC82146857A5E1C91E23F4B1B2A3EE1@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybKJo+otdX0SU8uOqa6N6POJ-Wgb19SrFmzsE_94Eo2gA@mail.gmail.com>
	<3F3468645DC82146857A5E1C91E23F4B1B2A3FA5@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0112.outbound.protection.outlook.com ([104.47.124.112]:47360
	"EHLO APC01-HK2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751287AbcFACig (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 22:38:36 -0400
Received: by mail-vk0-f51.google.com with SMTP id c189so8559591vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 19:38:31 -0700 (PDT)
In-Reply-To: <3F3468645DC82146857A5E1C91E23F4B1B2A3FA5@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo <jianjian.huo@samsung.com>
Cc: Sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 1, 2016 at 3:40 AM, Jianjian Huo <jianjian.huo@samsung.com> wrote:
>
> On Tue, May 31, 2016 at 11:12 AM, Haomai Wang <haomai@xsky.com> wrote:
>> On Wed, Jun 1, 2016 at 2:08 AM, Jianjian Huo <jianjian.huo@samsung.com> wrote:
>>> Hi Haomai,
>>>
>>> I noticed this as well, and made same changes to RocksDBStore in this PR last week:
>>> https://github.com/ceph/ceph/pull/9215
>>>
>>> One thing which is even worse,  seek will bypass row cache, so kv pairs won't be able to be cached in row cache.
>>> I am working to benchmark the performance impact, will publish the results after I am done this week.
>>
>> Oh, cool! I think you can cherry-pick my another leveldb fix.
>
> No problem, I will do that.
>>
>> BTW, do you pay an attention to prefix seek api? I think it will be
>> more suitable than column family in ceph case. If we can have
>> well-defined prefix rule, we can make most of range query cheaper!
>
> When keys with same prefix are stored in their own SST files(CF case), even seeking without prefix will be faster than seeking with prefix but mixed with different prefixed keys?

From my current view, prefix could be more flexible. For example, each
rgw bucket index could use one prefix to make each bucket index object
seek separated. For CF, it would be too heavry.

> I am not sure what optimization prefix seek will use internally for block based format, but to me, it's hard to beat the case when you only have one prefixed keys stored separately.
>>
>>>
>>> Jianjian
>>>
>>> On Tue, May 31, 2016 at 9:49 AM, Haomai Wang <haomai@xsky.com> wrote:
>>>> Hi Sage and Mark,
>>>>
>>>> As mentioned in BlueStore standup, I found rocksdb iterator *Seek*
>>>> won't use bloom filter like *Get*.
>>>>
>>>> *Get* impl: it will look at filter firstly
>>>> https://github.com/facebook/rocksdb/blob/master/table/block_based_table_reader.cc#L1369
>>>>
>>>> Iterator *Seek*: it will do binary search, by default we don't specify
>>>> prefix feature(https://github.com/facebook/rocksdb/wiki/Prefix-Seek-API-Changes).
>>>> https://github.com/facebook/rocksdb/blob/master/table/block.cc#L94
>>>>
>>>> So I use a simple tests:
>>>>
>>>> ./db_bench -num 10000000  -benchmarks fillbatch
>>>> fill the db firstly with 1000w records.
>>>>
>>>> ./db_bench -use_existing_db  -benchmarks readrandomfast
>>>> readrandomfast case will use *Get* API to retrive data
>>>>
>>>> [root@hunter-node2 rocksdb]# ./db_bench -use_existing_db  -benchmarks
>>>> readrandomfast
>>>>
>>>> LevelDB:    version 4.3
>>>> Date:       Wed Jun  1 00:29:16 2016
>>>> CPU:        32 * Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
>>>> CPUCache:   20480 KB
>>>> Keys:       16 bytes each
>>>> Values:     100 bytes each (50 bytes after compression)
>>>> Entries:    1000000
>>>> Prefix:    0 bytes
>>>> Keys per prefix:    0
>>>> RawSize:    110.6 MB (estimated)
>>>> FileSize:   62.9 MB (estimated)
>>>> Writes per second: 0
>>>> Compression: Snappy
>>>> Memtablerep: skip_list
>>>> Perf Level: 0
>>>> WARNING: Assertions are enabled; benchmarks unnecessarily slow
>>>> ------------------------------------------------
>>>> DB path: [/tmp/rocksdbtest-0/dbbench]
>>>> readrandomfast :       4.570 micros/op 218806 ops/sec; (1000100 of
>>>> 1000100 found, issued 46639 non-exist keys)
>>>>
>>>> ===========================
>>>> then I modify readrandomfast to use Iterator API[0]:
>>>>
>>>> [root@hunter-node2 rocksdb]# ./db_bench -use_existing_db  -benchmarks
>>>> readrandomfast
>>>> LevelDB:    version 4.3
>>>> Date:       Wed Jun  1 00:33:03 2016
>>>> CPU:        32 * Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
>>>> CPUCache:   20480 KB
>>>> Keys:       16 bytes each
>>>> Values:     100 bytes each (50 bytes after compression)
>>>> Entries:    1000000
>>>> Prefix:    0 bytes
>>>> Keys per prefix:    0
>>>> RawSize:    110.6 MB (estimated)
>>>> FileSize:   62.9 MB (estimated)
>>>> Writes per second: 0
>>>> Compression: Snappy
>>>> Memtablerep: skip_list
>>>> Perf Level: 0
>>>> WARNING: Assertions are enabled; benchmarks unnecessarily slow
>>>> ------------------------------------------------
>>>> DB path: [/tmp/rocksdbtest-0/dbbench]
>>>> readrandomfast :      45.188 micros/op 22129 ops/sec; (1000100 of
>>>> 1000100 found, issued 46639 non-exist keys)
>>>>
>>>>
>>>> 45.18 us/op vs 4.57us/op!
>>>>
>>>> The test can be repeated and easy to do! Plz correct if I'm doing
>>>> foolish thing I'm not aware..
>>>>
>>>> So I proposal this PR: https://github.com/ceph/ceph/pull/9411
>>>>
>>>> We still can make further improvements by scanning all iterate usage
>>>> to make it better!
>>>>
>>>> [0]:
>>>> --- a/db/db_bench.cc
>>>> +++ b/db/db_bench.cc
>>>> @@ -2923,14 +2923,12 @@ class Benchmark {
>>>>          int64_t key_rand = thread->rand.Next() & (pot - 1);
>>>>          GenerateKeyFromInt(key_rand, FLAGS_num, &key);
>>>>          ++read;
>>>> -        auto status = db->Get(options, key, &value);
>>>> -        if (status.ok()) {
>>>> -          ++found;
>>>> -        } else if (!status.IsNotFound()) {
>>>> -          fprintf(stderr, "Get returned an error: %s\n",
>>>> -                  status.ToString().c_str());
>>>> -          abort();
>>>> -        }
>>>> +        Iterator* iter = db->NewIterator(options);
>>>> +      iter->Seek(key);
>>>> +      if (iter->Valid() && iter->key().compare(key) == 0) {
>>>> +        found++;
>>>> +      }
>>>> +
>>>>          if (key_rand >= FLAGS_num) {
>>>>            ++nonexist;
>>>>          }
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
