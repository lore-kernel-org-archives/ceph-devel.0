From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph-0.77-900.gce9bfb8 Testing Rados EC/Tiering & CephFS ...
Date: Tue, 25 Mar 2014 11:04:26 -0700
Message-ID: <CAPYLRzjQkjj0EbcM8-kVTtynW6SqPmOc5epzFc7RHQNqN+OGoQ@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4AE6EBB91@CERNXCHG41.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:46924 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbaCYSE1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 14:04:27 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so955830qaj.39
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 11:04:26 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6EBB91@CERNXCHG41.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 20, 2014 at 3:49 AM, Andreas Joachim Peters
<Andreas.Joachim.Peters@cern.ch> wrote:
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
>
> Then I added a single replica cache pool in front of cauchy 4+2.
>
> The write performance is now 1.1 GB/s as expected when the cache is not full. If I shrink the cache pool in front forcing continuous eviction during the benchmark it degrades to stable 140 MB/s.
>
> The single threaded client reduces from 260 MB/s to 165 MB/s.
>
> What is strange to me is that after a "rados bench" there are objects left in the cache and the back-end tier. They only disappear if I set the "forward" and force the eviction. Is that by design the desired behaviour to not apply the deletion?

That's not too surprising -- you probably put enough data into the
cluster that some of the bench objects got evicted into the cold
storage pool, and then they were deleted by rados bench. The cache
pool needs to keep the object around with a "deleted" and "dirty" flag
to make sure it eventually gets cleaned up from the backing cold pool
-- as happened when you set to forward and forced an eviction.

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
>  ceph version 0.77-900-gce9bfb8 (ce9bfb879c32690d030db6b2a349b7b6f6e6a468)
>  1: (ReplicatedPG::_write_copy_chunk(boost::shared_ptr<ReplicatedPG::CopyOp>, PGBackend::PGTransaction*)+0x7dd) [0x8a376d]
>  2: (ReplicatedPG::_build_finish_copy_transaction(boost::shared_ptr<ReplicatedPG::CopyOp>, PGBackend::PGTransaction*)+0x114) [0x8a3954]
>  3: (ReplicatedPG::process_copy_chunk(hobject_t, unsigned long, int)+0x507) [0x8f1097]
>  4: (C_Copyfrom::finish(int)+0xb7) [0x93fa67]
>  5: (Context::complete(int)+0x9) [0x65d4b9]
>  6: (Finisher::finisher_thread_entry()+0x1d8) [0xa9a528]
>  7: /lib64/libpthread.so.0() [0x3386a079d1]
>  8: (clone()+0x6d) [0x33866e8b6d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

Hmm, we've had a lot of bug fixes going in lately (and I know some
were around that copy infrastructure), so I bet that's fixed now.

>
> Moreover I did some trivial testing of the meta data part of CephFS and ceph-fuse:
>
> - I created a directory hierarchy with like 10/1000/100 = 1 Mio directories. After creation the MDS uses 5.5 GB of memory, ceph-fuse 1.8 GB. It takes 33 minutes to do "find /ceph" on this hierarchy. If I restart the MDS and do the same it takes 18 minutes. After this operation the MDS uses ~10 GB of memory (10k per directory for one entry).

Hmm. That's more than I would expect, but not impossibly so if the MDS
was having trouble keeping the relevant directories in-memory. We have
not done any optimization around that sort of scenario right now and
it's a pretty hard workload for a distributed storage system. :/

>
> If I do "ls -laRt /ceph" I get "no such file or directory" after some time. When this happened one can pick one of the directory and do a single "ls -la <dir>". The first time one get's again "no such file or directory", the second time it eventually works and shows the contents.

Can you expand on that a bit? What is "after some time"?

-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
