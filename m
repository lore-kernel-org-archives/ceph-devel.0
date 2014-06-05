From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Mon backing store
Date: Thu, 05 Jun 2014 13:33:15 -0500
Message-ID: <5390B7EB.9080402@inktank.com>
References: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com> <5390B470.4010608@inktank.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F25CFCFD6@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:48235 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaFESdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 14:33:13 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so2644210igq.3
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 11:33:12 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F25CFCFD6@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Somnath,

Sorry to get your hopes up, no ceph+rocksdb benchmarks (yet!).  I was=20
referring to the benchmarks that the rocksdb developers published here:

https://github.com/facebook/rocksdb/wiki/Performance-Benchmarks

Sounds like we need to start some performance testing on wip-rocksdb=20
going though! :)

Mark

On 06/05/2014 01:26 PM, Somnath Roy wrote:
> Mark,
> Could you please share the performance benchmark result with Rocksdbs=
tore + ceph and leveldbstore+ceph as you mentioned below ?
> BTW, have you measured the WA induced by Rocksdbstore and leveldbstor=
e in the process since that is also a very important factor while backe=
nd is flash ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Mark Nelson
> Sent: Thursday, June 05, 2014 11:18 AM
> To: Samuel Just; ceph-devel@vger.kernel.org
> Subject: Re: Mon backing store
>
> On 06/05/2014 12:42 PM, Samuel Just wrote:
>> I am starting to wonder whether using leveldb for the mon is actuall=
y
>> introducing an excessive amount unnecessary complexity and
>> non-determinism.  Given that the monitor workload is read mostly,
>> except for failure conditions when it becomes write latency sensitiv=
e,
>> might we do better with a strict b-tree style backing db such as
>> berkely db even at the cost of some performance?  It seems like
>> something like that might provide more reliable latency properties.
>
> I'm not against trying it, but I'm not convinced it's the right solut=
ion.  If the 99th percentile latency is significantly better, that's ob=
viously a win, but I think we are indeed going to take a big performanc=
e hit overall.  I'm more in favor of trying rocksdb first.
> I'm certainly not as well versed in the leveldb interface as you or J=
oao are, but it appears much of our code in LevelDBStore would be reusa=
ble.
>    I don't know that rocksdb won't have the same issues that leveldb =
does, but the rocksdb developers specifically mention leveldb's bad 99t=
h percentile latencies as a driver for it's development:
>
> "By contrast, we=E2=80=99ve published the RocksDB benchmark results f=
or server side workloads on Flash. We also measured the performance of =
LevelDB on these server-workload benchmarks and found that RocksDB soli=
dly outperforms LevelDB for these IO bound workloads. We found that Lev=
elDB=E2=80=99s single-threaded compaction process was insufficient to d=
rive server workloads. We saw frequent write-stalls with LevelDB that c=
aused 99-percentile latency to be tremendously large. We found that mma=
p-ing a file into the OS cache introduced performance bottlenecks for r=
eads. We could not make LevelDB consume all the IOs offered by the unde=
rlying Flash storage."
>
> Compaction performance and high mmap/page fault/kswapd utilization du=
ring reads are two big issues we've hit in leveldb, so I'm inclined to =
think that rocksdb is at least worthy of some attention.
>
> Here's the benchmark results on their wiki:
>
> https://github.com/facebook/rocksdb/wiki/Performance-Benchmarks
>
>>
>> Thoughts?
>> -Sam
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
