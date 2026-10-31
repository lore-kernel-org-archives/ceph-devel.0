Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793482451;
	b=lbI63alYD2Ejrh6itAKA53Et9Xr3yLo7oZnCh1h4TzXaithNwTPZXaMl2m7eZdg++YhT
	 7I3Qix8nDrKWSVgDpDC9liSXQ+s70Ts6s7qINOQEEI9ZG7JCxliWgsjw5vxu1ybxQ5O6v
	 9Qp9jmuG39T/iuotOTc1IntRlCtOnPOU1HQYL3CoY8jqjQt4cVNfB41cubSbk4yWoTCJW
	 smoyjb6ZWKRFjTotLatIXuREqqGGEeW8IVE/JiyNSEIhBI7u0nCrP6m5ka3hfR5zPv0zI
	 ROb4AirJV6JLGhJLC5t5ZHZm+s9/4P8/P7lKQsaIPLvb2Kn4X9UfR4Mq8aJ/PfmUtfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482451;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=mfMkFcLnCBTc4nnYFHIPIboi9JMXJtIML9MMaKc46YA=;
	b=adAfabVy5yYOovBw9iIzXXq+VTSXMdKB6beqKRuy0QIRLcKo2jPeo3JscsFYGEii7VHm
	 KclyesvawB9c7ReaZMJ7JiYfQMG6HD2fYFs5MkcUuRwIMu00MCnmxUEP/nJYCX1r2vRx+
	 P/pR6wGxH9YiqsNecCO8PnJGy2+s7d71+ZVmamamGwqTXyVglJRZAV8oFweWMn//7QwvN
	 +99NJF1haa5MmO+m7IgKk3VCq4E4S3Q5dk6vBb+5C6isuRQ+HCwUNpIEcgEJnIu91xk/h
	 H9g2FFPHDRzY3XODXRQHi7GbV8Zbhym3ZSgttPMZ20TzPyYDmWcWg/lKUVYjsjBi8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L9pkaqXf;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB70606A31C
	for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2026 21:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L9pkaqXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793482449; x=1825018449;
  h=date:from:to:cc:subject:message-id;
  bh=ICnvAL48R316+woWug2refJdHReHlhVNtZXiZqTtIGE=;
  b=L9pkaqXflAzAmP5wt8oTTVmj2dPLniewUq3qrEE1+h9aIpPIpAR9xTkv
   qsBx/ehuUn+Tv1WnvoXCTy79qUSp0GTw8EuYBnA8ky0qGDgbyj9tyOn3F
   ZKbnxvTkbhlBpuHOBWQd7lNmOzLM10C80hJiyzykE9Ja/pIagm8MgvQZx
   RyU25lmuXsLjMx+d0F7LD/SFLFOCAWPsexY9szLukzumrJ9rxtskkb2NH
   RBOF4oho/WlPRsM/QaG4fnCzzq1cKeGcptujOQhj3A0HF9jwW4Ak9boBC
   h0YkViwX/Clh4iI/BkJBBUJKC+w/oDSuD3JTQqLnd1HzFMTy7k9Lp/4pH
   w==;
X-CSE-ConnectionGUID: BHa8ZmRPQpqipmq4mKS0PA==
X-CSE-MsgGUID: 7N9kQvG+RKudmYSgYkRzeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2097136"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2097136"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 14:34:09 -0700
X-CSE-ConnectionGUID: I6Sem6FTSKKPx2KH656hXg==
X-CSE-MsgGUID: arnCkHLcSECvxlQK5BywDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="5853581"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 31 Oct 2026 14:34:06 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNGiB-0000000068F-1srC;
	Sat, 31 Oct 2026 21:34:03 +0000
Date: Sat, 31 Oct 2026 22:33:56 +0100
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 33/47] fs/ceph/addr.c:1808:17: sparse:
 sparse: cast from restricted xa_mark_t
Message-ID: <202610312225.fbDlNNNX-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

