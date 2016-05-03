From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 08:34:27 -0500
Message-ID: <bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
 <5727A3DC.7070102@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbcECNea (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 09:34:30 -0400
In-Reply-To: <5727A3DC.7070102@symas.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Howard Chu <hyc@symas.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 05/02/2016 02:00 PM, Howard Chu wrote:
> Sage Weil wrote:
>> 1) Thoughts on moving to rocksdb in general?
>
> Are you actually prepared to undertake all of the measurement and tuning
> required to make RocksDB actually work well? You're switching from an
> (abandoned/unsupported) engine with only a handful of config parameters
> to one with ~40-50 params, all of which have critical but unpredictable
> impact on resource consumption and performance.
>

You are absolutely correct, and there are definitely pitfalls we need to 
watch out for with the number of tunables in rocksdb.  At least on the 
performance side two of the big issues we've hit with leveldb compaction 
related.  In some scenarios compaction happens slower than the number of 
writes coming in resulting in ever-growing db sizes.  The other issue is 
that compaction is single threaded and this can cause stalls and general 
mayhem when things get really heavily loaded.  My hope is that if we do 
go with rocksdb, even in a sub-optimally tuned state, we'll be better 
off than we were with leveldb.

We did some very preliminary benchmarks a couple of years ago 
(admittedly a too-small dataset size) basically comparing the (at the 
time) stock ceph leveldb settings vs rocksdb.  On this set size, leveldb 
looked much better for reads, but much worse for writes.  I suspect with 
much larger data sets, the write issues will only compound with the 
compaction issues and will start having a much bigger impact.

Indeed, if you look at the scatterplots for leveldb, you'll see a 
regular set of high latency writes. In rocksdb we saw much better 
looking write behavior, but overall reads were slower.  We didn't do any 
real tuning to improve read performance in the leveled compaction tests, 
but I think we'll be starting out in a much better place to improve them 
than we are with leveldb.

https://drive.google.com/file/d/0B2gTBZrkrnpZN3JFV3RZeVBPWlU/view?usp=sharing

Mark
