From: John Wright <jcwright@MIT.EDU>
Subject: Re: MPI applications on ceph fs
Date: Mon, 17 Sep 2012 12:16:18 -0400
Message-ID: <9AA229F8-455C-464D-A661-AFF2AE20FB13@mit.edu>
References: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu> <alpine.DEB.2.00.1208262104360.11218@cobra.newdream.net> <8202724F-E1FF-4914-A474-A6449FA596F0@psfc.mit.edu> <E4BE0886-9463-4332-994E-C59AFE756EE4@mit.edu> <alpine.DEB.2.00.1208311259090.2525@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:44035 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab2IQQVZ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Sep 2012 12:21:25 -0400
In-Reply-To: <alpine.DEB.2.00.1208311259090.2525@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage and ceph-developers,
I reproduced the error again and captured file descriptors and log information. I've quoted them below. Here is a brief summary:
I have ceph 0.48 running on a single mulitprocessor node. I have two clients that have mounted the cephfs over infiniband (same error happens under GB though).  I start an parallel program with mpi on the two clients. It starts 7 processes on each client. One process (id 1728 below) opens 43 files at start up and the remaining 13 processes open up two files each. I've quotes the output of the system file descriptors below. The processes run fine with I/O going to files for about 25s when the process with 43 files locks up. At 33s the remaining processes are locked and accesses to the mounted ceph fs also lock.

I hope these details along with the mds log quotes in my last message help isolate this problem.
Is it recommended to upgrade from 0.48, or are there backports to 0.48 I should incorporate? 
thanks,
-john

Here's the debug feedback you asked for:

  # cat /sys/kernel/debug/ceph/*/mdsc
     1028	mds0	getattr	 #100000003ee

The main process with 43 files:
 #+begin_quote stat /proc/1728/fd/*
[root@eaps-80-35e ~]# stat /proc/1728/fd/*
  File: `/proc/1728/fd/0' -> `pipe:[29056]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25862       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/1' -> `pipe:[29057]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25863       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/10' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25872       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/11' -> `pipe:[29058]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25873       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/12' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25874       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/13' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25875       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/14' -> `/'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25876       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/15' -> `/dev/shm/ib_shmem-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25877       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/16' -> `/dev/shm/ib_pool-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25878       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/17' -> `/dev/shm/ib_shmem_coll-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25879       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/18' -> `/mnt/ceph/runtemplate/STDERR.0000'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25880       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/19' -> `/mnt/ceph/runtemplate/STDOUT.0000'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25881       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/2' -> `pipe:[29058]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25864       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/20' -> `/mnt/ceph/runtemplate/stats/PO4.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25882       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/21' -> `/mnt/ceph/runtemplate/stats/NO3.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25883       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/22' -> `/mnt/ceph/runtemplate/stats/FeT.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25884       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/23' -> `/mnt/ceph/runtemplate/stats/Si.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25885       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/24' -> `/mnt/ceph/runtemplate/stats/DOP.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25886       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/25' -> `/mnt/ceph/runtemplate/stats/DON.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25887       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/26' -> `/mnt/ceph/runtemplate/stats/DOFe.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25888       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/27' -> `/mnt/ceph/runtemplate/stats/POP.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25889       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/28' -> `/mnt/ceph/runtemplate/stats/PON.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25890       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/29' -> `/mnt/ceph/runtemplate/stats/POFe.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25891       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/3' -> `socket:[22813]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25865       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/30' -> `/mnt/ceph/runtemplate/stats/POSi.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25892       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/31' -> `/mnt/ceph/runtemplate/stats/NH4.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25893       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/32' -> `/mnt/ceph/runtemplate/stats/NO2.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25894       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/33' -> `/mnt/ceph/runtemplate/stats/DIC.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25895       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/34' -> `/mnt/ceph/runtemplate/stats/DOC.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25896       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/35' -> `/mnt/ceph/runtemplate/stats/POC.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25897       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/36' -> `/mnt/ceph/runtemplate/stats/PIC.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25898       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/37' -> `/mnt/ceph/runtemplate/stats/ALK.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25899       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/38' -> `/mnt/ceph/runtemplate/stats/O2.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25900       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/39' -> `/mnt/ceph/runtemplate/stats/ZooP.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25901       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/4' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25866       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/40' -> `/mnt/ceph/runtemplate/stats/ZooN.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25902       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/41' -> `/mnt/ceph/runtemplate/stats/ZooFe.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25903       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/42' -> `/mnt/ceph/runtemplate/stats/ZooSi.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25904       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/43' -> `/mnt/ceph/runtemplate/stats/Phy.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25905       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/44' -> `/mnt/ceph/runtemplate/stats/ZooC.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25906       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/45' -> `/mnt/ceph/runtemplate/stats/PP.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25907       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/46' -> `/mnt/ceph/runtemplate/stats/PAR.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25908       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/47' -> `/mnt/ceph/runtemplate/stats/Diver1.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25909       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/48' -> `/mnt/ceph/runtemplate/stats/Diver2.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25910       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/49' -> `/mnt/ceph/runtemplate/stats/Diver3.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25911       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/5' -> `socket:[29055]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25867       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/50' -> `/mnt/ceph/runtemplate/stats/Diver4.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25912       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/51' -> `/mnt/ceph/runtemplate/stats/DICTFLX.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25913       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/52' -> `/mnt/ceph/runtemplate/stats/DICCFLX.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25914       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/53' -> `/mnt/ceph/runtemplate/stats/DICOFLX.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25915       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/54' -> `/mnt/ceph/runtemplate/stats/DICPCO2.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25916       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/55' -> `/mnt/ceph/runtemplate/stats/DICPHAV.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25917       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/56' -> `/mnt/ceph/runtemplate/stats/ChlCloer.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25918       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/57' -> `/mnt/ceph/runtemplate/stats/ChlGeide.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25919       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/58' -> `/mnt/ceph/runtemplate/stats/ChlDoney.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25920       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/59' -> `/mnt/ceph/runtemplate/stats/Shannon.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25921       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/6' -> `pipe:[29056]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25868       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/60' -> `/mnt/ceph/runtemplate/stats/Simpson.0000000000.txt'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25922       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/7' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25869       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/8' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25870       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
  File: `/proc/1728/fd/9' -> `pipe:[29057]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25871       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:32:40.468849356 -0400
