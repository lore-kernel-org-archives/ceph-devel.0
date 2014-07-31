From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: First attempt at rocksdb monitor store stress testing
Date: Thu, 31 Jul 2014 07:30:55 -0500
Message-ID: <53DA36FF.4040803@inktank.com>
References: <53D041D3.3080203@inktank.com> <75674D092A819E4189E91166C74CB90D013F2ACA@shsmsx102.ccr.corp.intel.com> <53D0EA63.10107@inktank.com> <53D19A92.3010000@inktank.com> <75674D092A819E4189E91166C74CB90D013F30D4@shsmsx102.ccr.corp.intel.com> <53D28145.2020504@inktank.com> <75674D092A819E4189E91166C74CB90D013F3CD6@shsmsx102.ccr.corp.intel.com> <53D92CBF.3010403@inktank.com> <75674D092A819E4189E91166C74CB90D014009AD@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53742 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 08:30:54 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so3665111iec.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 05:30:53 -0700 (PDT)
In-Reply-To: <75674D092A819E4189E91166C74CB90D014009AD@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/30/2014 08:46 PM, Shu, Xinxin wrote:
> Hi mark,
> Which way do you used to set a higher limitation?  use 'ulimit' command or enlarge rocksdb_max_open_files config option?

ulimit command, though you might be able to limit the max open files in 
rocksdb to be smaller than the default too.  Setting a higher ulimit is 
what we already do for ceph processes so I just mimicked our existing 
solution.

