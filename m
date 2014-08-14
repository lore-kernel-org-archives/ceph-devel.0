From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: A bug in FileStore::mount and A problem about XFS
Date: Thu, 14 Aug 2014 07:09:12 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8B7053@SHSMSX101.ccr.corp.intel.com>
References: <20140814120742.86212cn7dlk8dy4g@intranet.cs.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27795 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbaHNHJQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 03:09:16 -0400
In-Reply-To: <20140814120742.86212cn7dlk8dy4g@intranet.cs.hku.hk>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "nyao@cs.hku.hk" <nyao@cs.hku.hk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think you got the old code. I'm not find FX_TYPE_OTHER


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of nyao@cs.hku.hk
> Sent: Thursday, August 14, 2014 12:08 PM
> To: ceph-devel@vger.kernel.org
> Subject: A bug in FileStore::mount and A problem about XFS
> 
> 
> Dear developers,
> 
> I find a bug in FileStore::mount() function. If we use raw partitial as a Journal
> disk, like /dev/sda1, then it will cause a error when setting the parameters
> "m_filestore_max_inline_xattr_size" and "m_filestore_max_inline_xattrs".
> 
> First of all, when creating the FileStore, it calls the mount() and detect fs_type
> as XFS, so it will check m_filestore_replica_fadvise(true default) and set it to
> false. At the same time, m_fs_tpye = FS_TYPE_XFS.
> 
> However, when create JournalStore, it also enters mount() function and detect
> fs_type. Unfourtuanlly, this time, m_filestore_replica_fadvise = false so that it
> cannot update m_fs_type = FS_TYPE_XFS. Instread, it will sets to m_fs_tpye =
> FS_TYPE_OTHER. This bug is quite easy to repair.
> 
> 
> By the way, I wanna ask another question about XFS, I find that if I use ceph
> cluster heavily for about 2-3 hour. XFS always wakes up a kernel thread (xfsaild)
> to deal with its inodes reading and writing.
> This will impact the performance a lot and make the cluster's throughput drop
> heavily. So how to solve this problem and why this occurs after running a heavily
> read, write operation after 2-3 hour.
> 
> Best Regards,
> Neal Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
