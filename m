Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474568;
	b=iizrblLquOOqz7ugnj9hKpeH9mjk467Q2NcAgL6IJA9t9fjwIM9muNf/pEbUKcJwfynW
	 qZxzcXlNyMAHSAo6UAPcK8dcIRKr2Fnl//ye8sg1raLDQ3Msq5QMG46r5W19mph1Y0dub
	 hVL0YtyaVRWL3lIf+UKLuQNuIoSCHuZMDxtrewed0TpPatUWOtMdiRmGIhDWVlfa4vaSd
	 PtsBl5ioqi1KMmwNQ8E0iEuXwL4Ql+s147ntNjN2goSrZ0KoY6pdQaB4uWnvR1TJyVROP
	 CMmR71/yfr5058CUTLer8NGLu1JHX1HSmrzTesgvFrDNapeWLSYXgefusjlzAa8SFMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474568;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=HbehQGZoQMdu9z/XJFvXYmaaZRFkQKNlVGfSZC5ynDY=;
	b=k2o0SlkP7kZFdCOGT5tgFu371b1uqP0RmKt5i/Tby5GWCHNWO4kwTywvLxwH47DRGbyO
	 OXyOUzm/dWEeLGZwJLdYQMZZsMYRsJcefDNCMrzMbbcaNEZDltKj3/K4zeaP+XXyGw2NZ
	 fijcbub2Cq0g82hfmB1EmLgFAx1zICZvnBQETBUqFa124e11gn/as0BHM5zVV9ARSiWcy
	 KgPCAksuIMnelV+uIrN3lJx2o1ux46nFDrviyxW5Wq7LP+C0x836IBJ7wrmTB6vcXipcW
	 Ck/bFGcqR111JClN12Blr3esDmbyTfIYClk4PJGNYIfA3aoMAdyjcrV6j7xDYp+wvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WsU86NC8;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6500606A31C
	for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2026 19:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6500606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WsU86NC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793474567; x=1825010567;
  h=date:from:to:cc:subject:message-id;
  bh=TqbB+001R3f/0R24Brk94L76VsJW/mLUSC9POxQgeoE=;
  b=WsU86NC8MGiydLK4r5JbzycnMaK4lE3u2TO2A7/CIgeywek44rjgKQ10
   YO0TBY9TKuHLMuHZZOhD4tEi6GWjk+VxWj4dEG7DCA87IVGcx4jQKyKpa
   DHV2WBRSVUT3LJ07DD2Re1SD1micg0NwMgFtIQ2KmMC4AyV9d5ZkO/2lF
   9fCX7KqKjZL+mACJdc9UYx4oaE7yJasLpR3XKJ3rMfrPlY7tnqWaUVnHU
   SOcsExe4F3KSumuZRCeexhR0AQYE2hfcW+wOcRmgXL8FkQafwIwGksiDe
   vFuwa275r6rU3Z6NDXuWPEHy7mIdkAVl9aY5T+6h9fkpRaU+2pTpGwRJq
   w==;
X-CSE-ConnectionGUID: n5u6fl7URLuIXk6dUr56dw==
X-CSE-MsgGUID: ArUy0uA8TIq5onxZ1n+YmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2123007"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2123007"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 12:22:46 -0700
X-CSE-ConnectionGUID: URb4NQ9WRdisgl3cOB81xQ==
X-CSE-MsgGUID: SRaY3CujTG+N38I87qw43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="5831979"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 31 Oct 2026 12:22:44 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNEf3-0000000065j-3hiC;
	Sat, 31 Oct 2026 19:22:41 +0000
Date: Sat, 31 Oct 2026 20:21:47 +0100
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 30/47] fs/ceph/mds_client.c:532:17:
 sparse: sparse: non size-preserving pointer to integer cast
