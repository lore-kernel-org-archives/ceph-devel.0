Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009982;
	b=D7+be0GxxwivYVT4Yf7ZwfGhWJPmRXqruAYhw5dmh3Vtf5OpOoR1RS4jNEmxPXs1CJ6D
	 YoGLSinh5eLcaq/sqChwMoDxfQOR8eSabnp0ICAA26y08yRXCL/rLsmZtXQFqYgrsdaOZ
	 fi/8oCdomHhcWZ/5AskQG+DfOsnHYp6sXANhjnJNth19t4n23XwT1m/Z39cTG2uUfhhpa
	 /WtmhQRK2AWQgg2bZbbrpfQ7FB4BQ8NQnZqPNzxUxNRNiuOniiuyD8REKgzZkKqYiGfps
	 9+pgnfSAi5e5WoteBTdXuH9mCruwUJ8ZLStmm/PTpR7h0UsZmRQXu7Nf9IgIt3EtI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=/qDRdTJ5Uc2UC94ZdsFp7Qe0gtbfHMFd/87pZqBjYLA=;
	b=HulCJwM7zTVmWRumUAiYuSwvVfwCr1s6taAHsTUh9Ft4vCgP1xh4n3g8w/uoI2Axqrq3
	 Cyv7StZvaLqaMAWnwyfEhPpGY9qVxM7b+EK4VIA6nmlBEyClNm3DMv40IJkyRmJtXbreJ
	 aGtWl2RteRCAgvFyVZzIqAVAFk+uql5ATkuaNIztiitwnPmTXlmezG9Tv5/8bY8hXDwwh
	 y+a++4hbwKJL9hMK1DRXjZ6r5bOwVVSJAb0KzLKOqb+ihIUedQd/BToqdNfbQkS89pVe9
	 C+MKZ5JIbiJQW/oT0d9pt7TAvcFfDG5M60sWsFQr304TvK7kcZl5ojxyMZGBVHotlfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OM6tdnJX;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439F606A31E
	for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2026 10:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C439F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OM6tdnJX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793009982; x=1824545982;
  h=date:from:to:cc:subject:message-id;
  bh=3cU7D7jY1WuF6g8li+qrycFZ5sOmD/3onNzTpKDmVrU=;
  b=OM6tdnJX/03mTzodGyP08F2H6MgOXVYWOjEDBtpA/zuAxDN0anxhbO2L
   3QA4VgLozkDA3r6PvT68HS7KLNGr8FEFZ4G/FgyiCy5c/s8qiKfte1438
   1KsAzfdWFd+v0zS3W5bMRVHJlbkJ5+iPtjIoOWs3HM1j5bLQrLzer5vvt
   FGhUDklFufQCz1rwITKQwb0RLh2JoX1DftcAl9TlinyGbEwxqsLNdOOII
   csA/xmEyJ9oVp4RceELEwqaXyKaks3C2hqrYv8QBojo0Vg++xvVCFxdE9
   V/++lFDKVf64e4az5IpdMwJanxNPWzyWX1aSQDnSaKx1+SWcCZrD9S4el
   Q==;
X-CSE-ConnectionGUID: WTjukTekTNqjjgon1HPV6w==
X-CSE-MsgGUID: DfQ0BwPxQEeWP5nMwj0PiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1546897"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1546897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:19:41 -0700
X-CSE-ConnectionGUID: WPezzddnQtS8jT+Us0agEQ==
X-CSE-MsgGUID: O+BxRsXfSfKEd6zBa/9REg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4340369"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 26 Oct 2026 03:19:40 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLHnl-0000000044t-1mNm;
	Mon, 26 Oct 2026 10:19:37 +0000
Date: Mon, 26 Oct 2026 11:19:02 +0100
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 52/85] fs/ceph/blog_module.c:587:2-20:
 WARNING: NULL check before some freeing functions is not needed.
