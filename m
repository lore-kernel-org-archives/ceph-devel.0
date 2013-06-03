From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: Ceph killed by OS because of OOM under high load
Date: Mon, 3 Jun 2013 15:47:40 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC01E0E095@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35511 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3FCPsF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 11:48:05 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Mark Nelson (mark.nelson@inktank.com)" <mark.nelson@inktank.com>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi,
	As my previous mail reported some weeks ago ,we are suffering from OSD crash/ OSD Flipping / System reboot and etc, all these unstable issue really stop us from digging further into ceph characterization.
	Good news is that we seems find out the cause, I explain our experiments below:
	
	Environment:
		We have 2 machines, one for client and one for ceph, connected via 10GbE.
		The client machine is very powerful, with 64 Cores and 256G RAM. 
		The ceph machine with 32 Cores and 64G RAM, but we limited the available RAM to 8GB by the grub configuration.12 OSDs on top of 12* 5400 RPM 1T disk , 4* DCS 3700 SSDs as journals.
		Both client and ceph are v0.61.2.
		We run 12 rados bench instances in client node as a stress to ceph node, each instance with 256 concurrent.
	Experiment and result:
		1.default ceph + default client ,   OK
		2.tuned ceph  + default client    FAIL,One osd killed by OS due to OOM, and all swap space is run out. (tuning: Large queue ops/Large queue bytes/.No flusher/sync_flush =true)
		3.tuned ceph WITHOUT large queue bytes  + default client   OK
		4.tuned ceph WITHOUT large queue bytes  + aggressive client  FAILED, One osd killed by OOM and one suicide because 150s op thread timeout.  (aggressive client: objecter_inflight_ops, opjecter_inflight_bytes are both set to 10X of default)

	Conclusion.
		We would like to say, 
		a.	under heavy load, some tuning will make ceph unstable ,especially queue bytes related ( deduce from 1+2+3)
		b.	Ceph doesn't do any control on the lenth of OSD Queue, this is a critical issue, with aggressive client or a lot of concurrent clients, the osd queue will become too long to fit in memory ,thus result in osd daemon being killed.(deduce from 3+4)
		c.   An observation to osd daemon memory usage show that, if I use "killall rados" to kill all the rados bench instances, the ceph osd daemon cannot free the allocated memory, instead, it still remain very high memory usage(a new started ceph used ~0.5 GB , and with load it used ~ 6GB , if killed rados, it still remain 5~6GB, restart ceph can solve this issue)

	We don't capture any log now ,but since it's really easy to reproduce , so we can reproduce and provide any log /profiling info per request.
	Any inputs/suggestion are highly appreciated. Thanks

																																Xiaoxi
		 
