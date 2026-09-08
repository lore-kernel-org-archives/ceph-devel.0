Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A8238159
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788844319; cv=none; b=OoDDjxqa0FeU3IUqQwyA2cOUO3MBTzgbBBo80IRYOCMeY9FRK5YXLnU3ZDObqRLi4dc5ROhvpekPDuPOQn2g8YjLI6ncfdxelrDmtcOZ7cMctZDCk1LC7IRfkQUxzbotlSdWRFPb/14OeSdRhjxgg15Jq0E2iAa/5Xyozv5rEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788844319; c=relaxed/simple;
	bh=mfZ+j3nggl1vGCZSTE1M7+L+Uq53kGFUr4cMpOy8idI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dMaRJyBOSTgsEGL+jWFWrYJ9kj4jWHCs+TlFZnrPQQxze3fZ2HVOUlrc4zVcD3XHG39zYEI9uY6jHk+DL6baEegSIIX7PrfXLPWxZUaNK9/JXvXJ+4zD/ABNRb8bEzWTrF1642XT1BIkYhpZTRoP+ZLQ8i3+95JHcguqrnzQGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/N2+uCZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/N2+uCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788844317; x=1820380317;
  h=date:from:to:cc:subject:message-id;
  bh=mfZ+j3nggl1vGCZSTE1M7+L+Uq53kGFUr4cMpOy8idI=;
  b=h/N2+uCZ7DkXYa4JwZvr6H4eOz4WVVMxlsu2w63FFj9BvUn6tDsfLVlE
   1ZZHAVG7Z8WLXVhPv8Ucwd8+QPeMqPFIPguexGYk9qZCf7w656mJ5qRXz
   ammk+KUxPKuOsy7J2zVj8qAvUv4yF1sCWbOzFzRU0ZyOW30wYhfbJ67+z
   ZYCNCp1ZrtrvWEvR7kM6q8bogscgNc3p6J7FZXO0czBpkU5uQ9Kd1VpM3
   ukP7mH+BiewkYW1rRRy6iZWmubWpUGFH8KwNFhbXyCm3mgScPzilzJZRI
   AciXAXKLfCAtOnA/5J9INtMM+bB3CoD/jDbUrubHYlJK8baueR0yXDPT9
   Q==;
X-CSE-ConnectionGUID: 2PtnmBGDSyScOrkaN8DY9A==
X-CSE-MsgGUID: Yv8+riRzR1Cz1vF/HD3nig==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91745573"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91745573"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 22:11:57 -0700
X-CSE-ConnectionGUID: oD8aCoy3Thm7lJMdIn/7tA==
X-CSE-MsgGUID: +Xhz3hNbTjK7wlZBlp8Bgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="269148909"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Sep 2026 22:11:54 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3o7c-000000001h3-29Ln;
	Tue, 08 Sep 2026 05:11:52 +0000
Date: Tue, 08 Sep 2026 13:11:19 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 27/33] fs/ceph/mds_client.c:528:17:
 sparse: sparse: non size-preserving pointer to integer cast
