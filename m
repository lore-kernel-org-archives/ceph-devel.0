From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: First attempt at rocksdb monitor store stress testing
Date: Fri, 25 Jul 2014 07:08:08 -0500
Message-ID: <53D248A8.9000904@inktank.com>
References: <53D041D3.3080203@inktank.com> <75674D092A819E4189E91166C74CB90D013F2ACA@shsmsx102.ccr.corp.intel.com> <53D0EA63.10107@inktank.com> <53D19A92.3010000@inktank.com> <75674D092A819E4189E91166C74CB90D013F30D4@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42705 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbaGYOls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 10:41:48 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so3733002ieb.4
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 07:41:47 -0700 (PDT)
In-Reply-To: <75674D092A819E4189E91166C74CB90D013F30D4@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/24/2014 08:28 PM, Shu, Xinxin wrote:
> Hi mark,
>
> I am looking forward to your results on SSDs .

Me too!

> rocksdb generates a crc of data to be written , this cannot be switch off (but can be subsititued with xxhash),  there are two options , Option. verify_checksums_in_compaction and ReadOptions. verify_checksums,  If we disable these two options , i think cpu usage will goes down . If we use universal compaction , this is not friendly with read operation.

I'm wondering if it might not be so bad for us given the kind of work 
the mon does.  We write out a lot of maps and incrementals, but I don't 
think the mon goes back and updates objects very often.  Assuming I 
understand how universal vs level compaction works (I might not!) this 
should help contain the number of SST files that objects get spread 
across which causes all of the extra read seeks with universal compaction.

>
> Btw , can you list your rocksdb configuration?

Sure, right now it's all the stock defaults in config_opts except the 
new option I added for universal compaction.  I am hoping I can run some 
more tests today and this weekend with tuned ones.

>
> Cheers,
> xinxin
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Friday, July 25, 2014 7:45 AM
> To: Shu, Xinxin; ceph-devel@vger.kernel.org
> Subject: Re: First attempt at rocksdb monitor store stress testing
>
> Earlier today I modified the rocksdb options so I could enable universal compaction.  Over all performance is lower but I don't see the hang/stall in the middle of the test either.  Instead the disk is basically pegged with 100% writes.  I suspect average latency is higher than leveldb, but the highest latency is about 5-6s while we were seeing 30s spikes for leveldb with levelled (heh) compaction.
>
> I haven't done much tuning either way yet.  It may be that if we keep level 0 and level 1 roughly the same size we can reduce stalls in the levelled setups.  It will also be interesting to see what happens in these tests on SSDs.
>
> Mark
>
> On 07/24/2014 06:13 AM, Mark Nelson wrote:
>> Hi Xinxin,
>>
>> Thanks! I wonder as well if it might be interesting to expose the
>> options related to universal compaction?  It looks like rocksdb
>> provides a lot of interesting knobs you can adjust!
>>
>> Mark
>>
>> On 07/24/2014 12:08 AM, Shu, Xinxin wrote:
>>> Hi mark,
>>>
>>> I think this maybe related to 'verify_checksums' config option ,when
>>> ReadOptions is initialized, default this option is  true , all data
>>> read from underlying storage will be verified against corresponding
>>> checksums,  however,  this option cannot be configured in wip-rocksdb
>>> branch. I will modify code to make this option configurable .
>>>
>>> Cheers,
>>> xinxin
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>>> Sent: Thursday, July 24, 2014 7:14 AM
>>> To: ceph-devel@vger.kernel.org
>>> Subject: First attempt at rocksdb monitor store stress testing
>>>
>>> Hi Guys,
>>>
>>> So I've been interested lately in leveldb 99th percentile latency
>>> (and the amount of write amplification we are seeing) with leveldb.
>>> Joao mentioned he has written a tool called mon-store-stress in
>>> wip-leveldb-misc to try to provide a means to roughly guess at what's
>>> happening on the mons under heavy load.  I cherry-picked it over to
>>> wip-rocksdb and after a couple of hacks was able to get everything
>>> built and running with some basic tests.  There was little tuning
>>> done and I don't know how realistic this workload is, so don't assume
>>> this means anything yet, but some initial results are here:
>>>
>>> http://nhm.ceph.com/mon-store-stress/First%20Attempt.pdf
>>>
>>> Command that was used to run the tests:
>>>
>>> ./ceph-test-mon-store-stress --mon-keyvaluedb <leveldb|rocksdb>
>>> --write-min-size 50K --write-max-size 2M --percent-write 70
>>> --percent-read 30 --keep-state --test-seed 1406137270 --stop-at 5000
>>> foo
>>>
>>> The most interesting bit right now is that rocksdb seems to be
>>> hanging in the middle of the test (left it running for several
>>> hours).  CPU usage on one core was quite high during the hang.
>>> Profiling using perf with dwarf symbols I see:
>>>
>>> -  49.14%  ceph-test-mon-s  ceph-test-mon-store-stress  [.] unsigned
>>> int
>>> rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned
>>> int, char const*, unsigned long)
>>>       - unsigned int
>>> rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned
>>> int, char const*, unsigned long)
>>>            51.70%
>>> rocksdb::ReadBlockContents(rocksdb::RandomAccessFile*,
>>> rocksdb::Footer const&, rocksdb::ReadOptions const&,
>>> rocksdb::BlockHandle const&, rocksdb::BlockContents*, rocksdb::Env*,
>>> bool)
>>>            48.30%
>>> rocksdb::BlockBasedTableBuilder::WriteRawBlock(rocksdb::Slice const&,
>>> rocksdb::CompressionType, rocksdb::BlockHandle*)
>>>
>>> Not sure what's going on yet, may need to try to enable
>>> logging/debugging in rocksdb.  Thoughts/Suggestions welcome. :)
>>>
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>

