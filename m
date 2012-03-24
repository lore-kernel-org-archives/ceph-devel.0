From: lixiaobing10@otcaix.iscas.ac.cn
Subject: problems when hadoop runs upon ceph
Date: Sat, 24 Mar 2012 15:18:46 +0800 (CST)
Message-ID: <1765b87.66.136439257f9.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [124.16.137.195] ([124.16.137.195]:43942 "EHLO
	otcaix.iscas.ac.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2CXH0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Mar 2012 03:26:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi ceph-devel,

I installed ceph-0.44, which can be mounted by ceph-fuse correctly. Besides, hadoop-0.20.205.0 patched with hadoop-0.20.205.0-cephfs1.patch can run correctly too, but with hdfs as the underlying fs. (refered to http://ceph.newdream.net/wiki/Hadoop_FileSystem)

However, when I let hadoop use ceph as the fs, I encountered this problem: 

12/03/24 14:45:47 INFO ceph.CephFileSystem: initialize:Ceph initialization arguments: CephFSInterface -k /data/keyring.mds.0 -n client.admin --auth-supported=cephx  -m 192.168.122.201:6789 --client-readahead-max-periods=1
12/03/24 14:45:47 FATAL ceph.CephFileSystem: initialize:Ceph initialization failed!
Bad connection to FS. command aborted. exception: Ceph initialization failed!

I have traced the source code from java-side to ceph-side, and found the connection between them failed to establish. But I have no idea about the real cause. Could someone give me any suggestion on this problem?

Additionally, hadoop-0.20.205.0 patched with hadoop-0.20.205.0-cephfs1.patch can work with ceph-0.20.1, although it would crashed during reduce task phase, and that is why I turned to the latest ceph version.

Thanks for your attention!

Best,
Xiaobing
