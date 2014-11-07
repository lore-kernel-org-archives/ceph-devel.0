From: "Xue, Chendi" <chendi.xue@intel.com>
Subject: KeyValueStore: Some bug fixing in KeyValueStore prevent osd runtime
 crash #2875
Date: Fri, 7 Nov 2014 03:17:25 +0000
Message-ID: <C8CF870384EBCF4CAB89D2041A5C80B30119DCC8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64354 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbaKGDTZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Nov 2014 22:19:25 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, all

There is a small bug fixing in KeyValueStore to prevent osd crash

When run random write 4k test on rbd with KeyValueStore backend, random osd crashes, and ceph-osd.log shows a segmentation fault which caused by multi threads updating the strip_header->buffers, so add mutex here

Another problem is after running pretty long time, osd being killed by os due to OOM, which is also caused by there is no eviction mechanism in strip_header->buffers, so add a option in config_opts.h to turn strip_header->buffers off by default

I saw slight performance drop when turn off the strip_header->buffers in a short time test( for I can't run a long time test due to osd will crash ), so does the strip_header->buffers necessary? If so, can I add a random cache mechanism on that? 

===========================
KeyValueStore: 
Add mutex when update strip_header->buffers to avoid segmentation fault
Add option in config_opts.h to turn on/off strip_header->buffers to prevent OOM

The pull request : https://github.com/ceph/ceph/pull/2875#issue-48042745



Best Regards,
-Chendi

