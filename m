Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BA3783A1
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813948; cv=none; b=YGAjQFCp61sFr9Ad+SisAgqtT4TBpuM4yigARh5LDPUQkw+mE0RSxyVfvoUCfeQ5g/KE0Lg5GO2mt+KPRFp9+EGILNumQWimf8j8JBFTBBTaCD9/AHE+42If1lrJdHGNcitynzj12fDerulQ/bn/khHMn+KUKpZrx2Qpl4oQ+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813948; c=relaxed/simple;
	bh=6r5t89oAHiLnH/pKlgVxMP8kkOOZVfhkJsyWkpSwRJo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jddnl5MzKNP+wLNj1PeDT8/SSq6Dr7ol2Xl8VEsYBP7CAmkV4xDhYDQltn9I3OJTqrAZ3bTwbT6T0jBX3TDsaJsVNjLnnM7bzEd3uHzAWn4JpPYnDOJ00APaGOaA2vdZ5lmf1X8g4rEjr1AVxl6lEbAxYkiLCuL+Quh+aThB35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsBEQRWo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsBEQRWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788813944; x=1820349944;
  h=date:from:to:cc:subject:message-id;
  bh=6r5t89oAHiLnH/pKlgVxMP8kkOOZVfhkJsyWkpSwRJo=;
  b=jsBEQRWos4obs48Z/TX0/IicT7DZ/33lhQPOVVdo5UVEU6iJJvuhoI7h
   gomxIwIV1mmSlZGMWmnwHC+PJQ7fQC7uL/9qaUyNVoqcPy3VcTpg6ZvE7
   GSJkqsKOMJCG3BOBVqiyyZXUlzqMO7JUdxMSY335lFICnoxW6H6fzi7C8
   ShTkieUgkMQpAFydIsdaXCekumjTKqI/cLngmUFRP76F2QSD9WYNhxLZF
   dakMuIpvypgVZC9tR8nH61D4Po0UbBguuGZRFTPbRWp+DJURwkG6wQhqx
   eXhKgB6aG3248ZsSYjWcWMah733qR8ae1vVF5r9KkawKSgDxAFLozhCGG
   w==;
X-CSE-ConnectionGUID: P6WBsJ0+RJe5TEvKkETL+g==
X-CSE-MsgGUID: j9X9zpH4RDOVVxgFUTpuCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99873786"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99873786"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 13:45:41 -0700
X-CSE-ConnectionGUID: WdAjmXqYTL2KTtbvKhxTAw==
X-CSE-MsgGUID: Zur3z+c+Rp6JxVy33Imybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274311759"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 13:45:40 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3gDg-000000001Jl-3Ua7;
	Mon, 07 Sep 2026 20:45:36 +0000
Date: Tue, 08 Sep 2026 04:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:testing 30/33] fs/ceph/addr.c:951:1: warning:
 the frame size of 2096 bytes is larger than 1280 bytes
Message-ID: <202609080414.m3ZvUYmq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: 07d6f0588d3450da49fc8bb3e7007664981bf4ea [30/33] ceph: convert VFS data I/O paths to bout
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609080414.m3ZvUYmq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080414.m3ZvUYmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080414.m3ZvUYmq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ceph/addr.c: In function 'write_folio_nounlock.constprop':
>> fs/ceph/addr.c:951:1: warning: the frame size of 2096 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     951 | }
         | ^


vim +951 fs/ceph/addr.c

