From: Sage Weil <sweil@redhat.com>
Subject: Re: SMR Benchmarking Results
Date: Thu, 26 May 2016 08:40:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605260831190.6221@cpach.fuggernut.com>
References: <CAPLK-i8DKcHtNuv5T1jua=5sp3Fxxb+LwdTdUSpvxqRNj7AMhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40639 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbcEZMkQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2016 08:40:16 -0400
In-Reply-To: <CAPLK-i8DKcHtNuv5T1jua=5sp3Fxxb+LwdTdUSpvxqRNj7AMhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: Allen Samuels <allen.samuels@sandisk.com>, ceph-devel@vger.kernel.org

On Thu, 26 May 2016, Shehbaz Jaffer wrote:
> Hi Sage,
> 
> I have been working on benchmarking SMR Drives using libzbc. It
> appears that issuing ZBC commands for zone aware host is more
> inefficient as compared to normal copy operations using 'dd' command.
> 
> I created a 256 MB file and placed it in memory (so that we do not
> have data fetch overheads). I copy this file repeatedly on a Host
> Aware SMR drive in 2 scenarios :
> 
> a) dd - I use dumb dd that takes 1MB chunks of file and keeps copying
> the file to SMR drive for <writeSize> bytes. Note that dd does not
> take the zones into consideration.
> 
> b) SMR_aware_copy - This copy takes file chunks 1MB in size, but
> issues ZBC commands to open each zone, write 256 MB data to the zone,
> close the zone, and then move to another zone till <writeSize> bytes
> have been written.

It seems like for this to be an apples-apples comparison, the dd test 
should be writing 256MB extents (in 1mb writes) at random offsets on the 
disk, as compared to the ZBC workload that opens zones and writes 
them to the proper zone offsets.

> performance results for 1GB, 10GB write sizes are 5x slower with "zone
> aware" writing, as compared to normal dd writing:
> 
> writeSize (in GB)     dd time (in min:sec)     smr_aware_copy (in min:sec)
> 1 GB                              0:7                                0:34
> 10 GB                            1:11                              6:41
> 50 GB                            5:51                               NA
> 100 GB                          11:42                             NA
> 
> (all writes were followed by sync command)
> 
> I was trying to see if there is an internal cache of some sort in the
> Host Aware SMR drive, which probably serializes all writes up to
> certain extent for dd command, but the time for writes using the dd
> command for up to 100GB follow a linear pattern. I will try to see if
> we hit a bottleneck with dd for larger file sizes or unaligned writes.
> 
> Followup questions:
> --------------------------
> 
> a) I think we should have some workload traces or patterns so that we
> can benchmark SMR drives and make allocator more SMR friendly. In
> particular -
> i) size of files,
> ii) alignment of files
> iii) % read / write/ delete workloads
> iv) degree of parallelism in writing.

I am thinking that since the target use case for these drives is object 
storage, we need to come up with a workload that reflects what we expect 
to see there.  I'm thinking something like:

 - 99% write, 1% random delete (or something similarly skewed)
 - mostly large (4mb) objects, with a few small ones mixed in
 - occasional 'pg migration' events, where ~1% of all objects get deleted.

> b) SMR Drive has a notion of parallel writes - i.e. multiple zones can
> be kept open and written to simultaneously. I do not think there are
> multiple heads involved but internally there is some form of
> "efficient parallel write to zone" mechanism in SMR. I am thinking
> about this because when we query SMR drive information, it shows that
> most effieicnt number of zones can be parallelly kept open = 128 .
> Maybe this is something that we can take advantage of?

I think we should check with our friends at Seagate and ask how this 
really works.  I don't really understand why there should be a limit to 
the number open zones at all... it seems like there should just be a 
position/offset for each zone, and as long as we write to it, all should 
be well...

sage
