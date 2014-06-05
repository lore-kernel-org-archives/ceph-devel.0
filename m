From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Mon backing store
Date: Thu, 05 Jun 2014 13:18:24 -0500
Message-ID: <5390B470.4010608@inktank.com>
References: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58056 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaFESSW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 14:18:22 -0400
Received: by mail-ie0-f169.google.com with SMTP id rp18so1249256iec.14
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 11:18:21 -0700 (PDT)
In-Reply-To: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/05/2014 12:42 PM, Samuel Just wrote:
> I am starting to wonder whether using leveldb for the mon is actually
> introducing an excessive amount unnecessary complexity and
> non-determinism.  Given that the monitor workload is read mostly,
> except for failure conditions when it becomes write latency sensitive=
,
> might we do better with a strict b-tree style backing db such as
> berkely db even at the cost of some performance?  It seems like
> something like that might provide more reliable latency properties.

I'm not against trying it, but I'm not convinced it's the right=20
solution.  If the 99th percentile latency is significantly better,=20
that's obviously a win, but I think we are indeed going to take a big=20
performance hit overall.  I'm more in favor of trying rocksdb first.=20
I'm certainly not as well versed in the leveldb interface as you or Joa=
o=20
are, but it appears much of our code in LevelDBStore would be reusable.=
=20
  I don't know that rocksdb won't have the same issues that leveldb=20
does, but the rocksdb developers specifically mention leveldb's bad 99t=
h=20
percentile latencies as a driver for it's development:

"By contrast, we=E2=80=99ve published the RocksDB benchmark results for=
 server=20
side workloads on Flash. We also measured the performance of LevelDB on=
=20
these server-workload benchmarks and found that RocksDB solidly=20
outperforms LevelDB for these IO bound workloads. We found that=20
LevelDB=E2=80=99s single-threaded compaction process was insufficient t=
o drive=20
server workloads. We saw frequent write-stalls with LevelDB that caused=
=20
99-percentile latency to be tremendously large. We found that mmap-ing =
a=20
file into the OS cache introduced performance bottlenecks for reads. We=
=20
could not make LevelDB consume all the IOs offered by the underlying=20
=46lash storage."

Compaction performance and high mmap/page fault/kswapd utilization=20
during reads are two big issues we've hit in leveldb, so I'm inclined t=
o=20
think that rocksdb is at least worthy of some attention.

Here's the benchmark results on their wiki:

https://github.com/facebook/rocksdb/wiki/Performance-Benchmarks

>
> Thoughts?
> -Sam
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
