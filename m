From: nyao@cs.hku.hk
Subject: A bug in FileStore::mount and A problem about XFS
Date: Thu, 14 Aug 2014 12:07:42 +0800
Message-ID: <20140814120742.86212cn7dlk8dy4g@intranet.cs.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=GB2312;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.cs.hku.hk ([147.8.176.10]:38752 "EHLO mail.cs.hku.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbaHNENM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Aug 2014 00:13:12 -0400
Received: from intranet.cs.hku.hk (intranet.cs.hku.hk [147.8.175.19])
	by mail.cs.hku.hk (8.13.8+Sun/8.13.8) with ESMTP id s7E47kg5022566
	for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 12:07:47 +0800 (HKT)
Received: from intranet.cs.hku.hk (localhost.cs.hku.hk [127.0.0.1])
	by intranet.cs.hku.hk (8.13.8+Sun/8.13.7) with ESMTP id s7E47k5I007059
	for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 12:07:46 +0800 (HKT)
Received: (from daemon@localhost)
	by intranet.cs.hku.hk (8.13.8+Sun/8.13.8/Submit) id s7E47glh007058
	for ceph-devel@vger.kernel.org; Thu, 14 Aug 2014 12:07:42 +0800 (HKT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear developers,

I find a bug in FileStore::mount() function. If we use raw partitial  
as a Journal disk, like /dev/sda1, then it will cause a error when  
setting the parameters "m_filestore_max_inline_xattr_size" and  
"m_filestore_max_inline_xattrs".

First of all, when creating the FileStore, it calls the mount() and  
detect fs_type as XFS, so it will check  
m_filestore_replica_fadvise(true default) and set it to false. At the  
same time, m_fs_tpye = FS_TYPE_XFS.

However, when create JournalStore, it also enters mount() function and  
detect fs_type. Unfourtuanlly, this time, m_filestore_replica_fadvise  
= false so that it cannot update m_fs_type = FS_TYPE_XFS. Instread, it  
will sets to m_fs_tpye = FS_TYPE_OTHER. This bug is quite easy to  
repair.


By the way, I wanna ask another question about XFS, I find that if I  
use ceph cluster heavily for about 2-3 hour. XFS always wakes up a  
kernel thread (xfsaild) to deal with its inodes reading and writing.  
This will impact the performance a lot and make the cluster's  
throughput drop heavily. So how to solve this problem and why this  
occurs after running a heavily read, write operation after 2-3 hour.

Best Regards,
Neal Yao
