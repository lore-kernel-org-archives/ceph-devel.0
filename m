Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732A43C7B7;
	Tue, 11 Aug 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444743; cv=none; b=q4OWfVKgN8ihsGblG2aK+e5GfrgwyKGmwI10lce+H/QNLGnO7spgg9iEGIK6bkCqQmH6L3T/+35+fKiWEIg3mfW3etrgWI8DSSg5ERGHM2hsXA0VyPbGli02+HJp7yCGbvZ9zEd8+jPewSVGlr16LneML1nhnK+22//iXC0jaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444743; c=relaxed/simple;
	bh=jwO17BvW0LE4M6CAaZo40/sLE1sy6tyERlG4pIzYVg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLJ03dJRd+B8rLOLV321FwIyA57Xt8s2fyvxsYO+WHUBjcjFKX8WRvNmPhyCk2o4J0vAhd3u1RjI1b9HZYJ6MCDsQeQAbVDzTYvChgidvZFB2t5uo1xqbuGQTLee5ZoxDMbWl0wJdncYLBxMtVUQxwEOTA+A1ffSmqztdXgvh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDlKw3Ag; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDlKw3Ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786444740; x=1817980740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jwO17BvW0LE4M6CAaZo40/sLE1sy6tyERlG4pIzYVg8=;
  b=WDlKw3AgAAHoJFF93oGJzXM0XS0Wmj24DHt01Xtie8nH9ZmyjxGchFxq
   4F7WeBjb1Q7/2c7UGpwvaqFeADwdyYgA2M4fpaXd6fGvtdE7PN5iMd1Jy
   UQ6cLNVEqRlbX4Y8YiOlKCBn7OKcqS/vp+Yl8EQNoXT2QBUtXnkT/oQLS
   9dZLev5tKMVltEov3BYPj8XYmTntCInb1u3adym9PGSCzg7QBE2rSV6Md
   EAduLJRfOCBZteMstJgKCl1J63660c0IcAVYpLZebwUFnVi+CTtJb4Fy/
   094zElZg+YuHtaesIdqhduypYN3GkULN1xY6hGOcmJWFYHNOFDRE1r+6F
   g==;
X-CSE-ConnectionGUID: Rhr1d80LTpiZeZglxOWjOA==
X-CSE-MsgGUID: aA48XytNSC6PDXKO/12d0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86850229"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86850229"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:38:59 -0700
X-CSE-ConnectionGUID: /l9KYuN+RKK/liUirRpbfA==
X-CSE-MsgGUID: 1EGawnJ3RH+qxrYaz4gqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259994522"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Aug 2026 03:38:57 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtjsk-00000000OZS-1iZR;
	Tue, 11 Aug 2026 10:38:54 +0000
Date: Tue, 11 Aug 2026 18:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] fs/ceph/dir: __{dir,dentry}_lease_check() returns an enum
Message-ID: <202608112020.5nTx1rdC-lkp@intel.com>
References: <20260709104121.884183-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709104121.884183-1-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceph-client/testing]
[also build test WARNING on ceph-client/for-linus linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/fs-ceph-dir-__-dir-dentry-_lease_check-returns-an-enum/20260811-130303
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20260709104121.884183-1-max.kellermann%40ionos.com
patch subject: [PATCH] fs/ceph/dir: __{dir,dentry}_lease_check() returns an enum
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260811/202608112020.5nTx1rdC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260811/202608112020.5nTx1rdC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608112020.5nTx1rdC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/ceph/dir.c:1634 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Result of __dir_lease_check() and __dentry_lease_check().

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
