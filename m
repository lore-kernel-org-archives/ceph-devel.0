From: Gregory Farnum <greg@inktank.com>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Thu, 13 Dec 2012 09:41:38 -0800
Message-ID: <CAPYLRzj0=s117ahDOKRfm409Rusp4e7fQpvgjOWDJNrB9GUaog@mail.gmail.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
	<alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57205 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731Ab2LMRli convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:41:38 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4356336ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:41:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212130923140.28618@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Noah Watkins <noah.watkins@inktank.com>, Joe Buck <joe.buck@inktank.com>

On Thu, Dec 13, 2012 at 9:27 AM, Sage Weil <sage@inktank.com> wrote:
> Hi Jutta,
>
> On Thu, 13 Dec 2012, Lachfeld, Jutta wrote:
>> Hi all,
>>
>> I am currently doing some comparisons between CEPH FS and HDFS as a =
file system for Hadoop using Hadoop's integrated benchmark TeraSort. Th=
is benchmark first generates the specified amount of data in the file s=
ystem used by Hadoop, e.g. 1TB of data, and then sorts the data via the=
 MapReduce framework of Hadoop, sending the sorted output again to the =
file system used by Hadoop.  The benchmark measures the elapsed time of=
 a sort run.
>>
>> I am wondering about my best result achieved with CEPH FS in compari=
son to the ones achieved with HDFS. With CEPH, the runtime of the bench=
mark is somewhat longer, the factor is about 1.2 when comparing with an=
 HDFS run using the default HDFS block size of 64MB. When comparing wit=
h an HDFS run using an HDFS block size of 512MB the factor is even 1.5.
>>
>> Could you please take a look at the configuration, perhaps some key =
factor already catches your eye, e.g. CEPH version.
>>
>> OS: SLES 11 SP2
>>
>> CEPH:
>> OSDs are distributed over several machines.
>> There is 1 MON and 1 MDS process on yet another machine.
>>
>> Replication of the data pool is set to 1.
>> Underlying file systems for data are btrfs.
>> Mount options  are only "rw,noatime".
>> For each CEPH OSD, we use a RAM disk of 256MB for the journal.
>> Package ceph has version 0.48-13.1, package ceph-fuse has version 0.=
48-13.1.
>>
>> HDFS:
>> HDFS is distributed over the same machines.
>> HDFS name node on yet another machine.
>>
>> Replication level is set to 1.
>> HDFS block size is set to  64MB or even 512MB.
>
> I suspect that this is part of it.  The default ceph block size is on=
ly
> 4MB.  Especially since the differential increases with larger blocks.
> I'm not sure if the setting of block sizees is properly wired up; it
> depends on what version of the hadoop bindings you are using.  Noah w=
ould
> know more.
>
> You can adjust the default block/object size for the fs with the ceph=
fs
> utility from a kernel mount.  There isn't yet a convenient way to do =
this
> via ceph-fuse.

If Jutta is using the *old* ones I last worked on in 2009, then this
is already wired up for 64MB blocks. A "ceph pg dump" would let us get
a rough estimate of the block sizes in use.

"ceph -s" would also be useful to check that everything is set up reaso=
nably.

Other than that, it would be fair to describe these bindings as
little-used =97 minimal performance tests indicated rough parity back i=
n
2009, but those were only a couple minutes long and on very small
clusters, so 1.2x might be normal. Noah and Joe are working on new
bindings now, and those will be tuned and accompany some backend
changes if necessary. They might also have a better eye for typical
results.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