1f934b00e90752 Yan, Zheng              2017-08-30  781  
1d3576fd10f0d7 Sage Weil               2009-10-06  782  /*
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  783)  * Write a folio, but leave it locked.
1d3576fd10f0d7 Sage Weil               2009-10-06  784   *
b72b13eb203835 Jeff Layton             2019-07-02  785   * If we get a write error, mark the mapping for error, but still adjust the
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  786)  * dirty page accounting (i.e., folio is no longer dirty).
1d3576fd10f0d7 Sage Weil               2009-10-06  787   */
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  788) static int write_folio_nounlock(struct folio *folio,
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  789) 		struct writeback_control *wbc)
1d3576fd10f0d7 Sage Weil               2009-10-06  790  {
1cab548e67855c Tal Zussman             2026-09-02  791  	struct page *page;
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  792) 	struct inode *inode = folio->mapping->host;
6390987f2f4c5d Jeff Layton             2020-07-14  793  	struct ceph_inode_info *ci = ceph_inode(inode);
5995d90d2d19f3 Xiubo Li                2023-06-12  794  	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
38d46409c4639a Xiubo Li                2023-06-12  795  	struct ceph_client *cl = fsc->client;
6298a33757ba73 Sage Weil               2010-03-31  796  	struct ceph_snap_context *snapc, *oldest;
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  797) 	loff_t page_off = folio_pos(folio);
6390987f2f4c5d Jeff Layton             2020-07-14  798  	int err;
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  799) 	loff_t len = folio_size(folio);
d55207717ded95 Jeff Layton             2022-08-25  800  	loff_t wlen;
1f934b00e90752 Yan, Zheng              2017-08-30  801  	struct ceph_writeback_ctl ceph_wbc;
6390987f2f4c5d Jeff Layton             2020-07-14  802  	struct ceph_osd_client *osdc = &fsc->client->osdc;
6390987f2f4c5d Jeff Layton             2020-07-14  803  	struct ceph_osd_request *req;
1702e79734104d Jeff Layton             2021-12-07  804  	bool caching = ceph_is_cache_enabled(inode);
d55207717ded95 Jeff Layton             2022-08-25  805  	struct page *bounce_page = NULL;
1d3576fd10f0d7 Sage Weil               2009-10-06  806  
07d6f0588d3450 Alex Markuze            2026-08-20  807  	boutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  808) 	      folio->index);
1d3576fd10f0d7 Sage Weil               2009-10-06  809  
a68e564adcaa69 Xiubo Li                2023-02-01  810  	if (ceph_inode_is_shutdown(inode))
a68e564adcaa69 Xiubo Li                2023-02-01  811  		return -EIO;
a68e564adcaa69 Xiubo Li                2023-02-01  812  
1d3576fd10f0d7 Sage Weil               2009-10-06  813  	/* verify this is a writeable snap context */
42fe08b9e505c8 Tal Zussman             2026-09-02  814  	snapc = ceph_folio_snap_context(folio);
d37b1d9943d513 Markus Elfring          2017-08-20  815  	if (!snapc) {
07d6f0588d3450 Alex Markuze            2026-08-20  816  		boutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  817) 		      folio);
439868812aac01 Yan, Zheng              2017-05-23  818  		return 0;
1d3576fd10f0d7 Sage Weil               2009-10-06  819  	}
05455e1177f768 Yan, Zheng              2017-09-02  820  	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
6298a33757ba73 Sage Weil               2010-03-31  821  	if (snapc->seq > oldest->seq) {
07d6f0588d3450 Alex Markuze            2026-08-20  822  		boutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  823) 		      ceph_vinop(inode), folio, snapc);
1d3576fd10f0d7 Sage Weil               2009-10-06  824  		/* we should only noop if called by kswapd */
fa71fefb308532 Yan, Zheng              2017-05-23  825  		WARN_ON(!(current->flags & PF_MEMALLOC));
6298a33757ba73 Sage Weil               2010-03-31  826  		ceph_put_snap_context(oldest);
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  827) 		folio_redirty_for_writepage(wbc, folio);
439868812aac01 Yan, Zheng              2017-05-23  828  		return 0;
1d3576fd10f0d7 Sage Weil               2009-10-06  829  	}
6298a33757ba73 Sage Weil               2010-03-31  830  	ceph_put_snap_context(oldest);
1d3576fd10f0d7 Sage Weil               2009-10-06  831  
1d3576fd10f0d7 Sage Weil               2009-10-06  832  	/* is this a partial page at end of file? */
1f934b00e90752 Yan, Zheng              2017-08-30  833  	if (page_off >= ceph_wbc.i_size) {
07d6f0588d3450 Alex Markuze            2026-08-20  834  		boutc(cl, "%llx.%llx folio at %lu beyond eof %llu\n",
38d46409c4639a Xiubo Li                2023-06-12  835  		      ceph_vinop(inode), folio->index, ceph_wbc.i_size);
a628304ebe6ab0 Matthew Wilcox (Oracle  2022-02-09  836) 		folio_invalidate(folio, 0, folio_size(folio));
439868812aac01 Yan, Zheng              2017-05-23  837  		return 0;
fc2744aa12da71 Yan, Zheng              2013-05-31  838  	}
439868812aac01 Yan, Zheng              2017-05-23  839  
1f934b00e90752 Yan, Zheng              2017-08-30  840  	if (ceph_wbc.i_size < page_off + len)
1f934b00e90752 Yan, Zheng              2017-08-30  841  		len = ceph_wbc.i_size - page_off;
1d3576fd10f0d7 Sage Weil               2009-10-06  842  
d55207717ded95 Jeff Layton             2022-08-25  843  	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
07d6f0588d3450 Alex Markuze            2026-08-20  844  	boutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  845) 	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
38d46409c4639a Xiubo Li                2023-06-12  846  	      snapc->seq);
1d3576fd10f0d7 Sage Weil               2009-10-06  847  
fcf4b6daf7124c Tal Zussman             2026-09-02  848  	/* wait for a cache write left pending by a previously failed attempt */
fcf4b6daf7124c Tal Zussman             2026-09-02  849  	ceph_folio_wait_fscache(folio);
fcf4b6daf7124c Tal Zussman             2026-09-02  850  
314c4737a45dd4 Yan, Zheng              2017-12-15  851  	if (atomic_long_inc_return(&fsc->writeback_count) >
3d14c5d2b6e15c Yehuda Sadeh            2010-04-06  852  	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
503d4fa6ee28e8 NeilBrown               2022-03-22  853  		fsc->write_congested = true;
2baba25019ec56 Yehuda Sadeh            2009-12-18  854  
d55207717ded95 Jeff Layton             2022-08-25  855  	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode),
d55207717ded95 Jeff Layton             2022-08-25  856  				    page_off, &wlen, 0, 1, CEPH_OSD_OP_WRITE,
d55207717ded95 Jeff Layton             2022-08-25  857  				    CEPH_OSD_FLAG_WRITE, snapc,
d55207717ded95 Jeff Layton             2022-08-25  858  				    ceph_wbc.truncate_seq,
d55207717ded95 Jeff Layton             2022-08-25  859  				    ceph_wbc.truncate_size, true);
3459bd0c55ed28 Xiubo Li                2022-04-24  860  	if (IS_ERR(req)) {
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  861) 		folio_redirty_for_writepage(wbc, folio);
cbf59617cd7152 Wentao Liang            2026-06-04  862  		if (atomic_long_dec_return(&fsc->writeback_count) <
cbf59617cd7152 Wentao Liang            2026-06-04  863  				CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
cbf59617cd7152 Wentao Liang            2026-06-04  864  			fsc->write_congested = false;
6390987f2f4c5d Jeff Layton             2020-07-14  865  		return PTR_ERR(req);
3459bd0c55ed28 Xiubo Li                2022-04-24  866  	}
1702e79734104d Jeff Layton             2021-12-07  867  
d55207717ded95 Jeff Layton             2022-08-25  868  	if (wlen < len)
d55207717ded95 Jeff Layton             2022-08-25  869  		len = wlen;
d55207717ded95 Jeff Layton             2022-08-25  870  
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  871) 	folio_start_writeback(folio);
8e5ced7804cb91 David Howells           2024-07-30  872  	if (caching)
1cab548e67855c Tal Zussman             2026-09-02  873  		ceph_folio_start_fscache(folio);
1702e79734104d Jeff Layton             2021-12-07  874  	ceph_fscache_write_to_cache(inode, page_off, len, caching);
6390987f2f4c5d Jeff Layton             2020-07-14  875  
d55207717ded95 Jeff Layton             2022-08-25  876  	if (IS_ENCRYPTED(inode)) {
59b59a943177e1 Matthew Wilcox (Oracle  2025-03-04  877) 		bounce_page = fscrypt_encrypt_pagecache_blocks(folio,
d55207717ded95 Jeff Layton             2022-08-25  878  						    CEPH_FSCRYPT_BLOCK_SIZE, 0,
d55207717ded95 Jeff Layton             2022-08-25  879  						    GFP_NOFS);
d55207717ded95 Jeff Layton             2022-08-25  880  		if (IS_ERR(bounce_page)) {
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  881) 			folio_redirty_for_writepage(wbc, folio);
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  882) 			folio_end_writeback(folio);
d55207717ded95 Jeff Layton             2022-08-25  883  			ceph_osdc_put_request(req);
cbf59617cd7152 Wentao Liang            2026-06-04  884  			if (atomic_long_dec_return(&fsc->writeback_count) <
cbf59617cd7152 Wentao Liang            2026-06-04  885  					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
cbf59617cd7152 Wentao Liang            2026-06-04  886  				fsc->write_congested = false;
d55207717ded95 Jeff Layton             2022-08-25  887  			return PTR_ERR(bounce_page);
d55207717ded95 Jeff Layton             2022-08-25  888  		}
d55207717ded95 Jeff Layton             2022-08-25  889  	}
d55207717ded95 Jeff Layton             2022-08-25  890  
6390987f2f4c5d Jeff Layton             2020-07-14  891  	/* it may be a short write due to an object boundary */
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  892) 	WARN_ON_ONCE(len > folio_size(folio));
1cab548e67855c Tal Zussman             2026-09-02  893  	page = bounce_page ? bounce_page : &folio->page;
1cab548e67855c Tal Zussman             2026-09-02  894  	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
07d6f0588d3450 Alex Markuze            2026-08-20  895  	boutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
38d46409c4639a Xiubo Li                2023-06-12  896  	      ceph_vinop(inode), page_off, len, wlen,
38d46409c4639a Xiubo Li                2023-06-12  897  	      IS_ENCRYPTED(inode) ? "" : "not ");
6390987f2f4c5d Jeff Layton             2020-07-14  898  
c453bdb535341b Jeff Layton             2023-10-04  899  	req->r_mtime = inode_get_mtime(inode);
a8af0d682ae0c9 Jeff Layton             2022-06-30  900  	ceph_osdc_start_request(osdc, req);
6390987f2f4c5d Jeff Layton             2020-07-14  901  	err = ceph_osdc_wait_request(osdc, req);
6390987f2f4c5d Jeff Layton             2020-07-14  902  
8ae99ae2b40766 Xiubo Li                2021-03-22  903  	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
903f4fec78dd05 Xiubo Li                2021-05-13  904  				  req->r_end_latency, len, err);
b1137e0b3d4bad Alex Markuze            2026-02-10  905  	if (err >= 0 && len > 0)
b1137e0b3d4bad Alex Markuze            2026-02-10  906  		ceph_subvolume_metrics_record_io(fsc->mdsc, ci, true, len,
b1137e0b3d4bad Alex Markuze            2026-02-10  907  						 req->r_start_latency,
b1137e0b3d4bad Alex Markuze            2026-02-10  908  						 req->r_end_latency);
d55207717ded95 Jeff Layton             2022-08-25  909  	fscrypt_free_bounce_page(bounce_page);
6390987f2f4c5d Jeff Layton             2020-07-14  910  	ceph_osdc_put_request(req);
6390987f2f4c5d Jeff Layton             2020-07-14  911  	if (err == 0)
6390987f2f4c5d Jeff Layton             2020-07-14  912  		err = len;
6390987f2f4c5d Jeff Layton             2020-07-14  913  
1d3576fd10f0d7 Sage Weil               2009-10-06  914  	if (err < 0) {
ad15ec06e51b6e Yan, Zheng              2016-05-13  915  		struct writeback_control tmp_wbc;
ad15ec06e51b6e Yan, Zheng              2016-05-13  916  		if (!wbc)
ad15ec06e51b6e Yan, Zheng              2016-05-13  917  			wbc = &tmp_wbc;
ad15ec06e51b6e Yan, Zheng              2016-05-13  918  		if (err == -ERESTARTSYS) {
ad15ec06e51b6e Yan, Zheng              2016-05-13  919  			/* killed by SIGKILL */
07d6f0588d3450 Alex Markuze            2026-08-20  920  			boutc(cl, "%llx.%llx interrupted page %p\n",
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  921) 			      ceph_vinop(inode), folio);
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  922) 			folio_redirty_for_writepage(wbc, folio);
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  923) 			folio_end_writeback(folio);
cbf59617cd7152 Wentao Liang            2026-06-04  924  			if (atomic_long_dec_return(&fsc->writeback_count) <
cbf59617cd7152 Wentao Liang            2026-06-04  925  					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
cbf59617cd7152 Wentao Liang            2026-06-04  926  				fsc->write_congested = false;
439868812aac01 Yan, Zheng              2017-05-23  927  			return err;
ad15ec06e51b6e Yan, Zheng              2016-05-13  928  		}
0b98acd6188309 Ilya Dryomov            2020-09-14  929  		if (err == -EBLOCKLISTED)
0b98acd6188309 Ilya Dryomov            2020-09-14  930  			fsc->blocklisted = true;
07d6f0588d3450 Alex Markuze            2026-08-20  931  		boutc(cl, "%llx.%llx setting mapping error %d %p\n",
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  932) 		      ceph_vinop(inode), err, folio);
1d3576fd10f0d7 Sage Weil               2009-10-06  933  		mapping_set_error(&inode->i_data, err);
1d3576fd10f0d7 Sage Weil               2009-10-06  934  		wbc->pages_skipped++;
1d3576fd10f0d7 Sage Weil               2009-10-06  935  	} else {
07d6f0588d3450 Alex Markuze            2026-08-20  936  		boutc(cl, "%llx.%llx cleaned page %p\n",
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  937) 		      ceph_vinop(inode), folio);
1d3576fd10f0d7 Sage Weil               2009-10-06  938  		err = 0;  /* vfs expects us to return 0 */
1d3576fd10f0d7 Sage Weil               2009-10-06  939  	}
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  940) 	oldest = folio_detach_private(folio);
379fc7fad0ae6e Jeff Layton             2021-03-23  941  	WARN_ON_ONCE(oldest != snapc);
62171c16da6000 Matthew Wilcox (Oracle  2025-02-17  942) 	folio_end_writeback(folio);
1d3576fd10f0d7 Sage Weil               2009-10-06  943  	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
6298a33757ba73 Sage Weil               2010-03-31  944  	ceph_put_snap_context(snapc);  /* page's reference */
314c4737a45dd4 Yan, Zheng              2017-12-15  945  
314c4737a45dd4 Yan, Zheng              2017-12-15  946  	if (atomic_long_dec_return(&fsc->writeback_count) <
314c4737a45dd4 Yan, Zheng              2017-12-15  947  	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
503d4fa6ee28e8 NeilBrown               2022-03-22  948  		fsc->write_congested = false;
314c4737a45dd4 Yan, Zheng              2017-12-15  949  
1d3576fd10f0d7 Sage Weil               2009-10-06  950  	return err;
1d3576fd10f0d7 Sage Weil               2009-10-06 @951  }
1d3576fd10f0d7 Sage Weil               2009-10-06  952  

:::::: The code at line 951 was first introduced by commit
:::::: 1d3576fd10f0d7a104204267b81cf84a07028dad ceph: address space operations

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
