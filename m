From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Hadoop DNS/topology details
Date: Tue, 19 Feb 2013 14:10:44 -0800
Message-ID: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:62243 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933538Ab3BSWKr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 17:10:47 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so2463867pbc.11
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 14:10:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, Joe Buck <jbbuck@gmail.com>

Here is the information that I've found so far regarding the operation of Hadoop w.r.t. DNS/topology. There are two parts, the file system client requirements, and other consumers of topology information.

-- File System Client --

The relevant interface between the Hadoop VFS and its underlying file system is:

  FileSystem:getFileBlockLocations(File, Extent)

which is expected to return a list of hosts (a 3-tuple: hostname, IP, topology path) for each block that contains any part of the specified file extent. So, with triplication and 2 blocks, there are 2 * 3 = 6 3-tuples present.

  *** Note: HDFS sorts each list of hosts based on a distance metric applied between the initiating file system client and each of the blocks in the list using the HDFS cluster map. This should not affect correctness, although it's possible that consumers of this list (e.g. MapReduce) may assume an ordering. ***

The current Ceph client can produce the same list, but does not include hostname nor topology information. Currently reverse DNS is used to fill in the hostname, and defaults to a flat topology in which all hosts are in a single topology path: "/default-rack/host".

- Reverse DNS could be quite slow:
   - 3x replication * 1 TB / 64 MB blocks = 49152 lookups
   - Caching lookups could help

-- Topology Information --

Services that run on a Hadoop cluster (such as MapReduce) use hostname and topology information attached to each file system block to schedule and aggregate work based on various policies. These services don't have direct access to the HDFS cluster map, and instead rely on a service to provide a mapping:

   DNS-names/IP -> topology path mapping

This can be performed using a script/utility program that will perform bulk translations, or implemented in Java.

-- A Possible Approach --

1. Expand CephFS interface to return IP and hostname
2. Build a Ceph tool to perform DNS-name/IP -> topology path mapping

Using (2) from the Hadoop shim we can perform distance sorting, as well as resolve the topology information. The tool will also be used by other Hadoop services that can make use of the topology.

This would seem like a good incremental step forward. There are a _lot_ of other analytics systems out there that might be interested in running on top of Ceph, including the next-generation Hadoop releases, all of which may have slightly different requirements. So wedding ourselves to an expansion of the CephFS API at this point might be a little premature. On the other hand, providing all information now should cover our bases later :)

- Noah