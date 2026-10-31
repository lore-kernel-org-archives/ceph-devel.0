Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467713;
	b=fIEfc/6idxkrqfnRWQrYFHkVOjsOA75M4b46ucGJ9B5jE5qLUMPNo7qiNf5/3g/2604i
	 SEj28te4poGnLfMRFTMrbLdw3VOlsl/uxithRPvV4iw5XGFs6i+PzuVFjjeLpKnPIhM0v
	 ROqghRFKBOBL/MpeVnRxGPJbJCYlZWJvgMQEnA0+f/9eT3fR+d4hAV4gxaI85m69AGHtV
	 GFVGPV59L+/uqOtDEi889Qhr4L0DUPFCa4gv//UaHgfXTBRjoS8yoW4Vv+BR9OW4OByUB
	 +DkZR8wsJb8gBH5nwGSCa6ckb3G8xA0NN6jAC1aqJl055epzBRoeXLAo6xezSz04a/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467713;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=XqBo2eq/og0Wm1CgiY+gzEJFqNOnGBH4IDZsk3Jnuxo=;
	b=FOM+7cqout4mXSOtzYMZI0d4sxQ/yHLmCFDpKk1vYEjVCwe/rj2oA7pUFQSToAcyCaco
	 WQGiyovT/cr0pajw07XkmmypENixv6/tSZVrI0NpQFt0/0/tk0fMFW8RYccDMq2gdbW/Z
	 jx9a6k22a9Dkw4/ug3a0MVWfL2MpIV7Cs3vTMRVQPa24sQmaNp+crCZbDO7re+fakwNFu
	 CbDUkmaOvc3grAiwCzeXaPJ+2hQSLlQEUZf3gJCEZ/RexN9g8gUg+ULe2NbW+7TLe04Jg
	 wMwoCvY6+OakE6I4M2PfaGUX6FIHP6cWjcAGJjr7uHoD9P+VaMGBsRWJ/ueSN1XLOMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZqizgmE;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6939606A31A
	for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2026 17:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6939606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZqizgmE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793467712; x=1825003712;
  h=date:from:to:cc:subject:message-id;
  bh=tPZyejknDUQkhTxVH/KWYp4VCGi/JS5/18MZ7Q97D8I=;
  b=ZZqizgmEO8olKsIcWrQTJFRuzLxqkhWTYPw8yg2E0Nwt7b2g+F002Yw1
   QSwFVJBRU2Td8eZ72pyy+NWvtmHWbIHyfLSwWXT7TE1RuuxqpwWmdUgdH
   KJS2FOm4qeRJq7HchMYvoIv/NBEnasQhZm2gS0AKnIBkfPvx/aDA16gBE
   j4ijNszOThWPRhWqmXQVIk34gt8q1B4HGJ1rei1V4GchvCr4bctMrUEwL
   xJ9bg/7PNaW7ROA3kCxiTvrx7fBzj/TbzpycKdkEwLrwi/Pxr41ipHkDs
   VacfJS6bwqsr99MuXEMmqdMRIzLmstOOKuOnO4nNv91BNYgX0OQ7bqZsm
   w==;
X-CSE-ConnectionGUID: B6ilRvfGQ7eLHXTax+xEAw==
X-CSE-MsgGUID: gqbgGq+zRzi7kg/MhJikvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2090415"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2090415"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 10:28:32 -0700
X-CSE-ConnectionGUID: 4BcSJeD1RvCJMSvr46NoQw==
X-CSE-MsgGUID: AdA2SceuRZeWD7Uns/Gitw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="6032442"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 31 Oct 2026 10:28:29 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNCsU-00000000647-4Bzu;
	Sat, 31 Oct 2026 17:28:27 +0000
Date: Sat, 31 Oct 2026 18:27:59 +0100
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
Subject: [ceph-client:testing 30/47] fs/ceph/mds_client.c:532:17:
 sparse: sparse: non size-preserving integer to pointer cast
Message-ID: <202610311803.q7TZGqgw-lkp@intel.com>
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
config: powerpc64-randconfig-r2306-20261031 (https://download.01.org/0day-ci/archive/20261031/202610311803.q7TZGqgw-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610311803.q7TZGqgw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610311803.q7TZGqgw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/mds_client.c:532:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:684:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1132:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1145:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1189:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1455:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1513:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1530:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1545:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1545:33: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1570:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1583:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1823:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1872:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1893:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1893:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1916:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1940:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:1982:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2158:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2185:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2190:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2206:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2244:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2261:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2409:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2430:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2430:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2430:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2430:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2436:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2436:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2436:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2436:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2640:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:2660:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3013:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3112:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3112:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3197:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3209:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3631:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3806:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3903:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3903:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3931:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:3972:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4031:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4076:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4091:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4131:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4242:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4259:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4423:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4449:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4569:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4644:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4681:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:4854:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:5971:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:5971:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:5987:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6108:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6128:25: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6167:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6185:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6274:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6361:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6585:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6728:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6728:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6728:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6756:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6765:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6765:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6769:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6769:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6769:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:6769:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:7093:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:7169:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:7169:9: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:7174:17: sparse: sparse: non size-preserving integer to pointer cast
   fs/ceph/mds_client.c:7174:17: sparse: sparse: non size-preserving integer to pointer cast

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
