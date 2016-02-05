From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ceph:wip-fs-filelayout2 2/6] net/ceph/pool_ns.c:112:14: sparse:
 incompatible types in comparison expression (different address spaces)
Date: Fri, 5 Feb 2016 23:02:17 +0800
Message-ID: <201602052313.e32b8EyC%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcBEPDl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 10:03:41 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: kbuild-all@01.org, ceph-devel@vger.kernel.org

tree:   https://github.com/ceph/ceph-client.git wip-fs-filelayout2
head:   f3d10f2b8cb86727e6a25e2817818cdb91ce7b49
commit: 1dcfb90ff006e0bb9311a3f13afbffd442125155 [2/6] libceph: introduce pool namespace cache
reproduce:
        # apt-get install sparse
        git checkout 1dcfb90ff006e0bb9311a3f13afbffd442125155
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> net/ceph/pool_ns.c:112:14: sparse: incompatible types in comparison expression (different address spaces)

vim +112 net/ceph/pool_ns.c

    96	
    97		spin_lock(&pool_ns_lock);
    98		if (!RB_EMPTY_NODE(&ns->node)) {
    99			rb_erase(&ns->node, &pool_ns_tree);
   100			RB_CLEAR_NODE(&ns->node);
   101		}
   102		spin_unlock(&pool_ns_lock);
   103	
   104		call_rcu(&ns->rcu, ceph_free_pool_ns);
   105	}
   106	EXPORT_SYMBOL(ceph_release_pool_ns);
   107	
   108	struct ceph_pool_ns *ceph_try_get_pool_ns(struct ceph_pool_ns **pns)
   109	{
   110		struct ceph_pool_ns *ns;
   111		rcu_read_lock();
 > 112		ns = rcu_dereference(*pns);
   113		if (ns && !kref_get_unless_zero(&ns->kref))
   114			ns = NULL;
   115		rcu_read_unlock();
   116		return ns;
   117	}
   118	EXPORT_SYMBOL(ceph_try_get_pool_ns);
   119	
   120	void ceph_pool_ns_cleanup(void)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
