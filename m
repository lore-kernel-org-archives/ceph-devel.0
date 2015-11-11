From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: Increasing # Shards vs multi-OSDs per device
Date: Wed, 11 Nov 2015 20:57:18 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2170 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbbKKU5V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 15:57:21 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, Samuel Just <sjust@redhat.com>, Kyle Bader <kbader@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

Sorry about the microphone issues in the performance meeting today today.   This is a followup to the 11/4 performance meeting where we discussed increasing the worker thread count in the OSD's vs making multiple OSD's (and partitions/filesystems) per device.     We did the high level experiment and have some results which I threw into a ppt/pdf, and shared them here:

http://www.docdroid.net/UbmvGnH/increasing-shards-vs-multiple-osds.pdf.html

Doing 20-shard OSD's vs 4 OSD's per device with default 5 shards yielded about half of the performance improvement for random 4k reads.  For writes performance is actually worse than just 1 OSD per device and the default # of shards.  The throttles should be large enough for the 20-shard use case as they are 10x the defaults, although if you see anything we missed let us know.

I had the cluster moved to Infernalis release (with JEMalloc) yesterday, so hopefully we'll have some early results on the same 5-node cluster soon.

Thanks,

Stephen


