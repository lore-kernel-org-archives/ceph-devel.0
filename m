Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F543CECC
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513090; cv=none; b=SVPNedZiJrNIhRLcGZHZ/xhkKC5/MqwhaH077hdciM3xVDqQQVGg60ynSDxBz+q0YmkJB5Gn8DgTgwKIW1XMQBIma7VFH7q5ZVxlLmHwHMa6K+iS87A6MERN6tScjaYO+LW/TRGxNo7P4wWgvTaPl8Jn0t0n6J9eSMmN9Z2VPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513090; c=relaxed/simple;
	bh=xY7MmDUXYT5M8fK1mIEqLU/hPG2jut359lSrc9T9JOw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ekSyiFGgE4xkjiyxjLNk8ng1npdwPRfKwZ+aEfjQ+SZJvEYLBjZqsC7hIb6PHiSlOhbdN603yOfudTY/gu9V3vw/ppIXcKpRxEvUJQ++FvRYNfUWiS1sSRB//Yo2CEJpIXL9pKC1G2VjZP50FVA4OiWcIcx6oe13Wlb5ioQB3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYwydYwo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYwydYwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783513088; x=1815049088;
  h=date:from:to:cc:subject:message-id;
  bh=xY7MmDUXYT5M8fK1mIEqLU/hPG2jut359lSrc9T9JOw=;
  b=TYwydYwoLxHQIpwv/BAtJzXRLlZEWoHCoZRbibySloNa/bdzIlnqYQIz
   DeX05uJOWMpWuKnO4qwTb9KHJc6feRqmt4myuazslwD0b8Kqg38IldtqR
   uUMeaqI9qwNWaEmxmIUCZf2NzHyhBVf5QzVvlvjzsMZtAzGMuCVRt1f0I
   GNonY5lNVjBpUv/CoOrOWeDPXPxq3s8w27uoBdyX2Tmm1RHjK3mI3xhZ3
   YN4qdUxDefIxHdBV7Mxk589U0JvxZTUIeO7/XAyuQ35BIWo7ZmFPWwe7l
   WagFmroULX3F7SMDw7h4OwZyRsSyytF37hEHoAD+y42Z3369MQ2oSMmeS
   w==;
X-CSE-ConnectionGUID: tFdz2jI7TmipIIRROk69JQ==
X-CSE-MsgGUID: OlusofXLTIOBfEjztvNkyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="71694193"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="71694193"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 05:18:07 -0700
X-CSE-ConnectionGUID: xaw/PQO0T7OSB+N6/RjUVA==
X-CSE-MsgGUID: HZNjucsJQg2laeoegfbczQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278654052"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2026 05:18:05 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whRDt-00000000GLn-2M1U;
	Wed, 08 Jul 2026 12:17:57 +0000
Date: Wed, 08 Jul 2026 20:17:26 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Alex Markuze <amarkuze@redhat.com>
Subject: [ceph-client:testing 25/27] fs/ceph/super.h:60:43: error:
 'CEPH_MOUNT_OPT_NEARFULL_SYNC' undeclared; did you mean
 'CEPH_MOUNT_OPT_DEFAULT'?
Message-ID: <202607082010.oE2EyFrA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   fc67edb66b3c9924c4e0bb366a92b32ea13c526a
commit: cb4ac0e6565fe667dba2760b6a012306e6f796e0 [25/27] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260708/202607082010.oE2EyFrA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260708/202607082010.oE2EyFrA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607082010.oE2EyFrA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ceph/file.c:17:
   fs/ceph/file.c: In function 'ceph_write_iter':
>> fs/ceph/super.h:60:43: error: 'CEPH_MOUNT_OPT_NEARFULL_SYNC' undeclared (first use in this function); did you mean 'CEPH_MOUNT_OPT_DEFAULT'?
      60 |         (!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
         |                                           ^~~~~~~~~~~~~~~
   fs/ceph/file.c:2573:21: note: in expansion of macro 'ceph_test_mount_opt'
    2573 |                 if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
         |                     ^~~~~~~~~~~~~~~~~~~
   fs/ceph/super.h:60:43: note: each undeclared identifier is reported only once for each function it appears in
   fs/ceph/file.c:2573:21: note: in expansion of macro 'ceph_test_mount_opt'
    2573 |                 if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
         |                     ^~~~~~~~~~~~~~~~~~~


vim +60 fs/ceph/super.h

6a2593823ababd Sage Weil      2010-07-07  49  
6f9718fe41c3a4 Luis Henriques 2018-12-10  50  #define CEPH_MOUNT_OPT_DEFAULT			\
6f9718fe41c3a4 Luis Henriques 2018-12-10  51  	(CEPH_MOUNT_OPT_DCACHE |		\
f7a67b463fb83a Jeff Layton    2021-08-09  52  	 CEPH_MOUNT_OPT_NOCOPYFROM |		\
f7a67b463fb83a Jeff Layton    2021-08-09  53  	 CEPH_MOUNT_OPT_ASYNC_DIROPS)
de57606c23afde Sage Weil      2009-10-06  54  
3d14c5d2b6e15c Yehuda Sadeh   2010-04-06  55  #define ceph_set_mount_opt(fsc, opt) \
2ccb45462aeaf0 Jeff Layton    2019-04-02  56  	(fsc)->mount_options->flags |= CEPH_MOUNT_OPT_##opt
2ccb45462aeaf0 Jeff Layton    2019-04-02  57  #define ceph_clear_mount_opt(fsc, opt) \
2ccb45462aeaf0 Jeff Layton    2019-04-02  58  	(fsc)->mount_options->flags &= ~CEPH_MOUNT_OPT_##opt
3d14c5d2b6e15c Yehuda Sadeh   2010-04-06  59  #define ceph_test_mount_opt(fsc, opt) \
3d14c5d2b6e15c Yehuda Sadeh   2010-04-06 @60  	(!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
de57606c23afde Sage Weil      2009-10-06  61  

:::::: The code at line 60 was first introduced by commit
:::::: 3d14c5d2b6e15c21d8e5467dc62d33127c23a644 ceph: factor out libceph from Ceph file system

:::::: TO: Yehuda Sadeh <yehuda@hq.newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
