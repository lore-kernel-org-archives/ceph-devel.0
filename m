Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7F3AA50B
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471981; cv=none; b=Ta69GjZo9wAi78E0mjK+t79qWczK4QvRxGo6VyXKjtT/82pBYZXrelbknkcSkXttXfSE9cNrUChMRPZqRJjK4cyuzbemneTNAxwFLWgkab3th9B+DO247vKqPUlGjcVj3y21cBhdmu7LX31ORnIsPr1W9fNKJUusp6v6UFDMe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471981; c=relaxed/simple;
	bh=h8Cfq8fNB5Tq5vnwC6sLl9TTBy3oYEk7Y97jCWMouJA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DVs/EMTlbzXCCQ5lRoKoEq8PbYY+lu9sApNNQUtfE0HLutWe5oMb5zB32thhZg0aNblrFWEHoqCSGoeeIEoLtrsQlOQ222kAOS2W4N9R6/puf2Ch2WNAItyPxbXifjmBM6soDCCdiHN+nzSPtUM6Cm1jed41rNI7dsN+Jh2ZWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWX3yl9r; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWX3yl9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783471980; x=1815007980;
  h=date:from:to:cc:subject:message-id;
  bh=h8Cfq8fNB5Tq5vnwC6sLl9TTBy3oYEk7Y97jCWMouJA=;
  b=cWX3yl9rv0k7cq0Sk/lgv/wxmEUTvvhhlwchTTTKHYo0C0HjSM91CPOW
   6yektKLlt5ztxnFO1Bp1/9ScQXsIrzj2ECEHpx/y4ivtQC/5Kw5PhA2hO
   iSqDcSlARpur7nTm4xUlWSOweMM9Hy2lAAhnjFmmZjoZF87w7nhJBsSIl
   r89JUMiR808rnVqiePiW6LUmSAV3bypt27UOVGsN7FFtbxaZ+3EMfE0La
   ABr6VA2/HlQV08PzW1wPMeWiqRUt68IKplUi1o949JICX51lnkARpjYE8
   bci3S9IP7Jf1Qg34XQhmNG4Z6m6ZCNPwqDA6ufmqxHdoi4AIDlE6dpyyc
   w==;
X-CSE-ConnectionGUID: lF9mdOpzQ2O+92p4ODkcGA==
X-CSE-MsgGUID: Y0xsH6pVS5O7QOpecSKuXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84225176"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84225176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 17:52:59 -0700
X-CSE-ConnectionGUID: Oh/uSeS/Ty6+uqb3k2Un2w==
X-CSE-MsgGUID: kGYVHpLXQiuFWGhhDc2z6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250787263"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 07 Jul 2026 17:52:57 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whGX0-000000002eD-3IrT;
	Wed, 08 Jul 2026 00:52:54 +0000
Date: Wed, 08 Jul 2026 02:52:18 +0200
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Alex Markuze <amarkuze@redhat.com>
Subject: [ceph-client:testing 25/27] fs/ceph/super.h:60:43: error:
 'CEPH_MOUNT_OPT_NEARFULL_SYNC' undeclared; did you mean
 'CEPH_MOUNT_OPT_DEFAULT'?
Message-ID: <202607080215.nhKQKwuZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   fc67edb66b3c9924c4e0bb366a92b32ea13c526a
commit: cb4ac0e6565fe667dba2760b6a012306e6f796e0 [25/27] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260708/202607080215.nhKQKwuZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260708/202607080215.nhKQKwuZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607080215.nhKQKwuZ-lkp@intel.com/

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
      60 |         (!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
         |                                           ^~~~~~~~~~~~~~~
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
