From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph-0.77-900.gce9bfb8 Testing Rados EC/Tiering & CephFS ...
Date: Thu, 20 Mar 2014 08:09:23 -0500
Message-ID: <532AE883.1050106@inktank.com>
References: <3472A07E6605974CBC9BC573F1BC02E4AE6EBB91@CERNXCHG41.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:58218 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaCTNJM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Mar 2014 09:09:12 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so760114iec.25
        for <ceph-devel@vger.kernel.org>; Thu, 20 Mar 2014 06:09:11 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6EBB91@CERNXCHG41.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/20/2014 05:49 AM, Andreas Joachim Peters wrote:
> Hi,
>
> I did some Firefly ceph-0.77-900.gce9bfb8 testing of EC/Tiering deploying 64 OSD with in-memory filesystems (RapidDisk with ext4) on a single 256 GB box. The raw write performance of this box is ~3 GB/s for all and ~450 MB/s per OSD. It provides 250k IOPS per OSD.
>
> I compared several algorithms and configurations ...
>
> Here are the results (there is no significant difference between 64 or 10 OSDS for the performance, tried both but not for 24+8 !) with 4M objects, 32 client threads ....
>
> 1 rep: 1.1 GB/s
> 2 rep: 886 MB/s
> 3 rep: 750 MB/s
> cauchy 4+2: 880 MB/s
> liber8tion: 4+2: 875 MB/s
> cauchy 6+3: 780 MB/s
> cauchy 16+8: 520 MB/s
> cauchy 24+8: 450 MB/s

How many copies of rados bench are you using and how much concurrency? 
Also, were the rados bench processes on an external host?

Here's what I'm seeing internally for 4MB writes on a box with 30 
spinning disks, 6 Intel 520 SSDs for journals, and bonded 10GbE.  This 
was using 4 copies of rados bench and 32 concurrent IOs per process. 
Note that 4MB writes is probably the best case scenario for EC compared 
to replication as far as performance goes right now.

4MB READ

ec-4k1m:	1546.21 MB/s
ec-6k2m:	1308.52 MB/s
ec-10k3m:	1060.73 MB/s
2X rep:		2110.92 MB/s
3X rep:		2131.03 MB/s

4MB WRITE

ec-4k1m:	1063.72 MB/s
ec-6k2m:	750.381 MB/s
ec-10k3m:	493.615 MB/s
2X rep:		1171.35 MB/s
3X rep:		755.148 MB/s


>
> Then I added a single replica cache pool in front of cauchy 4+2.
>
> The write performance is now 1.1 GB/s as expected when the cache is not full. If I shrink the cache pool in front forcing continuous eviction during the benchmark it degrades to stable 140 MB/s.

Mind trying that same test with just a simple 1x rep pool to another 1x 
rep pool and see what happens?

>
> The single threaded client reduces from 260 MB/s to 165 MB/s.
>
> What is strange to me is that after a "rados bench" there are objects left in the cache and the back-end tier. They only disappear if I set the "forward" and force the eviction. Is that by design the desired behaviour to not apply the deletion?
>
> Some observations:
> - I think it is important to document the alignment requirements for appends (e.g. if you do rados put it needs aligned appends and the 4M blocks are not aligned for every combination of (k,m) ).
>
> - another observation is that seems difficult to run 64 OSDs on a box. I have no obvious memory limitation but it requires ~30k threads and it was difficult to create several pools with many PGs without having OSDs core dumping because resources are not available.
>
> - when OSD get 100% full they core dump most of the time. In my case all OSDs become full at the same time and when this happended there is no way to get the cluster up again without manually deleting objects in the OSD directories and make some space.
>
> - I get a syntax error in the CEPH CENTOS(RHEL6) startup script:
>
> awk: { d=$2/1073741824 ; r = sprintf(\"%.2f\", d); print r }
> awk:                                 ^ backslash not last character on line
>
> - I have run several times into a situation where the only way out was to delete the whole cluster and set it up from scratch
>
> - I got this reproducable stack trace with a EC pool and a front end tier:
> osd/ReplicatedPG.cc: 5554: FAILED assert(cop->data.length() + cop->temp_cursor.data_offset == cop->cursor.data_offset)
>
>   ceph version 0.77-900-gce9bfb8 (ce9bfb879c32690d030db6b2a349b7b6f6e6a468)
>   1: (ReplicatedPG::_write_copy_chunk(boost::shared_ptr<ReplicatedPG::CopyOp>, PGBackend::PGTransaction*)+0x7dd) [0x8a376d]
>   2: (ReplicatedPG::_build_finish_copy_transaction(boost::shared_ptr<ReplicatedPG::CopyOp>, PGBackend::PGTransaction*)+0x114) [0x8a3954]
>   3: (ReplicatedPG::process_copy_chunk(hobject_t, unsigned long, int)+0x507) [0x8f1097]
>   4: (C_Copyfrom::finish(int)+0xb7) [0x93fa67]
>   5: (Context::complete(int)+0x9) [0x65d4b9]
>   6: (Finisher::finisher_thread_entry()+0x1d8) [0xa9a528]
>   7: /lib64/libpthread.so.0() [0x3386a079d1]
>   8: (clone()+0x6d) [0x33866e8b6d]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

Haven't seen that one yet!  Can you create an urgent bug with the full 
stack trace and the pool settings both for the cache and the tier pool? 
  Thanks!

>
> Moreover I did some trivial testing of the meta data part of CephFS and ceph-fuse:
>
> - I created a directory hierarchy with like 10/1000/100 = 1 Mio directories. After creation the MDS uses 5.5 GB of memory, ceph-fuse 1.8 GB. It takes 33 minutes to do "find /ceph" on this hierarchy. If I restart the MDS and do the same it takes 18 minutes. After this operation the MDS uses ~10 GB of memory (10k per directory for one entry).
>
> If I do "ls -laRt /ceph" I get "no such file or directory" after some time. When this happened one can pick one of the directory and do a single "ls -la <dir>". The first time one get's again "no such file or directory", the second time it eventually works and shows the contents.
>
> Cheers Andreas.
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

