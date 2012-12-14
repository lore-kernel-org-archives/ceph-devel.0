From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark performance
 comparison issue
Date: Fri, 14 Dec 2012 08:53:11 -0600
Message-ID: <50CB3D57.8040808@inktank.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45323 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNOxL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 09:53:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so5968365ieb.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 06:53:11 -0800 (PST)
In-Reply-To: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/13/2012 08:54 AM, Lachfeld, Jutta wrote:
> Hi all,

Hi!  Sorry to send this a bit late, it looks like the reply I authored 
yesterday from my phone got eaten by vger.

>
> I am currently doing some comparisons between CEPH FS and HDFS as a file system for Hadoop using Hadoop's integrated benchmark TeraSort. This benchmark first generates the specified amount of data in the file system used by Hadoop, e.g. 1TB of data, and then sorts the data via the MapReduce framework of Hadoop, sending the sorted output again to the file system used by Hadoop.  The benchmark measures the elapsed time of a sort run.
>
> I am wondering about my best result achieved with CEPH FS in comparison to the ones achieved with HDFS. With CEPH, the runtime of the benchmark is somewhat longer, the factor is about 1.2 when comparing with an HDFS run using the default HDFS block size of 64MB. When comparing with an HDFS run using an HDFS block size of 512MB the factor is even 1.5.
>
> Could you please take a look at the configuration, perhaps some key factor already catches your eye, e.g. CEPH version.
>
> OS: SLES 11 SP2

Beyond what the others have said, this could be an issue.  If I recall, 
that's an older version of SLES and won't have syncfs support in glibc 
(you need 2.14+).  In newer versions of Ceph you can still use syncfs if 
your kernel is new enough (2.6.38+), but in 0.48 you need support for it 
in glibc too.  This will have a performance impact, especially if you 
have more than one OSD per server.

>
> CEPH:
> OSDs are distributed over several machines.
> There is 1 MON and 1 MDS process on yet another machine.
>
> Replication of the data pool is set to 1.
> Underlying file systems for data are btrfs.

What kernel are you using?  If it's older, this could also be an issue. 
  We've seen pretty bad btrfs fragmentation on older kernels that seems 
to be related to degradation in performance over time.

> Mount options  are only "rw,noatime".
> For each CEPH OSD, we use a RAM disk of 256MB for the journal.
> Package ceph has version 0.48-13.1, package ceph-fuse has version 0.48-13.1.
>
> HDFS:
> HDFS is distributed over the same machines.
> HDFS name node on yet another machine.
>
> Replication level is set to 1.
> HDFS block size is set to  64MB or even 512MB.
> Underlying file systems for data are btrfs.
> Mount options are only "rw,noatime".

The large block size may be an issue (at least with some of our default 
tunable settings).  You might want to try 4 or 16MB and see if it's any 
better or worse.

>
> Hadoop version is 1.0.3.
> Applied the CEPH patch for Hadoop that was generated with 0 .20.205.0.
> The same maximum number of Hadoop map tasks has been used for HDFS and for CEPH FS.
>
> The same disk partitions are either formatted for HDFS or for CEPH usage.
>
> CPU usage in both cases is almost 100 percent on all data related nodes.

If you run sysprof, you can probably get an idea of where the time is 
being spent.  perf sort of works but doesn't seem to report ceph-osd 
symbols properly.

> There is enough memory on all nodes for the joint load of ceph-osd and Hadoop java processes.
>
> Best regards,
>
> Jutta Lachfeld.
>
> --
> jutta.lachfeld@ts.fujitsu.com, Fujitsu Technology Solutions PBG PDG ES&S SWE SOL 4, "Infrastructure Solutions", MchD 5B, Tel. ..49-89-3222-2705, Company Details: http://de.ts.fujitsu.com/imprint
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