tree:   https://github.com/ceph/ceph-client.git testing
head:   3f007b9f327745c94aec312a28973b28f6a51fc4
commit: de9e07ca1957ab81442a4bbc85378199cd186c37 [33/47] ceph: convert VFS data I/O paths to BLOG logging
config: powerpc64-randconfig-r2306-20261031 (https://download.01.org/0day-ci/archive/20261031/202610312225.fbDlNNNX-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610312225.fbDlNNNX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610312225.fbDlNNNX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/addr.c:1808:17: sparse: sparse: cast from restricted xa_mark_t
>> fs/ceph/addr.c:1808:17: sparse: sparse: cast from restricted xa_mark_t
>> fs/ceph/addr.c:1808:17: sparse: sparse: cast from restricted xa_mark_t
>> fs/ceph/addr.c:1808:17: sparse: sparse: cast from restricted xa_mark_t
>> fs/ceph/addr.c:2214:17: sparse: sparse: cast from restricted vm_fault_t
>> fs/ceph/addr.c:2214:17: sparse: sparse: cast from restricted vm_fault_t
>> fs/ceph/addr.c:2214:17: sparse: sparse: cast from restricted vm_fault_t
>> fs/ceph/addr.c:2214:17: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2257:17: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2257:17: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2257:17: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2257:17: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2425:9: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2425:9: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2425:9: sparse: sparse: cast from restricted vm_fault_t
   fs/ceph/addr.c:2425:9: sparse: sparse: cast from restricted vm_fault_t
>> fs/ceph/addr.c:123:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/addr.c:123:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/addr.c:123:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/addr.c:123:9: sparse: sparse: non size-preserving integer to pointer cast
>> fs/ceph/addr.c:123:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:241:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:459:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:502:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:713:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:746:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:941:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:989:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1055:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1407:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1407:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1407:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1186:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1808:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1808:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1856:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:1885:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2043:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2043:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2043:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2214:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2257:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2425:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2638:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2704:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2835:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2835:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/addr.c:2841:17: sparse: sparse: non size-preserving integer to pointer cast
--
>> fs/ceph/file.c:3182:9: sparse: sparse: invalid initializer
>> fs/ceph/file.c:3182:9: sparse: sparse: invalid initializer
>> fs/ceph/file.c:72:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:211:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:279:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:284:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:350:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:397:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:397:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:465:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:489:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:506:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:762:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:825:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:825:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1041:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1310:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1366:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1410:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1410:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1583:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1596:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:1820:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2081:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2090:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2145:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2175:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2181:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2195:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2224:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2258:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2278:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2286:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2670:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2676:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:2885:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:3157:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:3280:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/file.c:3317:17: sparse: sparse: non size-preserving integer to pointer cast

vim +1808 fs/ceph/addr.c

  1745	
  1746	/*
  1747	 * initiate async writeback
  1748	 */
  1749	static int ceph_writepages_start(struct address_space *mapping,
  1750					 struct writeback_control *wbc)
  1751	{
  1752		struct inode *inode = mapping->host;
  1753		struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
  1754		struct ceph_client *cl = fsc->client;
  1755		struct ceph_writeback_ctl ceph_wbc;
  1756		int rc = 0;
  1757		struct ceph_journal_info __ji;
  1758	
  1759		ceph_blog_enter(fsc, &__ji);
  1760	
  1761		if (wbc->sync_mode == WB_SYNC_NONE && fsc->write_congested) {
  1762			ceph_blog_exit(&__ji);
  1763			return 0;
  1764		}
  1765	
  1766		boutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
  1767		      wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
  1768		      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
  1769	
  1770		if (is_forced_umount(mapping)) {
  1771			ceph_blog_exit(&__ji);
  1772			return -EIO;
  1773		}
  1774	
  1775		ceph_init_writeback_ctl(mapping, wbc, &ceph_wbc);
  1776	
  1777		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
  1778			rc = -EIO;
  1779			goto out;
  1780		}
  1781	
  1782	retry:
  1783		rc = ceph_define_writeback_range(mapping, wbc, &ceph_wbc);
  1784		if (rc == -ENODATA) {
  1785			/* hmm, why does writepages get called when there
  1786			   is no dirty data? */
  1787			rc = 0;
  1788			goto dec_osd_stopping_blocker;
  1789		}
  1790	
  1791		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
  1792			tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
  1793	
  1794		while (!has_writeback_done(&ceph_wbc)) {
  1795			BUG_ON(ceph_wbc.locked_pages);
  1796			BUG_ON(ceph_wbc.pages);
  1797	
  1798			ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
  1799	
  1800	get_more_pages:
  1801			ceph_folio_batch_reinit(&ceph_wbc);
  1802	
  1803			ceph_wbc.nr_folios = filemap_get_folios_tag(mapping,
  1804								    &ceph_wbc.index,
  1805								    ceph_wbc.end,
  1806								    ceph_wbc.tag,
  1807								    &ceph_wbc.fbatch);
> 1808			boutc(cl, "pagevec_lookup_range_tag for tag %#x got %d\n",
  1809				ceph_wbc.tag, ceph_wbc.nr_folios);
  1810	
  1811			if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
  1812				break;
  1813	
  1814	process_folio_batch:
  1815			ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
  1816			ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
  1817	
  1818			/* did we get anything? */
  1819			if (!ceph_wbc.locked_pages)
  1820				goto release_folios;
  1821	
  1822			if (ceph_wbc.processed_in_fbatch) {
  1823				if (folio_batch_count(&ceph_wbc.fbatch) == 0 &&
  1824				    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
  1825					boutc(cl, "reached end fbatch, trying for more\n");
  1826					goto get_more_pages;
  1827				}
  1828			}
  1829	
  1830			rc = ceph_submit_write(mapping, wbc, &ceph_wbc);
  1831			if (rc) {
  1832				/* the OSD client is being torn down, don't retry */
  1833				folio_batch_release(&ceph_wbc.fbatch);
  1834				goto dec_osd_stopping_blocker;
  1835			}
  1836	
  1837			ceph_wbc.locked_pages = 0;
  1838			ceph_wbc.strip_unit_end = 0;
  1839	
  1840			if (folio_batch_count(&ceph_wbc.fbatch) > 0) {
  1841				ceph_wbc.nr_folios =
  1842					folio_batch_count(&ceph_wbc.fbatch);
  1843				goto process_folio_batch;
  1844			}
  1845	
  1846			/*
  1847			 * We stop writing back only if we are not doing
  1848			 * integrity sync. In case of integrity sync we have to
  1849			 * keep going until we have written all the pages
  1850			 * we tagged for writeback prior to entering this loop.
  1851			 */
  1852			if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
  1853				ceph_wbc.done = true;
  1854	
  1855	release_folios:
  1856			boutc(cl, "folio_batch release on %d folios (%p)\n",
  1857			      (int)ceph_wbc.fbatch.nr,
  1858			      ceph_wbc.fbatch.nr ? ceph_wbc.fbatch.folios[0] : NULL);
  1859			folio_batch_release(&ceph_wbc.fbatch);
  1860		}
  1861	
  1862		if (ceph_wbc.should_loop && !ceph_wbc.done) {
  1863			/* more to do; loop back to beginning of file */
  1864			boutc(cl, "looping back to beginning of file\n");
  1865			/* OK even when start_index == 0 */
  1866			ceph_wbc.end = ceph_wbc.start_index - 1;
  1867	
  1868			/* to write dirty pages associated with next snapc,
  1869			 * we need to wait until current writes complete */
  1870			ceph_wait_until_current_writes_complete(mapping, wbc, &ceph_wbc);
  1871	
  1872			ceph_wbc.start_index = 0;
  1873			ceph_wbc.index = 0;
  1874			goto retry;
  1875		}
  1876	
  1877		if (wbc->range_cyclic || (ceph_wbc.range_whole && wbc->nr_to_write > 0))
  1878			mapping->writeback_index = ceph_wbc.index;
  1879	
  1880	dec_osd_stopping_blocker:
  1881		ceph_dec_osd_stopping_blocker(fsc->mdsc);
  1882	
  1883	out:
  1884		ceph_put_snap_context(ceph_wbc.last_snapc);
  1885		boutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
  1886		      rc);
  1887	
  1888		ceph_blog_exit(&__ji);
  1889		return rc;
  1890	}
  1891	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