Message-ID: <202610261153.xfORoXWJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://github.com/ceph/ceph-client.git testing
head:   f1ccaa90962dcc44b51a0e5cdcf61c97d08be117
commit: 3a45ef8445dd40c8035c6b9de5c372bd5f2c957c [52/85] ceph: add Ceph BLOG scaffolding
config: i386-randconfig-2103-20261026 (https://download.01.org/0day-ci/archive/20261026/202610261153.xfORoXWJ-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610261153.xfORoXWJ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/ceph/blog_module.c:587:2-20: WARNING: NULL check before some freeing functions is not needed.

vim +587 fs/ceph/blog_module.c

2e06dd34dd089b Alex Markuze 2026-08-20  530  
2e06dd34dd089b Alex Markuze 2026-08-20  531  static void blog_module_free(struct blog_module_context *ctx)
2e06dd34dd089b Alex Markuze 2026-08-20  532  {
2e06dd34dd089b Alex Markuze 2026-08-20  533  	struct blog_logger *logger;
2e06dd34dd089b Alex Markuze 2026-08-20  534  	struct blog_tls_ctx *tls_ctx, *tmp;
2e06dd34dd089b Alex Markuze 2026-08-20  535  	LIST_HEAD(pending);
2e06dd34dd089b Alex Markuze 2026-08-20  536  	LIST_HEAD(reclaim);
2e06dd34dd089b Alex Markuze 2026-08-20  537  
2e06dd34dd089b Alex Markuze 2026-08-20  538  	if (!ctx || !ctx->initialized)
2e06dd34dd089b Alex Markuze 2026-08-20  539  		return;
2e06dd34dd089b Alex Markuze 2026-08-20  540  	logger = ctx->logger;
2e06dd34dd089b Alex Markuze 2026-08-20  541  	if (!logger)
2e06dd34dd089b Alex Markuze 2026-08-20  542  		return;
2e06dd34dd089b Alex Markuze 2026-08-20  543  
2e06dd34dd089b Alex Markuze 2026-08-20  544  	WRITE_ONCE(logger->task_gc_stopping, true);
2e06dd34dd089b Alex Markuze 2026-08-20  545  	cancel_delayed_work_sync(&logger->task_gc_work);
2e06dd34dd089b Alex Markuze 2026-08-20  546  	cancel_work_sync(&logger->reclaim_work);
2e06dd34dd089b Alex Markuze 2026-08-20  547  
2e06dd34dd089b Alex Markuze 2026-08-20  548  	rhashtable_free_and_destroy(&logger->task_map,
2e06dd34dd089b Alex Markuze 2026-08-20  549  				    blog_task_entry_free_cb, logger);
2e06dd34dd089b Alex Markuze 2026-08-20  550  
2e06dd34dd089b Alex Markuze 2026-08-20  551  	/* Detach retained log-batch contexts from the reader-visible list. */
2e06dd34dd089b Alex Markuze 2026-08-20  552  	spin_lock(&logger->lock);
2e06dd34dd089b Alex Markuze 2026-08-20  553  	list_for_each_entry_safe(tls_ctx, tmp, &logger->contexts, list)
2e06dd34dd089b Alex Markuze 2026-08-20  554  		list_move(&tls_ctx->list, &pending);
2e06dd34dd089b Alex Markuze 2026-08-20  555  	list_for_each_entry_safe(tls_ctx, tmp, &logger->reclaim_list, list)
2e06dd34dd089b Alex Markuze 2026-08-20  556  		list_move(&tls_ctx->list, &reclaim);
2e06dd34dd089b Alex Markuze 2026-08-20  557  	spin_unlock(&logger->lock);
2e06dd34dd089b Alex Markuze 2026-08-20  558  
2e06dd34dd089b Alex Markuze 2026-08-20  559  	/* Failed atomic puts were never owned by log_batch. */
2e06dd34dd089b Alex Markuze 2026-08-20  560  	list_for_each_entry_safe(tls_ctx, tmp, &reclaim, list) {
2e06dd34dd089b Alex Markuze 2026-08-20  561  		list_del_init(&tls_ctx->list);
2e06dd34dd089b Alex Markuze 2026-08-20  562  		kvfree_atomic(blog_ctx_container(tls_ctx));
2e06dd34dd089b Alex Markuze 2026-08-20  563  	}
2e06dd34dd089b Alex Markuze 2026-08-20  564  
2e06dd34dd089b Alex Markuze 2026-08-20  565  	list_for_each_entry_safe(tls_ctx, tmp, &pending, list) {
2e06dd34dd089b Alex Markuze 2026-08-20  566  		list_del_init(&tls_ctx->list);
2e06dd34dd089b Alex Markuze 2026-08-20  567  		if (!READ_ONCE(tls_ctx->task))
2e06dd34dd089b Alex Markuze 2026-08-20  568  			continue;
2e06dd34dd089b Alex Markuze 2026-08-20  569  		blog_module_clear_task(tls_ctx);
2e06dd34dd089b Alex Markuze 2026-08-20  570  		if (tls_ctx->release)
2e06dd34dd089b Alex Markuze 2026-08-20  571  			tls_ctx->release(tls_ctx);
2e06dd34dd089b Alex Markuze 2026-08-20  572  		else
2e06dd34dd089b Alex Markuze 2026-08-20  573  			blog_module_queue_to_log_batch(logger, tls_ctx);
2e06dd34dd089b Alex Markuze 2026-08-20  574  	}
2e06dd34dd089b Alex Markuze 2026-08-20  575  
2e06dd34dd089b Alex Markuze 2026-08-20  576  	/*
2e06dd34dd089b Alex Markuze 2026-08-20  577  	 * rhashtable callbacks and the drain above can put into log_batch
2e06dd34dd089b Alex Markuze 2026-08-20  578  	 * and, before task_gc_stopping, would re-queue reclaim_work.  Cancel
2e06dd34dd089b Alex Markuze 2026-08-20  579  	 * again so a late queue cannot run after we free logger.
2e06dd34dd089b Alex Markuze 2026-08-20  580  	 */
2e06dd34dd089b Alex Markuze 2026-08-20  581  	cancel_work_sync(&logger->reclaim_work);
2e06dd34dd089b Alex Markuze 2026-08-20  582  
2e06dd34dd089b Alex Markuze 2026-08-20  583  	blog_batch_cleanup(&logger->alloc_batch);
2e06dd34dd089b Alex Markuze 2026-08-20  584  	blog_batch_cleanup(&logger->log_batch);
2e06dd34dd089b Alex Markuze 2026-08-20  585  
2e06dd34dd089b Alex Markuze 2026-08-20  586  	if (logger->magazine_cache)
2e06dd34dd089b Alex Markuze 2026-08-20 @587  		kmem_cache_destroy(logger->magazine_cache);
2e06dd34dd089b Alex Markuze 2026-08-20  588  	kvfree(logger->source_hash);
2e06dd34dd089b Alex Markuze 2026-08-20  589  	kvfree(logger->source_map);
2e06dd34dd089b Alex Markuze 2026-08-20  590  
2e06dd34dd089b Alex Markuze 2026-08-20  591  	pr_debug("BLOG: module '%s' cleaned up\n", ctx->name);
2e06dd34dd089b Alex Markuze 2026-08-20  592  
2e06dd34dd089b Alex Markuze 2026-08-20  593  	kfree(logger);
2e06dd34dd089b Alex Markuze 2026-08-20  594  	ctx->logger = NULL;
2e06dd34dd089b Alex Markuze 2026-08-20  595  	ctx->initialized = false;
2e06dd34dd089b Alex Markuze 2026-08-20  596  	kfree(ctx);
2e06dd34dd089b Alex Markuze 2026-08-20  597  }
2e06dd34dd089b Alex Markuze 2026-08-20  598  

:::::: The code at line 587 was first introduced by commit
:::::: 2e06dd34dd089b39a9dc6e5fecbc347f9fd5eaa9 ceph: add BLOG per-module context management

:::::: TO: Alex Markuze <amarkuze@redhat.com>
:::::: CC: Alex Markuze <amarkuze@redhat.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