Message-ID: <202610312050.1cgUWmGK-lkp@intel.com>
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
commit: 29beb7a6b57d1d73993611fd5baa817d3008fc7e [30/47] ceph: switch MDS request plumbing to struct ceph_journal_info
config: i386-randconfig-2301-20261031 (https://download.01.org/0day-ci/archive/20261031/202610312050.1cgUWmGK-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610312050.1cgUWmGK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610312050.1cgUWmGK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/mds_client.c:532:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:951:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:951:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:951:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:951:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1189:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1332:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1332:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1357:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1357:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1472:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1472:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1472:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1493:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1493:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1493:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1545:33: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1545:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1545:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1823:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:1982:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2013:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2050:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2050:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2050:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2075:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2158:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2185:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2190:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2206:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2206:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2244:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2244:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2261:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2261:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2340:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2409:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2409:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2409:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2409:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2457:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2457:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2557:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2574:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2640:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2660:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2789:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:2789:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2789:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3013:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3112:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3112:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3112:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3193:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3193:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3193:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3197:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3197:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3197:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3209:17: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3631:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3631:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3631:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3700:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3806:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:3806:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4091:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4125:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4131:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4145:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4145:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4193:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4198:9: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4242:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4259:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4372:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4423:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4429:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4449:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving pointer to integer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast

vim +532 fs/ceph/mds_client.c

   480	
   481	/*
   482	 * parse readdir results
   483	 */
   484	static int parse_reply_info_readdir(void **p, void *end,
   485					    struct ceph_mds_request *req,
   486					    u64 features,
   487					    struct ceph_mds_client *mdsc)
   488	{
   489		struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
   490		struct ceph_client *cl = req->r_mdsc->fsc->client;
   491		u32 num, i = 0;
   492		int err;
   493	
   494		err = parse_reply_info_dir(p, end, &info->dir_dir, features);
   495		if (err < 0)
   496			goto out_bad;
   497	
   498		ceph_decode_need(p, end, sizeof(num) + 2, bad);
   499		num = ceph_decode_32(p);
   500		{
   501			u16 flags = ceph_decode_16(p);
   502			info->dir_end = !!(flags & CEPH_READDIR_FRAG_END);
   503			info->dir_complete = !!(flags & CEPH_READDIR_FRAG_COMPLETE);
   504			info->hash_order = !!(flags & CEPH_READDIR_HASH_ORDER);
   505			info->offset_hash = !!(flags & CEPH_READDIR_OFFSET_HASH);
   506		}
   507		if (num == 0)
   508			goto done;
   509	
   510		BUG_ON(!info->dir_entries);
   511		if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
   512			pr_err_client(cl, "dir contents are larger than expected\n");
   513			goto bad;
   514		}
   515	
   516		info->dir_nr = num;
   517		while (num) {
   518			struct inode *inode = d_inode(req->r_dentry);
   519			struct ceph_inode_info *ci = ceph_inode(inode);
   520			struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
   521			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
   522			struct ceph_fname fname;
   523			u32 altname_len, _name_len;
   524			u8 *altname, *_name;
   525			u8 *tname = NULL;
   526	
   527			/* dentry */
   528			ceph_decode_32_safe(p, end, _name_len, bad);
   529			ceph_decode_need(p, end, _name_len, bad);
   530			_name = *p;
   531			*p += _name_len;
 > 532			boutc_bounded(cl, "parsed dir dname '%.*s'\n",
   533				      (_name_len, BLOG_STR(_name, _name_len)),
   534				      (_name_len, (const char *)_name));
   535	
   536			if (info->hash_order)
   537				rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
   538							      _name, _name_len);
   539	
   540			/* dentry lease */
   541			err = parse_reply_info_lease(p, end, &rde->lease, features,
   542						     &altname_len, &altname);
   543			if (err)
   544				goto out_bad;
   545	
   546			/*
   547			 * Try to dencrypt the dentry names and update them
   548			 * in the ceph_mds_reply_dir_entry struct.
   549			 */
   550			fname.dir = inode;
   551			fname.name = _name;
   552			fname.name_len = _name_len;
   553			fname.ctext = altname;
   554			fname.ctext_len = altname_len;
   555			/*
   556			 * The _name_len maybe larger than altname_len, such as
   557			 * when the human readable name length is in range of
   558			 * (CEPH_NOHASH_NAME_MAX, CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE),
   559			 * then the copy in ceph_fname_to_usr will corrupt the
   560			 * data if there has no encryption key.
   561			 *
   562			 * Just set the no_copy flag and then if there has no
   563			 * encryption key the oname.name will be assigned to
   564			 * _name always.
   565			 */
   566			fname.no_copy = true;
   567			if (altname_len == 0) {
   568				/*
   569				 * Set tname to _name, and this will be used
   570				 * to do the base64_decode in-place. It's
   571				 * safe because the decoded string should
   572				 * always be shorter, which is 3/4 of origin
   573				 * string. If this message was allocated with
   574				 * vmalloc() (happens, but rarely), leave it
   575				 * NULL and let ceph_fname_to_usr() allocate
   576				 * suitable temporary working space instead.
   577				 */
   578				if (likely(!is_vmalloc_addr(_name)))
   579					tname = _name;
   580	
   581				/*
   582				 * Set oname to _name too, and this will be
   583				 * used to do the dencryption in-place.
   584				 */
   585				oname.name = _name;
   586				oname.len = _name_len;
   587			} else {
   588				/*
   589				 * This will do the decryption only in-place
   590				 * from altname cryptext directly.
   591				 */
   592				oname.name = altname;
   593				oname.len = altname_len;
   594			}
   595			rde->is_nokey = false;
   596			err = ceph_fname_to_usr(&fname, tname, &oname, &rde->is_nokey);
   597			if (err) {
   598				pr_err_client(cl, "unable to decode %.*s, got %d\n",
   599					      _name_len, _name, err);
   600				goto out_bad;
   601			}
   602			rde->name = oname.name;
   603			rde->name_len = oname.len;
   604	
   605			/* inode */
   606			err = parse_reply_info_in(p, end, &rde->inode, features, mdsc);
   607			if (err < 0)
   608				goto out_bad;
   609			/* ceph_readdir_prepopulate() will update it */
   610			rde->offset = 0;
   611			i++;
   612			num--;
   613		}
   614	
   615	done:
   616		/* Skip over any unrecognized fields */
   617		*p = end;
   618		return 0;
   619	
   620	bad:
   621		err = -EIO;
   622	out_bad:
   623		pr_err_client(cl, "problem parsing dir contents %d\n", err);
   624		return err;
   625	}
   626	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
