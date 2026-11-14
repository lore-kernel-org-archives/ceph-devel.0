Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634827;
	b=zsW6SZh0Y6sCg5FkXls9RMK0v3Zp5oNoHlRaWiDNFx8WvCfKihUuAQKufU/jzhOQox0p
	 iEnNSL+A6euupkaFvgyfXPewoU6P4ZhGIepoJIVW9vPhVCqsubyGrv6sLXC/T0S+o8zed
	 pfheERyDN+8bVF+PaeORaNPHN+tQ3oH6Ei6dNHEQKTlrobFeKgZt5QSaZYaofsFtsiNVr
	 a5txcKRIvQmS8j4G52Zcl7mr4HAPu+dKi5Ez3C/zwnzRiegMD+zo0czNuKSoVjKQWDser
	 nnzyxlqlyeeO4Mb3L2yXFklS7ga3ZzX7e3KqMY3e192q8szRiy4/lPsqdPUuqiki8uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634827;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=SeNeb6oYj5oGoonb9MGZ+Sk4LsaSO6fMvFrmMttvsDI=;
	b=5a5oH4YwZkhvzLl+5CDz430/MglwQIPkny1dZ7gkiSBgR+UwtCy9QuoXQ9JRMOul1EIG
	 1lOyMl3wfwond7Aql6F+UlhJxFhJ6Air876u4lfG6ZffD5tkCcsYmzTDb4ofNIVSrgRgj
	 b/KNya9+Qi8ri2Jb2yfc9jvmU4gY1Vn2dR6I45i4Ig3Q2j7i1MopmTPKjiLGn9JnsfoQm
	 R3uRUyboPvPAeTE+szuww8fm59DT/87/EB+gJbEPaSQXgCJKCWpbpg9kGC35jl93cAcgD
	 Rd4DyaUU54h/7I36jYajwuYsHcFFjMVVzZ09z8D19En2ZNG94vvn9ZMmf1eDhcDdrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aj98Tl+v;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DE606A32D
	for <ceph-devel@vger.kernel.org>; Sat, 14 Nov 2026 05:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A08DE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aj98Tl+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794634826; x=1826170826;
  h=date:from:to:cc:subject:message-id;
  bh=1+VA0oZJ1MlbOFl4iLs3s1djNxwsEg4Q5pEcdAPQXjE=;
  b=aj98Tl+v/YyZZuYwxpUrzCFKmPu4euezHcBgQdxuQ2oUn4d+OTj0Jtvh
   Q7QGKKVFrV6+mCjJfuNiRBeHWrO+shWyud10j5Pe/C2PZpbkgmoMk/aZU
   sZK1e9lWgZFJfKfZ52XdSWj1kpU6bYtJ9o/5wioqS3+tYVhgWFvzBKkA+
   fmIXg2QMtAn9uz+aEWDdZXo1Fy+Z/ygYgpQISmjiWTuL3qKZjUdptF2XG
   Vz4EgoC1PXHk5BOuJvPGByoApWJo5FGLJ9PDmCrFcRHvnbmmSpYKjXgHC
   eiXPW5Pqzy4Ww18sgNSxsg54opT0aphDW9tipZTIryo5knzAwXOXYjF5v
   g==;
X-CSE-ConnectionGUID: VrwverH1QG2bpYUrVKqFdg==
X-CSE-MsgGUID: N5EHQdQvRkaYisM702hwfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3459372"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3459372"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 21:40:26 -0800
X-CSE-ConnectionGUID: lVXOwViyQz+fLSC4PVUVvA==
X-CSE-MsgGUID: thfTVkHGQ16oM7CYech6BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="10872587"
Received: from igk-lkp-server01.igk.intel.com (HELO 1073a420ae3a) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 13 Nov 2026 21:40:25 -0800
Received: from kbuild by 1073a420ae3a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xS6Uw-000000001Up-42Uh;
	Sat, 14 Nov 2026 05:40:22 +0000
Date: Sat, 14 Nov 2026 06:39:48 +0100
From: kernel test robot <lkp@intel.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:wip-linger-ping-lat 7/7]
 net/ceph/debugfs.c:269:42: warning: unsequenced accesses to volatile
 qualified 'jiffies'
Message-ID: <202611140615.C6i3Z4Ih-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

tree:   https://github.com/ceph/ceph-client.git wip-linger-ping-lat
head:   1428966bcb1a1e537f406812f7d91f81a127431a
commit: 1428966bcb1a1e537f406812f7d91f81a127431a [7/7] libceph: include current latency in debugfs osdc dump
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20261114/202611140615.C6i3Z4Ih-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 8621950157210c1fa68f20f0614cb51310ec9dff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611140615.C6i3Z4Ih-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611140615.C6i3Z4Ih-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ceph/debugfs.c:269:42: warning: unsequenced accesses to volatile qualified 'jiffies' [-Wunsequenced]
     267 |                    req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,
         |                                           ~~~~~~~
     268 |                    lreq->is_watch && lreq->committed && !lreq->last_error ?
     269 |                         jiffies_to_msecs(jiffies - lreq->watch_valid_thru) : 0,
         |                                          ^
   1 warning generated.


vim +/jiffies +269 net/ceph/debugfs.c

   255	
   256	static void dump_linger_request(struct seq_file *s,
   257					struct ceph_osd_linger_request *lreq)
   258	{
   259		struct ceph_osd_request *req =
   260		    list_first_entry_or_null(&lreq->osd_reqs, struct ceph_osd_request,
   261					     r_private_item);
   262	
   263		seq_printf(s, "%llu\t", lreq->linger_id);
   264		dump_target(s, &lreq->t);
   265	
   266		seq_printf(s, "\t%u\t%u\t%u\t%s%s/%d\n", lreq->register_gen,
   267			   req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,
   268			   lreq->is_watch && lreq->committed && !lreq->last_error ?
 > 269	                        jiffies_to_msecs(jiffies - lreq->watch_valid_thru) : 0,
   270			   lreq->is_watch ? "W" : "N", lreq->committed ? "C" : "",
   271			   lreq->last_error);
   272	}
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
