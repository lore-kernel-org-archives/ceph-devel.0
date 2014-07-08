From: nyao@cs.hku.hk
Subject: Problem with slow operation on xattr
Date: Tue, 08 Jul 2014 16:17:17 +0800
Message-ID: <20140708161717.95584lly2blerls0@intranet.cs.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=GB2312;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.cs.hku.hk ([147.8.176.10]:51482 "EHLO mail.cs.hku.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbaGHIfg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jul 2014 04:35:36 -0400
Received: from intranet.cs.hku.hk (intranet.cs.hku.hk [147.8.175.19])
	by mail.cs.hku.hk (8.13.8+Sun/8.13.8) with ESMTP id s688HKUX005814
	for <ceph-devel@vger.kernel.org>; Tue, 8 Jul 2014 16:17:20 +0800 (HKT)
Received: from intranet.cs.hku.hk (localhost.cs.hku.hk [127.0.0.1])
	by intranet.cs.hku.hk (8.13.8+Sun/8.13.7) with ESMTP id s688HK7Y020726
	for <ceph-devel@vger.kernel.org>; Tue, 8 Jul 2014 16:17:20 +0800 (HKT)
Received: (from daemon@localhost)
	by intranet.cs.hku.hk (8.13.8+Sun/8.13.8/Submit) id s688HHU9020725
	for ceph-devel@vger.kernel.org; Tue, 8 Jul 2014 16:17:17 +0800 (HKT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear all developers,

I use the rbd kernel module on the client-end, and when we test the  
random write performance. The throughput is quit poor and always drops  
to zero.

And I trace the development logs on the server-side and find that it  
is always blocked in the function: get_object_context, getattr() and  
_setattrs. The average time os about hundreds of milliseconds. Even  
bad, the maximum latency is up to 4-6 seconds, so the throughput  
observed on the client-side is always blocked several seconds. This is  
really ruining the performance of the cluster.

Therefore, I carefully analyze those functions mentioned above  
(get_object_context, getattr() and _setattrs). I cannot find any  
blocked code except for the system calls for xattr like (fgetattr,  
fsetattr, flistattr).

On the OSD node, I use the xfs file system as the underlying osd file  
system. And by default, it will use the extend attribute feature of  
the xfs to store ceph.user xattr (??_?? and ??snapset??). Since those  
system calls are synchronized function call, I set the io-scheduler of  
the disk to [Deadline] so that no reading meta-data will be blocked a  
long time before it will be served. However, even though, the  
performance is still quite poor and those functions mentioned above  
are still blocked, sometimes, up to several seconds.

Therefore, I wanna know that how to solve this problem, does ceph  
provide any user-space cache for xattr?

Does this problem caused by xfs file-system, its xattr system calls?

Furthermore, I try to stop the feature of xfs xattr by setting  
??filestore_max_inline_xattrs_xfs = 0?? &&  
??filestore_max_inline_xattr_size_xfs = 0??. So the xattr key/value  
pair will be stored in omap implemented by LevelDB. It solves the  
problem a bit, the maximum blocked interval drops to about 1-2 second.  
But if the xattr read from the physical disk not the page cache, it  
still quite slow.
So I wonder that is it a good idea to cache all xattr data in  
use_space cache as for xattr, ??_??, the length is just 242 bytes if  
we use xfs file-system? For hundred thousands of Objects, it will cost  
just less than 100MB.


Best Regards,
Neal Yao
