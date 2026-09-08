Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF0C399D0D
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2026 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855030; cv=none; b=Lt9z9p0a7NoJ5A4vLzE1GMJ/I0HVQm8yJvTJt6GIOucUNYg0qpUmikreKx2/l/82loeDJD/g0TmNIOgoRiKT9KjegMjxsc9NpN0fs9tLZuh1sW7m3ySvjejfTqHxquXkNwGA4Zzsd20fFWGVbhHWuU/aNBm6EWvoPphJC4haitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855030; c=relaxed/simple;
	bh=s1zVA2H/PKWK5iinunasHDlpz232xSDYGJsJyKsppgc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PudUYufFOkiFRiAK6I0teyBMQmIsaU5Md5cemC+2/r75QLj4epRhr2lnRtMyZpFFcjn5KMIrq/qbPboxnp6BgFa5gyrxhQLxygfnYxTqdp8Z0h0wS8DHArIPqH7RXFr3lFP6zWUuI0ijxpwcB3vG41IvBIJvcUJcr3MMkD/VQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDpVyCsq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDpVyCsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788855027; x=1820391027;
  h=date:from:to:cc:subject:message-id;
  bh=s1zVA2H/PKWK5iinunasHDlpz232xSDYGJsJyKsppgc=;
  b=XDpVyCsqPgznC8+8zPvcfwMxyBvnu1sB63pKx/pgky4jCZfg694MFq8C
   Rm+nlgdjlvYIETvoyFHahIWcazEVc+g+WZHDzosC4YIJ5gJtofj1u7qer
   5QJxJKv0XSsHOktMAJTHs5v1hYagSbnHCNr/D1vUpt6HjwEQwoA/PWPjx
   n92KLfne5IqESR608bHhp2B/ZSrbgs3Jq3UBTUeOScYKPESRyuiC/wk18
   2jcoGats1d/n8FAVrchGgshql1ehf5nq1ixKUIvRG6D8+xxj/dSzNmH/K
   kSroELvGpmCi1QQooI1wSP0hFcwLf6ICj/yYuEtnnWp/PnxgRDYmnDOuN
   g==;
X-CSE-ConnectionGUID: axnk0y/bR225jh9tv0BqlQ==
X-CSE-MsgGUID: CbPGdn9tSH+LfccFh03Alw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89094165"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89094165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:10:27 -0700
X-CSE-ConnectionGUID: nN0LrCqGSrGlNWEF8ZM36w==
X-CSE-MsgGUID: gFLDhIGoRoarDvmRm4m37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="275064872"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 01:10:24 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3quJ-000000001s1-1eZN;
	Tue, 08 Sep 2026 08:10:19 +0000
Date: Tue, 08 Sep 2026 16:09:33 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 29/33] fs/ceph/export.c:90:9: sparse:
 sparse: non size-preserving pointer to integer cast
