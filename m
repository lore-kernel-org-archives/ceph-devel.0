Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760238C2BF
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601009; cv=none; b=gsk2UFqv6tAXFgm1Y8KrVlhBOpWXBzVjGHdnrJAU5/lqKl5eI01UMRaNowf9d3V+3h0+n+jgziRoYkqOb1RASwtwo8ZWC13qf9gYNhFLzW+/u8dcQErAsv2iI732zdF7LF0uk3Y8TeioBf/Yx07QOWJUUAMNMnxK9eQS6g1AuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601009; c=relaxed/simple;
	bh=UXxYWZFFShrRCFy3Z16bjG63cz1+TR1o+JshcDoj3sg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mcLW7kl5swSxTtEram1GPtGuT8huIxet/0BVItOugN8x4CTS9/vgejnbHzO59lEfE3sxdkN3yJ8ZlwwkoigpXZedvCt+psSpCcPIizjaSTqDF8nAKPKPM7/YqLPZDzeKgiSnQJ5oM40jXBLV43A8vEyXvHgeaZIGayzzSZyCs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nks1HJis; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nks1HJis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787601009; x=1819137009;
  h=date:from:to:cc:subject:message-id;
  bh=UXxYWZFFShrRCFy3Z16bjG63cz1+TR1o+JshcDoj3sg=;
  b=Nks1HJisrU4oUC0r6JhG6+99ckLD6QVxfuCZ5n+72DChRKfSYLwhxo8e
   ocPyRGpI4bUUQZlpEVSVCLc7Ie1dGwcW8N7qeNRVS/RNczEn+IjVfYpy3
   Fsxs75gvpBfpHgfp1hcBMOTx6RQVczVWg/U7gb18kNFWB3mvGLiOb5E+G
   Vbf229GYAM7HMKhe62f+CkYQae4cfYaKTmiI8fTxXzp09YcuUwlTtLPzD
   CnD1YkLF4wVuADLvVgc9MPokXGIZS31RdD+Ahoc18kRYFXY2cGhBAlDsD
   nV+ArDrooapbHfR3ym94ONz4d6yWgSLa/hmSk7vAodqGAj75JkO9gFZ37
   Q==;
X-CSE-ConnectionGUID: 9is6yGO6TGW5vavYmSrGbQ==
X-CSE-MsgGUID: +tz7RnjeQzCGOTvqGeOxPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98652730"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98652730"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:50:08 -0700
X-CSE-ConnectionGUID: qn9HjgheS3SwdwV5684QTQ==
X-CSE-MsgGUID: 3MATyXT4Sti/nIGBN8LsCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="296997714"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Aug 2026 12:50:06 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyagA-000000003wH-2o6U;
	Mon, 24 Aug 2026 19:50:00 +0000
Date: Tue, 25 Aug 2026 03:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Alex Markuze <amarkuze@redhat.com>
Subject: [ceph-client:testing 47/48] ERROR: modpost: "__umoddi3"
 [fs/ceph/ceph.ko] undefined!
Message-ID: <202608250336.p7NBvgnZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   86f405187248b7a5a2104eba07f941d27593893e
commit: 68477e9bc0513dd9a887745f2af468f2f18526c0 [47/48] ceph: parallelize object copy in ceph_do_objects_copy()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260825/202608250336.p7NBvgnZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250336.p7NBvgnZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250336.p7NBvgnZ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [fs/ceph/ceph.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
