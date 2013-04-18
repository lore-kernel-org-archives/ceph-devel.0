From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH v2] os/LevelDBStore: tune LevelDB data blocking
 options to be more suitable for PGStat values
Date: Thu, 18 Apr 2013 16:40:17 -0600
Message-ID: <51707651.7030802@sandia.gov>
References: <1365180692-5233-1-git-send-email-jaschut@sandia.gov>
 <CAPYLRzhaRg42eSOyQMGKLfQoyj81CriHKfsgXb2VnGGRhY2U6g@mail.gmail.com>
 <5168636E.6030204@sandia.gov>
 <CAPYLRzggH_LMgvJaoJ1aXHF8Q5pjc=zDiAPYdNrap5WypVhmnA@mail.gmail.com>
 <517075FB.8090802@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:52200 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936709Ab3DRWkq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 18:40:46 -0400
In-Reply-To: <517075FB.8090802@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/18/2013 04:38 PM, Jim Schutt wrote:
> Hi Greg,
> 
> On 04/16/2013 02:18 PM, Gregory Farnum wrote:
>> On Fri, Apr 12, 2013 at 12:41 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>>> Hi Greg,
>>>
>>>
>>> On 04/10/2013 06:39 PM, Gregory Farnum wrote:
>>>> Jim,
>>>> I took this patch as a base for setting up config options which people
>>>> can tune manually and have pushed those changes to wip-leveldb-config.
>>>
>>> I was out of the office unexpectedly for a few days,
>>> so I'm just now taking a look.
>>>
>>>> Thanks very much for figuring out how to set up the cache et al!
>>>
>>> No problem!
>>>
>>>>
>>>> For now I restructured quite a bit of the data ingestion, and I took
>>>> your defaults for the monitor on the write buffer, block size, and
>>>> compression, but I left the cache off. These also don't apply to the
>>>> OSDs at all. In order to enable more experimentation I do pass through
>>>> the options though:
>>>> OPTION(mon_ldb_write_buffer_size, OPT_U64, 32*1024*1024) // monitor's
>>>> leveldb write buffer size
>>>> OPTION(mon_ldb_cache_size, OPT_U64, 0) // monitor's leveldb cache size
>>>> OPTION(mon_ldb_block_size, OPT_U64, 4*1024*1024) // monitor's leveldb block size
>>>> OPTION(mon_ldb_bloom_size, OPT_INT, 0) // monitor's leveldb bloom bits per entry
>>>> OPTION(mon_ldb_max_open_files, OPT_INT, 0) // monitor's leveldb max open files
>>>> OPTION(mon_ldb_compression, OPT_BOOL, false) // monitor's leveldb uses
>>>> compression
>>>> (and similar ones for osd_ldb_*).
>>
>> On request from Sage these are now "*_leveldb_*" instead of "*_ldb_*";
>> I pushed that a couple hours ago. In case you haven't already pulled
>> down a copy, and so you know for when it gets into mainline and you go
>> to adjust it. :)
> 
> I've been testing this over the last several days, both
> via the wip-leveldb-config branch, and then the next branch
> after that was merged into next.
> 
> I've gotten slightly better startup behavior with mon_ldb_cache_size

Oops, now mon_leveldb_cache_size ;)

-- Jim

> larger than the default 8 MiB in leveldb - I've used 64 MiB and
> 256 MiB, and found little to prefer one over the other.  Both
> seem to be preferable to the default, at least wrt. startup
> behavior at the number of PGs (256K) I'm testing.
> 
> Other than that, I've had no trouble with the new tunings.
> 
> I'm sorry for the delay in reporting - I've had a little
> hardware trouble, and was trying to be sure that any issues
> I've been having were related to that and not these patches.
> 
> -- Jim
> 
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
> 