Message-ID: <202609081512.3JH2caOg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: fd5e42ddd4a0b8d56a2160d51b6ee07c96b501e9 [29/33] ceph: convert VFS inode and directory paths to bout
config: nios2-randconfig-r133-20260908 (https://download.01.org/0day-ci/archive/20260908/202609081512.3JH2caOg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609081512.3JH2caOg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609081512.3JH2caOg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/export.c:90:9: sparse: sparse: non size-preserving pointer to integer cast
>> fs/ceph/export.c:90:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/export.c:90:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:125:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:133:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:133:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:133:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:300:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:300:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:302:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:302:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:302:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:339:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:438:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:438:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:438:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:438:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:473:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:588:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:588:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:588:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:588:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/export.c:657:9: sparse: sparse: non size-preserving pointer to integer cast
--
>> fs/ceph/dir.c:125:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:202:9: sparse: sparse: non size-preserving pointer to integer cast
>> fs/ceph/dir.c:202:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/dir.c:202:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/dir.c:202:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:233:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:233:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:233:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:233:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:275:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:275:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:275:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:275:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:345:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:345:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:345:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:345:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:345:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:354:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:354:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:354:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:371:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:371:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:371:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:432:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:432:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:432:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:432:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:492:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:492:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:492:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:527:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:527:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:527:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:556:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:556:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:556:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:556:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:556:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:595:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:645:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:645:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:645:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:661:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:661:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:661:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:669:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:669:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:676:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:676:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:676:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:676:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:748:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:748:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:748:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:748:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:787:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:819:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:819:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:819:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:869:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:869:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:869:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:869:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:869:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:899:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:899:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:911:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:911:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:954:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1015:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1140:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1140:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1140:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1140:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1140:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1219:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1219:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1219:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1219:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1224:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1224:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1224:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1224:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1224:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1332:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1332:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1332:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/dir.c:1332:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/dir.c:1332:9: sparse: sparse: non size-preserving pointer to integer cast
--
>> fs/ceph/inode.c:345:9: sparse: sparse: non size-preserving pointer to integer cast
>> fs/ceph/inode.c:345:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/inode.c:345:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:462:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:462:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:462:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:468:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:468:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:468:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:493:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:493:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:493:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:558:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:558:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:558:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:757:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:757:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:757:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:783:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:892:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:892:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:937:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:937:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:945:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:945:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1008:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1008:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1014:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1014:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1023:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1023:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1027:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1027:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1047:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1115:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1115:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1115:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1115:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1115:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1212:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1212:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1212:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1212:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1284:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1284:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1425:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1435:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1435:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1506:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1645:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1645:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1645:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1645:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1645:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1652:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1652:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1652:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1652:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1680:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1680:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1680:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1750:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1750:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1750:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1759:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1759:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1759:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1779:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1779:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1864:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1864:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1864:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1864:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1866:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1866:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1873:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1873:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1873:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1873:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1880:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1880:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1896:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1926:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/inode.c:1938:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1949:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:1949:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2074:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2127:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2130:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2174:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2174:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2174:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2181:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2181:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2181:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2200:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2200:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/inode.c:2252:33: sparse: sparse: non size-preserving pointer to integer cast

vim +90 fs/ceph/export.c

    35	
    36	#define BYTES_PER_U32		(sizeof(u32))
    37	#define CEPH_FH_BASIC_SIZE \
    38		(sizeof(struct ceph_nfs_fh) / BYTES_PER_U32)
    39	#define CEPH_FH_WITH_PARENT_SIZE \
    40		(sizeof(struct ceph_nfs_confh) / BYTES_PER_U32)
    41	#define CEPH_FH_SNAPPED_INODE_SIZE \
    42		(sizeof(struct ceph_nfs_snapfh) / BYTES_PER_U32)
    43	
    44	static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
    45				      struct inode *parent_inode)
    46	{
    47		struct ceph_client *cl = ceph_inode_to_client(inode);
    48		static const int snap_handle_length = CEPH_FH_SNAPPED_INODE_SIZE;
    49		struct ceph_nfs_snapfh *sfh = (void *)rawfh;
    50		u64 snapid = ceph_snap(inode);
    51		int ret;
    52		bool no_parent = true;
    53	
    54		if (*max_len < snap_handle_length) {
    55			*max_len = snap_handle_length;
    56			ret = FILEID_INVALID;
    57			goto out;
    58		}
    59	
    60		ret =  -EINVAL;
    61		if (snapid != CEPH_SNAPDIR) {
    62			struct inode *dir;
    63			struct dentry *dentry = d_find_alias(inode);
    64			if (!dentry)
    65				goto out;
    66	
    67			rcu_read_lock();
    68			dir = d_inode_rcu(dentry->d_parent);
    69			if (ceph_snap(dir) != CEPH_SNAPDIR) {
    70				sfh->parent_ino = ceph_ino(dir);
    71				sfh->hash = ceph_dentry_hash(dir, dentry);
    72				no_parent = false;
    73			}
    74			rcu_read_unlock();
    75			dput(dentry);
    76		}
    77	
    78		if (no_parent) {
    79			if (!S_ISDIR(inode->i_mode))
    80				goto out;
    81			sfh->parent_ino = sfh->ino;
    82			sfh->hash = 0;
    83		}
    84		sfh->ino = ceph_ino(inode);
    85		sfh->snapid = snapid;
    86	
    87		*max_len = snap_handle_length;
    88		ret = FILEID_BTRFS_WITH_PARENT;
    89	out:
  > 90		boutc(cl, "%p %llx.%llx ret=%d\n", inode, ceph_vinop(inode), ret);
    91		return ret;
    92	}
    93	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
