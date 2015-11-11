From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Increasing # Shards vs multi-OSDs per device
Date: Wed, 11 Nov 2015 21:59:35 +0000
Message-ID: <BY2PR02MB20423FFC360CE3895AA6AE3F4130@BY2PR02MB204.namprd02.prod.outlook.com>
References: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:31078
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752046AbbKKV7i convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 16:59:38 -0500
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, Samuel Just <sjust@redhat.com>, Kyle Bader <kbader@redhat.com>

Thanks for the data Stephen. Some feedback:

1. I don't think single OSD is still there to serve 460K read iops irrespective of how many shards/threads you are running. I didn't have your NVMe data earlier :-)..But, probably for 50/60K SAS SSD iops single OSD per drive is good enough. I hope you tried even increasing the shards/threads to very high value (since you have lot of cpu left) say 40:2 or 80:1 (try one configuration with 1 thread/shard , it should reduce contention per shard) so ? Or even lower ratio like 10:2  or 20:1 ?

2. Do you have any data on disk utilization ? It will be good if we are able to understand how better the single disk utilization becomes when you are running multiple OSDs/drive. I kind of back calculate from your data that , in case of 4 OSds/drive cases each OSD is serving ~14K read iops vs ~42K read iops while having one osd/drive. So, this clearly tells that two OSDs/drive should be good enough to serve similar iops in your environment. You are able to extract ~56K iops per drive with 4 OSDs vs 42K for one OSD case.

3. The above calculation I have discarded all the cache effect , but, that's not realistic. You have total of 128 GB * 5 = 640 GB of RAM. What is the total working set of yours ? If you are having lot of cache effect in this run , 4 OSDs (4 XFS) will be having better effect than one OSD /drive. This could be a total number of OSD effect in the cluster but not so number of OSD needed to saturate a drive.

4. Also, cpu util wise, you have only 20% more cpu util while you are running 4X more OSDs.

5.  BTW, worker thread calculation is incorrect , default is 5:2 , so, each osd is running with 10 worker threads and total 160 worker threads for both 4 OSD/drive and 1 osd/drive (20:2).

6.  Write data is surprising compare to default shard 1 OSD case, may be you need to increase filestore op thrads since you have more data coming to filestore ?

Thanks & Regards
Somnath

-----Original Message-----
From: Blinick, Stephen L [mailto:stephen.l.blinick@intel.com] 
Sent: Wednesday, November 11, 2015 12:57 PM
To: ceph-devel@vger.kernel.org; Mark Nelson; Samuel Just; Kyle Bader; Somnath Roy
Subject: Increasing # Shards vs multi-OSDs per device

Sorry about the microphone issues in the performance meeting today today.   This is a followup to the 11/4 performance meeting where we discussed increasing the worker thread count in the OSD's vs making multiple OSD's (and partitions/filesystems) per device.     We did the high level experiment and have some results which I threw into a ppt/pdf, and shared them here:

http://www.docdroid.net/UbmvGnH/increasing-shards-vs-multiple-osds.pdf.html

Doing 20-shard OSD's vs 4 OSD's per device with default 5 shards yielded about half of the performance improvement for random 4k reads.  For writes performance is actually worse than just 1 OSD per device and the default # of shards.  The throttles should be large enough for the 20-shard use case as they are 10x the defaults, although if you see anything we missed let us know.

I had the cluster moved to Infernalis release (with JEMalloc) yesterday, so hopefully we'll have some early results on the same 5-node cluster soon.

Thanks,

Stephen


