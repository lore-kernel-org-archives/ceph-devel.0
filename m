From: Mark Nelson <mnelson@redhat.com>
Subject: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 02:03:18 -0500
Message-ID: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbcGLHDV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 03:03:21 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFA373B3C2
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 07:03:20 +0000 (UTC)
Received: from [10.3.112.18] (ovpn-112-18.phx2.redhat.com [10.3.112.18])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6C73IMc015925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 03:03:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

With Igor's patch last week I was able to get some bluestore performance 
runs in without segfaulting and started looking int the results. 
Somewhere along the line we really screwed up read performance, but 
that's another topic.  Right now I want to focus on random writes. 
Before we put the onode on a diet we were seeing massive amounts of read 
traffic in RocksDB during compaction that caused write stalls during 4K 
random writes.  Random write performance on fast hardware like NVMe 
devices was often below filestore at anything other than very large IO 
sizes.  This was largely due to the size of the onode compounded with 
RocksDB's tendency toward read and write amplification.

The new test results look very promising.  We've dramatically improved 
performance of random writes at most IO sizes, so that they are now 
typically quite a bit higher than both filestore and older bluestore 
code.  Unfortunately for very small IO sizes performance hasn't improved 
much.  We are no longer seeing huge amounts of RocksDB read traffic and 
fewer write stalls.  We are however seeing huge memory usage (~9GB RSS 
per OSD) and very high CPU usage.  I think this confirms some of the 
memory issues somnath was continuing to see.  I don't think it's a leak 
exactly based on how the OSDs were behaving, but we need to run through 
massif still to be sure.

I ended up spending some time tonight with perf and digging through the 
encode code.  I wrote up some notes with graphs and code snippets and 
decided to put them up on the web.  Basically some of the encoding 
changes we implemented last month to reduce the onode size also appear 
to result in more buffer::list appends and the associated overhead. 
I've been trying to think through ways to improve the situation and 
thought other people might have some ideas too.  Here's a link to the 
short writeup:

https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?usp=sharing

Thanks,
Mark
