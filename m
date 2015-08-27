From: Sage Weil <sage@newdream.net>
Subject: Re: My test on newstore show much poorer performance than
 filestore
Date: Thu, 27 Aug 2015 06:40:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508270638220.13116@cobra.newdream.net>
References: <55DECFA1.7050203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55875 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbbH0Nkt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 09:40:49 -0400
In-Reply-To: <55DECFA1.7050203@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wenjunh <huangwenjun310@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 Aug 2015, wenjunh wrote:
> Hi
> I have a try of the newstore to explore its performance, which shows 
> its performance is much poorer than filestore.
> 
> I test my cluster using fio, Here is the comparison of the two store 
> with randread & randwrite scenario:
> 
> rw=randread, bs=4K, numjobs=1:
> newstore: bw=2280.7KB/s, iops=570
> filestore: bw=4846.6KB/s, iops=1211
> 
> rw=randwrite, bs=4K, numjobs=1:
> newstore: bw=32999 B/s, iops=8
> filestore: bw=250978 B/s, iops=61
> The two tests are performed using the same hardware, but newstore is 
> much poorer than filestore. From the view of the community, newstore is 
> the next default backend store in Ceph, but why its performance so poor. 
> Could someone tell me why?

Newstore doesn't do well with random IO just yet, especially when the 
WAL/journal is not on a separate device, because rocksdb doesn't do a very 
good job with its log management.  I'm working on fixing this in rocksdb 
now.

At the other end of the spectrum, if you do something like rados bench (4M 
writes) newstore should be almost 2x faster.

Were you using an SSD journal with filestore or a disk partition?  
Newstore doesn't know how to use a separate SSD yet unless you set up the 
wal_dir manually.

sage