Message-ID: <202609081319.wC7kigIc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: 0ae2716890be9bd8ccad10859bdf92e67544faa4 [27/33] ceph: switch MDS request plumbing to struct ceph_journal_info
config: nios2-randconfig-r133-20260908 (https://download.01.org/0day-ci/archive/20260908/202609081319.wC7kigIc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609081319.wC7kigIc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609081319.wC7kigIc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/mds_client.c:528:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1008:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1008:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1008:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1008:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1174:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1317:9: sparse: sparse: non size-preserving pointer to integer cast
>> fs/ceph/mds_client.c:1317:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1342:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1342:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1457:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1457:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1457:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1478:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1478:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1478:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1498:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1498:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1498:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1515:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1515:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1515:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1555:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1555:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1555:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1555:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1555:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1808:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1965:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1996:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2033:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2033:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2033:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2058:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2141:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2168:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2173:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2189:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2189:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2227:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2227:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2244:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2244:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2323:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2392:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2392:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2392:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2392:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2440:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2440:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2540:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2557:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2623:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2643:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2772:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2772:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2772:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2996:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3095:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3095:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3095:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3176:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3176:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3176:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3180:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3180:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3180:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3192:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3614:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3614:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3614:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3683:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3789:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3789:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4066:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4100:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4106:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4120:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4120:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4168:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4173:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4217:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4234:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4347:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4398:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4404:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4424:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4619:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4656:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4656:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4656:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4656:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4739:17: sparse: sparse: non size-preserving pointer to integer cast

vim +528 fs/ceph/mds_client.c

   474	
   475	/*
   476	 * parse readdir results
   477	 */
   478	static int parse_reply_info_readdir(void **p, void *end,
   479					    struct ceph_mds_request *req,
   480					    u64 features,
   481					    struct ceph_mds_client *mdsc)
   482	{
   483		struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
   484		struct ceph_client *cl = req->r_mdsc->fsc->client;
   485		u32 num, i = 0;
   486		int err;
   487	
   488		err = parse_reply_info_dir(p, end, &info->dir_dir, features);
   489		if (err < 0)
   490			goto out_bad;
   491	
   492		ceph_decode_need(p, end, sizeof(num) + 2, bad);
   493		num = ceph_decode_32(p);
   494		{
   495			u16 flags = ceph_decode_16(p);
   496			info->dir_end = !!(flags & CEPH_READDIR_FRAG_END);
   497			info->dir_complete = !!(flags & CEPH_READDIR_FRAG_COMPLETE);
   498			info->hash_order = !!(flags & CEPH_READDIR_HASH_ORDER);
   499			info->offset_hash = !!(flags & CEPH_READDIR_OFFSET_HASH);
   500		}
   501		if (num == 0)
   502			goto done;
   503	
   504		BUG_ON(!info->dir_entries);
   505		if ((unsigned long)(info->dir_entries + num) >
   506		    (unsigned long)info->dir_entries + info->dir_buf_size) {
   507			pr_err_client(cl, "dir contents are larger than expected\n");
   508			WARN_ON(1);
   509			goto bad;
   510		}
   511	
   512		info->dir_nr = num;
   513		while (num) {
   514			struct inode *inode = d_inode(req->r_dentry);
   515			struct ceph_inode_info *ci = ceph_inode(inode);
   516			struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
   517			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
   518			struct ceph_fname fname;
   519			u32 altname_len, _name_len;
   520			u8 *altname, *_name;
   521			u8 *tname = NULL;
   522	
   523			/* dentry */
   524			ceph_decode_32_safe(p, end, _name_len, bad);
   525			ceph_decode_need(p, end, _name_len, bad);
   526			_name = *p;
   527			*p += _name_len;
 > 528			boutc_bounded(cl, "parsed dir dname '%.*s'\n",
   529				      (_name_len, BLOG_STR(_name, _name_len)),
   530				      (_name_len, (const char *)_name));
   531	
   532			if (info->hash_order)
   533				rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
   534							      _name, _name_len);
   535	
   536			/* dentry lease */
   537			err = parse_reply_info_lease(p, end, &rde->lease, features,
   538						     &altname_len, &altname);
   539			if (err)
   540				goto out_bad;
   541	
   542			/*
   543			 * Try to dencrypt the dentry names and update them
   544			 * in the ceph_mds_reply_dir_entry struct.
   545			 */
   546			fname.dir = inode;
   547			fname.name = _name;
   548			fname.name_len = _name_len;
   549			fname.ctext = altname;
   550			fname.ctext_len = altname_len;
   551			/*
   552			 * The _name_len maybe larger than altname_len, such as
   553			 * when the human readable name length is in range of
   554			 * (CEPH_NOHASH_NAME_MAX, CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE),
   555			 * then the copy in ceph_fname_to_usr will corrupt the
   556			 * data if there has no encryption key.
   557			 *
   558			 * Just set the no_copy flag and then if there has no
   559			 * encryption key the oname.name will be assigned to
   560			 * _name always.
   561			 */
   562			fname.no_copy = true;
   563			if (altname_len == 0) {
   564				/*
   565				 * Set tname to _name, and this will be used
   566				 * to do the base64_decode in-place. It's
   567				 * safe because the decoded string should
   568				 * always be shorter, which is 3/4 of origin
   569				 * string. If this message was allocated with
   570				 * vmalloc() (happens, but rarely), leave it
   571				 * NULL and let ceph_fname_to_usr() allocate
   572				 * suitable temporary working space instead.
   573				 */
   574				if (likely(!is_vmalloc_addr(_name)))
   575					tname = _name;
   576	
   577				/*
   578				 * Set oname to _name too, and this will be
   579				 * used to do the dencryption in-place.
   580				 */
   581				oname.name = _name;
   582				oname.len = _name_len;
   583			} else {
   584				/*
   585				 * This will do the decryption only in-place
   586				 * from altname cryptext directly.
   587				 */
   588				oname.name = altname;
   589				oname.len = altname_len;
   590			}
   591			rde->is_nokey = false;
   592			err = ceph_fname_to_usr(&fname, tname, &oname, &rde->is_nokey);
   593			if (err) {
   594				pr_err_client(cl, "unable to decode %.*s, got %d\n",
   595					      _name_len, _name, err);
   596				goto out_bad;
   597			}
   598			rde->name = oname.name;
   599			rde->name_len = oname.len;
   600	
   601			/* inode */
   602			err = parse_reply_info_in(p, end, &rde->inode, features, mdsc);
   603			if (err < 0)
   604				goto out_bad;
   605			/* ceph_readdir_prepopulate() will update it */
   606			rde->offset = 0;
   607			i++;
   608			num--;
   609		}
   610	
   611	done:
   612		/* Skip over any unrecognized fields */
   613		*p = end;
   614		return 0;
   615	
   616	bad:
   617		err = -EIO;
   618	out_bad:
   619		pr_err_client(cl, "problem parsing dir contents %d\n", err);
   620		return err;
   621	}
   622	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