Modify: 2012-09-04 12:32:40.468849356 -0400
Change: 2012-09-04 12:32:40.468849356 -0400
 Birth: -
     #+end_quote

An example of the other 13 processes:
     #+begin_quote stat /proc/1729/fd/*
     [root@eaps-80-35e ~]# stat /proc/1729/fd/*
  File: `/proc/1729/fd/0' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25840       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/1' -> `pipe:[29061]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25841       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/10' -> `pipe:[29058]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25850       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/11' -> `pipe:[29061]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25851       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/12' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25852       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/13' -> `pipe:[29062]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25853       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/14' -> `/'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25854       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/15' -> `/dev/shm/ib_shmem-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25855       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/16' -> `/dev/shm/ib_pool-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25856       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/17' -> `/dev/shm/ib_shmem_coll-kvs_2025_0-eaps-80-35e.acesgrid.org-50329.tmp (deleted)'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25857       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/18' -> `/mnt/ceph/runtemplate/STDERR.0002'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25858       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/19' -> `/mnt/ceph/runtemplate/STDOUT.0002'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25859       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/2' -> `pipe:[29062]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25842       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/3' -> `socket:[22813]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25843       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/4' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25844       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/5' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25845       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/6' -> `socket:[29060]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25846       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/7' -> `anon_inode:[infinibandevent]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25847       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/8' -> `pipe:[29057]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25848       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
  File: `/proc/1729/fd/9' -> `/dev/infiniband/uverbs0'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 25849       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-04 12:31:32.957857330 -0400
Modify: 2012-09-04 12:31:32.957857330 -0400
Change: 2012-09-04 12:31:32.957857330 -0400
 Birth: -
   #+end_quote


  # 


On Aug 31, 2012, at 4:03 PM, Sage Weil wrote:

> Hi John,
> 
> On Fri, 31 Aug 2012, John C. Wright wrote:
>> An update,
>> While looking into how to switch over to a different network on my ceph cluster - another question altogether, I discovered during my upgrade from 0.47.2 to 0.48 on the three nodes somehow my 'git checkout 0.48' wasn't done correctly on two nodes and wound up reinstalling 0.47.2 on those so somehow had a heterogenous cluster running 0.47.2 on the osds and 0.48 running on the mds (all three running monitors).
>> 
>> So wiped out and started fresh with 0.48 and still got the error, but with more info this time.
>> This MPI code is running on 14 processes on two client nodes. Each process writes to its own 'stdout' file and some other data files are created by process '0'. The program starts up and creates its initial files and begins to write to its stdout files. Normally this proceeds with writes to the stdout at periodic intervals during the run, but on the ceph volume, this freezes up after about one minute.
>> 
>> Symptoms: initially can still access ceph volume from other clients. Listing the working directory of the mpi code is very slow and soon is unresponsive but can still list other directories on the ceph volume. After another minute or so, ceph clients can no longer access the volume at all without locking up in a trace that ends in a 'fastpath' kernel call. If I CTRL-C out of the mpirun call within the first minute, everything recovers, but waiting longer than that requires a reboot of mounted nodes and a restart of ceph to clear things up.
>> 
>> Below are relevant (I hope) process traces from dmesg and ceph logs. Any help on diagnosing this would be greatly appreciated. We're hoping to use ceph as a parallel file system on a scientific workload beowulf cluster, initially with a buyer-beware policy an for only transient reproducible data and more general usage as ceph gets stable and reaches the 1.0 milestone.
> 
> It looks a bit like this is a problem on the MDS side of things, since you
> have both a hung request and a writer waiting for caps.  Can you generate 
> an MDS log that goes with this workload?  With
> 
> 	debug ms = 1
> 	debug mds = 20
> 
> in the [mds] section of your config?  Also, once it hangs, it would be 
> helpful to see what the hung request is (cat 
> /sys/kernel/debug/ceph/*/mdsc) and the inode number for the hung writer 
> (stat /proc/$pid/fd/NNN).  Hopefully the stat won't hang.. but if it does, 
> hopefully you can identify which file ino or filename it is some other 
> way.
> 
> Thanks!
> sage
> 
> 
>> 
>> Thanks very much.
>> 
>> -john wright

*Removed old quoted part of thread*