>
> Cheers,
> xinxin
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Thursday, July 31, 2014 1:35 AM
> To: Shu, Xinxin; ceph-devel@vger.kernel.org
> Subject: Re: First attempt at rocksdb monitor store stress testing
>
> Hi Xinxin,
>
> Yes, that did work.  I was able to observe the log and figure out the
> stall:  Too many files open in the level0->level1 compaction thread.
> Similar to the issue that we've seen the past with leveldb.  Setting a higher ulimit fixed the problem.  With leveled compaction on spinning disks I do see latency spikes but at first glance they do not appear to be as bad as with leveldb.  I will now run some longer tests.
>
> Mark
>
> On 07/27/2014 11:45 PM, Shu, Xinxin wrote:
>> Hi mark,
>>
>> I tested this option on my setup , same issue happened , I will dig into it , if you want to get info log , there is a workaround, set this option to none:
>>
>> Rocksdb_log = ""
>>
>> Cheers,
>> xinxin
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>> Sent: Saturday, July 26, 2014 12:10 AM
>> To: Shu, Xinxin; ceph-devel@vger.kernel.org
>> Subject: Re: First attempt at rocksdb monitor store stress testing
>>
>> Hi Xinxin,
>>
>> I'm trying to enable the rocksdb log file as described in config_opts using:
>>
>> rocksdb_log = <path to log file>
>>
>> The file gets created but is empty.  Any ideas?
>>
>> Mark
>>
>> On 07/24/2014 08:28 PM, Shu, Xinxin wrote:
>>> Hi mark,
>>>
>>> I am looking forward to your results on SSDs .
>>> rocksdb generates a crc of data to be written , this cannot be switch off (but can be subsititued with xxhash),  there are two options , Option. verify_checksums_in_compaction and ReadOptions. verify_checksums,  If we disable these two options , i think cpu usage will goes down . If we use universal compaction , this is not friendly with read operation.
>>>
>>> Btw , can you list your rocksdb configuration?
>>>
>>> Cheers,
>>> xinxin
>>>
>>> -----Original Message-----
>>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>>> Sent: Friday, July 25, 2014 7:45 AM
>>> To: Shu, Xinxin; ceph-devel@vger.kernel.org
>>> Subject: Re: First attempt at rocksdb monitor store stress testing
>>>
>>> Earlier today I modified the rocksdb options so I could enable universal compaction.  Over all performance is lower but I don't see the hang/stall in the middle of the test either.  Instead the disk is basically pegged with 100% writes.  I suspect average latency is higher than leveldb, but the highest latency is about 5-6s while we were seeing 30s spikes for leveldb with levelled (heh) compaction.
>>>
>>> I haven't done much tuning either way yet.  It may be that if we keep level 0 and level 1 roughly the same size we can reduce stalls in the levelled setups.  It will also be interesting to see what happens in these tests on SSDs.
>>>
>>> Mark
>>>
>>> On 07/24/2014 06:13 AM, Mark Nelson wrote:
>>>> Hi Xinxin,
>>>>
>>>> Thanks! I wonder as well if it might be interesting to expose the
>>>> options related to universal compaction?  It looks like rocksdb
>>>> provides a lot of interesting knobs you can adjust!
>>>>
>>>> Mark
>>>>
>>>> On 07/24/2014 12:08 AM, Shu, Xinxin wrote:
>>>>> Hi mark,
>>>>>
>>>>> I think this maybe related to 'verify_checksums' config option
>>>>> ,when ReadOptions is initialized, default this option is  true ,
>>>>> all data read from underlying storage will be verified against
>>>>> corresponding checksums,  however,  this option cannot be
>>>>> configured in wip-rocksdb branch. I will modify code to make this option configurable .
>>>>>
>>>>> Cheers,
>>>>> xinxin
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>>>>> Sent: Thursday, July 24, 2014 7:14 AM
>>>>> To: ceph-devel@vger.kernel.org
>>>>> Subject: First attempt at rocksdb monitor store stress testing
>>>>>
>>>>> Hi Guys,
>>>>>
>>>>> So I've been interested lately in leveldb 99th percentile latency
>>>>> (and the amount of write amplification we are seeing) with leveldb.
>>>>> Joao mentioned he has written a tool called mon-store-stress in
>>>>> wip-leveldb-misc to try to provide a means to roughly guess at
>>>>> what's happening on the mons under heavy load.  I cherry-picked it
>>>>> over to wip-rocksdb and after a couple of hacks was able to get
>>>>> everything built and running with some basic tests.  There was
>>>>> little tuning done and I don't know how realistic this workload is,
>>>>> so don't assume this means anything yet, but some initial results are here:
>>>>>
>>>>> http://nhm.ceph.com/mon-store-stress/First%20Attempt.pdf
>>>>>
>>>>> Command that was used to run the tests:
>>>>>
>>>>> ./ceph-test-mon-store-stress --mon-keyvaluedb <leveldb|rocksdb>
>>>>> --write-min-size 50K --write-max-size 2M --percent-write 70
>>>>> --percent-read 30 --keep-state --test-seed 1406137270 --stop-at
>>>>> 5000 foo
>>>>>
>>>>> The most interesting bit right now is that rocksdb seems to be
>>>>> hanging in the middle of the test (left it running for several
>>>>> hours).  CPU usage on one core was quite high during the hang.
>>>>> Profiling using perf with dwarf symbols I see:
>>>>>
>>>>> -  49.14%  ceph-test-mon-s  ceph-test-mon-store-stress  [.]
>>>>> unsigned int
>>>>> rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned
>>>>> int, char const*, unsigned long)
>>>>>         - unsigned int
>>>>> rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned
>>>>> int, char const*, unsigned long)
>>>>>              51.70%
>>>>> rocksdb::ReadBlockContents(rocksdb::RandomAccessFile*,
>>>>> rocksdb::Footer const&, rocksdb::ReadOptions const&,
>>>>> rocksdb::BlockHandle const&, rocksdb::BlockContents*,
>>>>> rocksdb::Env*,
>>>>> bool)
>>>>>              48.30%
>>>>> rocksdb::BlockBasedTableBuilder::WriteRawBlock(rocksdb::Slice
>>>>> const&, rocksdb::CompressionType, rocksdb::BlockHandle*)
>>>>>
>>>>> Not sure what's going on yet, may need to try to enable
>>>>> logging/debugging in rocksdb.  Thoughts/Suggestions welcome. :)
>>>>>
>>>>> Mark
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>>
>

