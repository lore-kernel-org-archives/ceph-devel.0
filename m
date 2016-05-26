From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: SMR Benchmarking Results
Date: Thu, 26 May 2016 00:44:21 -0400
Message-ID: <CAPLK-i8DKcHtNuv5T1jua=5sp3Fxxb+LwdTdUSpvxqRNj7AMhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36036 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcEZEoW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 00:44:22 -0400
Received: by mail-yw0-f182.google.com with SMTP id x189so66397109ywe.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 21:44:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Allen Samuels <allen.samuels@sandisk.com>, ceph-devel@vger.kernel.org

Hi Sage,

I have been working on benchmarking SMR Drives using libzbc. It
appears that issuing ZBC commands for zone aware host is more
inefficient as compared to normal copy operations using 'dd' command.

I created a 256 MB file and placed it in memory (so that we do not
have data fetch overheads). I copy this file repeatedly on a Host
Aware SMR drive in 2 scenarios :

a) dd - I use dumb dd that takes 1MB chunks of file and keeps copying
the file to SMR drive for <writeSize> bytes. Note that dd does not
take the zones into consideration.

b) SMR_aware_copy - This copy takes file chunks 1MB in size, but
issues ZBC commands to open each zone, write 256 MB data to the zone,
close the zone, and then move to another zone till <writeSize> bytes
have been written.

performance results for 1GB, 10GB write sizes are 5x slower with "zone
aware" writing, as compared to normal dd writing:

writeSize (in GB)     dd time (in min:sec)     smr_aware_copy (in min:sec)
1 GB                              0:7                                0:34
10 GB                            1:11                              6:41
50 GB                            5:51                               NA
100 GB                          11:42                             NA

(all writes were followed by sync command)

I was trying to see if there is an internal cache of some sort in the
Host Aware SMR drive, which probably serializes all writes up to
certain extent for dd command, but the time for writes using the dd
command for up to 100GB follow a linear pattern. I will try to see if
we hit a bottleneck with dd for larger file sizes or unaligned writes.

Followup questions:
--------------------------

a) I think we should have some workload traces or patterns so that we
can benchmark SMR drives and make allocator more SMR friendly. In
particular -
i) size of files,
ii) alignment of files
iii) % read / write/ delete workloads
iv) degree of parallelism in writing.

b) SMR Drive has a notion of parallel writes - i.e. multiple zones can
be kept open and written to simultaneously. I do not think there are
multiple heads involved but internally there is some form of
"efficient parallel write to zone" mechanism in SMR. I am thinking
about this because when we query SMR drive information, it shows that
most effieicnt number of zones can be parallelly kept open = 128 .
Maybe this is something that we can take advantage of?

Thanks and Regards,
Shehbaz
