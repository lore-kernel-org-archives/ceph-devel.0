From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ceph:wip-fs-filelayout2 6/6] fs/ceph/addr.c:1924:21: sparse:
 incompatible types in comparison expression (different address spaces)
Date: Sat, 6 Feb 2016 15:55:26 +0800
Message-ID: <201602061523.yXzKT1hu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39236 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcBFH4e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Feb 2016 02:56:34 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: kbuild-all@01.org, ceph-devel@vger.kernel.org

tree:   https://github.com/ceph/ceph-client.git wip-fs-filelayout2
head:   5cce5429b595d3ef4211ff7afa7d08606f15eebd
commit: 5cce5429b595d3ef4211ff7afa7d08606f15eebd [6/6] ceph: rados pool namesapce support
reproduce:
        # apt-get install sparse
        git checkout 5cce5429b595d3ef4211ff7afa7d08606f15eebd
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> fs/ceph/addr.c:1924:21: sparse: incompatible types in comparison expression (different address spaces)

vim +1924 fs/ceph/addr.c

  1908		}
  1909	
  1910		pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
  1911		ret = __ceph_pool_perm_get(ci, pool, pool_ns);
  1912		ceph_put_string(pool_ns);
  1913		if (ret < 0)
  1914			return ret;
  1915	
  1916		flags = CEPH_I_POOL_PERM;
  1917		if (ret & POOL_READ)
  1918			flags |= CEPH_I_POOL_RD;
  1919		if (ret & POOL_WRITE)
  1920			flags |= CEPH_I_POOL_WR;
  1921	
  1922		spin_lock(&ci->i_ceph_lock);
  1923		if (pool == ci->i_layout.pool_id &&
> 1924		    pool_ns == ci->i_layout.pool_ns) {
  1925			ci->i_ceph_flags |= flags;
  1926	        } else {
  1927			pool = ci->i_layout.pool_id;
  1928			flags = ci->i_ceph_flags;
  1929		}
  1930		spin_unlock(&ci->i_ceph_lock);
  1931		goto check;
  1932	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
