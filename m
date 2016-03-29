From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ceph:wip-file-layout2 5/5] fs/ceph/inode.c:959:25: sparse:
 incompatible types in comparison expression (different address spaces)
Date: Tue, 29 Mar 2016 19:07:29 +0800
Message-ID: <201603291926.2UQLadif%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9139 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824AbcC2LIo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Mar 2016 07:08:44 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: kbuild-all@01.org, ceph-devel@vger.kernel.org

tree:   https://github.com/ceph/ceph-client.git wip-file-layout2
head:   0fb410133c4abf54314ef21893fe9a60a59faf35
commit: 0fb410133c4abf54314ef21893fe9a60a59faf35 [5/5] ceph: rados namespace support
reproduce:
        # apt-get install sparse
        git checkout 0fb410133c4abf54314ef21893fe9a60a59faf35
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:232:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> fs/ceph/inode.c:959:25: sparse: incompatible types in comparison expression (different address spaces)

vim +959 fs/ceph/inode.c

   943			ceph_queue_vmtruncate(inode);
   944	
   945		/* populate frag tree */
   946		if (S_ISDIR(inode->i_mode))
   947			ceph_fill_fragtree(inode, &info->fragtree, dirinfo);
   948	
   949		/* update delegation info? */
   950		if (dirinfo)
   951			ceph_fill_dirfrag(inode, dirinfo);
   952	
   953		err = 0;
   954	out:
   955		if (new_cap)
   956			ceph_put_cap(mdsc, new_cap);
   957		if (xattr_blob)
   958			ceph_buffer_put(xattr_blob);
 > 959		ceph_put_layout(rcu_dereference_raw(layout));
   960		return err;
   961	}
   962	
   963	/*
   964	 * caller should hold session s_mutex.
   965	 */
   966	static void update_dentry_lease(struct dentry *dentry,
   967					struct ceph_mds_reply_lease *lease,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
