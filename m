From: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Subject: Usage of CEPH FS versa HDFS for Hadoop: TeraSort benchmark
 performance comparison issue
Date: Thu, 13 Dec 2012 15:54:05 +0100
Message-ID: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D9087AF1B@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:45614 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab2LMPED convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 10:04:03 -0500
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I am currently doing some comparisons between CEPH FS and HDFS as a file system for Hadoop using Hadoop's integrated benchmark TeraSort. This benchmark first generates the specified amount of data in the file system used by Hadoop, e.g. 1TB of data, and then sorts the data via the MapReduce framework of Hadoop, sending the sorted output again to the file system used by Hadoop.  The benchmark measures the elapsed time of a sort run.

I am wondering about my best result achieved with CEPH FS in comparison to the ones achieved with HDFS. With CEPH, the runtime of the benchmark is somewhat longer, the factor is about 1.2 when comparing with an HDFS run using the default HDFS block size of 64MB. When comparing with an HDFS run using an HDFS block size of 512MB the factor is even 1.5.

Could you please take a look at the configuration, perhaps some key factor already catches your eye, e.g. CEPH version.

OS: SLES 11 SP2

CEPH:
OSDs are distributed over several machines.
There is 1 MON and 1 MDS process on yet another machine.

Replication of the data pool is set to 1.
Underlying file systems for data are btrfs.
Mount options  are only "rw,noatime".
For each CEPH OSD, we use a RAM disk of 256MB for the journal.
Package ceph has version 0.48-13.1, package ceph-fuse has version 0.48-13.1.

HDFS:
HDFS is distributed over the same machines.
HDFS name node on yet another machine.

Replication level is set to 1.
HDFS block size is set to  64MB or even 512MB.
Underlying file systems for data are btrfs.
Mount options are only "rw,noatime".

Hadoop version is 1.0.3.
Applied the CEPH patch for Hadoop that was generated with 0 .20.205.0.
The same maximum number of Hadoop map tasks has been used for HDFS and for CEPH FS.

The same disk partitions are either formatted for HDFS or for CEPH usage.

CPU usage in both cases is almost 100 percent on all data related nodes.
There is enough memory on all nodes for the joint load of ceph-osd and Hadoop java processes.

Best regards,

Jutta Lachfeld.

--
jutta.lachfeld@ts.fujitsu.com, Fujitsu Technology Solutions PBG PDG ES&S SWE SOL 4, "Infrastructure Solutions", MchD 5B, Tel. ..49-89-3222-2705, Company Details: http://de.ts.fujitsu.com/imprint

