Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD233F5AE
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813944; cv=none; b=QE9IiAAy2RgfSwLvU4mnJeJ42XViLQSNwBKXZt8jo+N0cO8YkyJrtHZHGwJH2HpHr9IEnxLs7lH8IkUC1SBZrmdiaBoKf3sD2H1gMwbDlt0aLJAg13XutKYoipdCcJFEJYIoqBiiGWx/aqluW6pn279AlYYWRvfkGQdDyLOMutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813944; c=relaxed/simple;
	bh=7Ajrhkc9i/ZdyX+sMPpUniWfchRtptGSEStQltqVd6w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZVURT+VobUXb5Pe1mapwadwg4u7YIwebBmHrLRSsW1LebTe9yd8YgslbXgeeBwGpCRAoztNgVaz9FUsT9pAgvwIb73vwW6YdR8qiwP1hinpxjNUKTHktKtgga4WK3P7AcpU4bFXXW4nmbN1m9+QeG1NKjVFdBzrEX4GHHArs7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnrXb2gR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnrXb2gR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788813942; x=1820349942;
  h=date:from:to:cc:subject:message-id;
  bh=7Ajrhkc9i/ZdyX+sMPpUniWfchRtptGSEStQltqVd6w=;
  b=RnrXb2gRlTj3JviBX5MjHDujpe1zFpq2ykTG74fxubiyiPSUA71Xvtck
   oglEnW6EqrHySA8pSOxaTuXW1bqbzgMcb5APjP6n8LvC0YfkauTO37WUu
   4NOUIbIyx7g927htTr8T7ZXOPxmbedaTbLr56eRrshBJjzMWYGx+VIqNg
   wP4tcsJJhYmSeapsGVFRO+ttfwHtZdjv5bgVTy2dTiixR0/SDqrIBAvgO
   Ww0oZfkBBxJ9IhMFEqkM2k/M0zO5KiAr8xckbdtFN0ahRAwdHl8MKAjMN
   7d1pMc75V1Vi80vqxHwwJBGkv9M2YvgN5paeMz0aVfdFX6qtzGijAIN+5
   g==;
X-CSE-ConnectionGUID: UvDIr5AHQru62Ft0t0qoaA==
X-CSE-MsgGUID: Zns8TJ0qTqOVonb+ZDwvXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99873783"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99873783"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 13:45:40 -0700
X-CSE-ConnectionGUID: mDs9O4MgSdygbEICKiP1NA==
X-CSE-MsgGUID: /TOMRf53SR6VAwWnWm+1IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274311757"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 13:45:40 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3gDg-000000001Jj-3Me9;
	Mon, 07 Sep 2026 20:45:36 +0000
Date: Tue, 08 Sep 2026 04:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:testing 28/33] Warning:
 fs/ceph/blog_debugfs.c:78 function parameter 's' not described in
 'blog_entries_show'
Message-ID: <202609080421.HzFzmXp0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: 85ffb5e056aa9e09aaa537e5cb7746afe12731df [28/33] ceph: add BLOG debugfs interface
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609080421.HzFzmXp0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080421.HzFzmXp0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080421.HzFzmXp0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/ceph/blog_debugfs.c:78 function parameter 's' not described in 'blog_entries_show'
>> Warning: fs/ceph/blog_debugfs.c:78 function parameter 'p' not described in 'blog_entries_show'
>> Warning: fs/ceph/blog_debugfs.c:78 function parameter 's' not described in 'blog_entries_show'
>> Warning: fs/ceph/blog_debugfs.c:78 function parameter 'p' not described in 'blog_entries_show'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
