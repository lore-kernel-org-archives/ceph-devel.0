Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF994028E2
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819111; cv=none; b=R5pBh8x4t8/STii/LGMv5ooFk/XbHdFfPF2KHmJNzVnCijLqg0m5oUUoDVX0xCGEWfguf9fMWy+WLw7uO5moWb42P3PImEf/SRf1QsHzwdzf10JkEWy3z2war/U0MyfmgNdVrNS/6IKwsloqm4xDnUGe+EpSIhTGdmVL5DNpB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819111; c=relaxed/simple;
	bh=qphU2xw0TLKiU9TEl86HPCJg6tabpCtMDxgHKZGA3k4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fMR1tI/HqNC7nJPK+MQVmUinmdZr1E+2VuGg/oDt39FoJOiyDUixL7oYWXc+VmNN0AQvv0g+jH+Mpg+hDI/xafMIgoPMbBQTVYGWlHqG7OMXMtMaviZL4brxM+xzwcTJmXWrUvxht8RRr3SiUE6JJREmZrWyTCaG2TIr9rOVSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSoxGduu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSoxGduu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788819105; x=1820355105;
  h=date:from:to:cc:subject:message-id;
  bh=qphU2xw0TLKiU9TEl86HPCJg6tabpCtMDxgHKZGA3k4=;
  b=VSoxGduuBRdXHWLJBUSEZloNl+ms6HZ+b01lgGb0xWzxvtkxGN3k1B9q
   7l6zJxWpJMfZ3nsZ6kieyqUBIunVz2dqqMAYNyPlWXOi9HRJ+M1pnEDbZ
   UXKdA0TgCzZKK/UYET6xBKNvEKE3dVZnMNaAf8TpsNR0pgp4Y//r52Bfu
   sgRKP6KyqSogxVaOTq7+eVEcrPnR4iMSI59Uc1EUPCtPe3qgL47ENJBZ/
   1aZtmVhfBqVuaVjEL4PYI7v9er/v568s0aLXrcFE/3VzQkjoF2rZUeEVm
   SDQ/FWSyEJ2jaSPTKw17leGRjYsj9bOPU5OiEw018Tc1FOfRX04Y4t1nd
   Q==;
X-CSE-ConnectionGUID: f33HRJrXT+6vKC6CnJ/94Q==
X-CSE-MsgGUID: zHCIlVehQdGbe+jnrgPZ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100738855"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100738855"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 15:11:43 -0700
X-CSE-ConnectionGUID: t2aNjV/FQqOp+szglchw2g==
X-CSE-MsgGUID: 4OC/5WoVQyC+4jb1zDNPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271332334"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Sep 2026 15:11:42 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3hYx-000000001N9-3PAi;
	Mon, 07 Sep 2026 22:11:39 +0000
Date: Tue, 08 Sep 2026 06:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:testing 31/33] fs/ceph/caps.c:3937:1: warning:
 the frame size of 1416 bytes is larger than 1280 bytes
Message-ID: <202609080633.gNTuHcMi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: a733c1207d9703e2170b6ce73f8af0a645208e8d [31/33] ceph: convert capability and snapshot paths to bout
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609080633.gNTuHcMi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080633.gNTuHcMi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080633.gNTuHcMi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ceph/caps.c: In function 'handle_cap_grant':
>> fs/ceph/caps.c:3937:1: warning: the frame size of 1416 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    3937 | }
         | ^


vim +3937 fs/ceph/caps.c

22754c2b594299 Xiubo Li          2026-08-25  3593  
a8599bd821d084 Sage Weil         2009-10-06  3594  /*
a8599bd821d084 Sage Weil         2009-10-06  3595   * Handle a cap GRANT message from the MDS.  (Note that a GRANT may
a8599bd821d084 Sage Weil         2009-10-06  3596   * actually be a revocation if it specifies a smaller cap set.)
a8599bd821d084 Sage Weil         2009-10-06  3597   *
be655596b3de58 Sage Weil         2011-11-30  3598   * caller holds s_mutex and i_ceph_lock, we drop both.
a8599bd821d084 Sage Weil         2009-10-06  3599   */
a1c6b8358171c1 Yan, Zheng        2018-04-27  3600  static void handle_cap_grant(struct inode *inode,
a8599bd821d084 Sage Weil         2009-10-06  3601  			     struct ceph_mds_session *session,
a1c6b8358171c1 Yan, Zheng        2018-04-27  3602  			     struct ceph_cap *cap,
a1c6b8358171c1 Yan, Zheng        2018-04-27  3603  			     struct ceph_mds_caps *grant,
a1c6b8358171c1 Yan, Zheng        2018-04-27  3604  			     struct ceph_buffer *xattr_buf,
a1c6b8358171c1 Yan, Zheng        2018-04-27  3605  			     struct cap_extra_info *extra_info)
be655596b3de58 Sage Weil         2011-11-30  3606  	__releases(ci->i_ceph_lock)
a1c6b8358171c1 Yan, Zheng        2018-04-27  3607  	__releases(session->s_mdsc->snap_rwsem)
a8599bd821d084 Sage Weil         2009-10-06  3608  {
38d46409c4639a Xiubo Li          2023-06-12  3609  	struct ceph_client *cl = ceph_inode_to_client(inode);
a8599bd821d084 Sage Weil         2009-10-06  3610  	struct ceph_inode_info *ci = ceph_inode(inode);
2f56f56ad991ed Sage Weil         2010-10-27  3611  	int seq = le32_to_cpu(grant->seq);
a8599bd821d084 Sage Weil         2009-10-06  3612  	int newcaps = le32_to_cpu(grant->caps);
2cd698be9a3d3a Yan, Zheng        2014-04-18  3613  	int used, wanted, dirty;
a8599bd821d084 Sage Weil         2009-10-06  3614  	u64 size = le64_to_cpu(grant->size);
a8599bd821d084 Sage Weil         2009-10-06  3615  	u64 max_size = le64_to_cpu(grant->max_size);
fdac94fab7995e Yan, Zheng        2018-11-22  3616  	unsigned char check_caps = 0;
52d60f8e18b855 Jeff Layton       2021-06-04  3617  	bool was_stale = cap->cap_gen < atomic_read(&session->s_cap_gen);
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3618  	bool wake = false;
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3619  	bool writeback = false;
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3620  	bool queue_trunc = false;
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3621  	bool queue_invalidate = false;
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3622  	bool deleted_inode = false;
31c542a199d79f Yan, Zheng        2014-11-14  3623  	bool fill_inline = false;
31634d7597d8c5 Xiubo Li          2024-07-12  3624  	bool revoke_wait = false;
31634d7597d8c5 Xiubo Li          2024-07-12  3625  	int flags = 0;
a8599bd821d084 Sage Weil         2009-10-06  3626  
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3627  	/*
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3628  	 * If there is at least one crypto block then we'll trust
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3629  	 * fscrypt_file_size. If the real length of the file is 0, then
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3630  	 * ignore it (it has probably been truncated down to 0 by the MDS).
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3631  	 */
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3632  	if (IS_ENCRYPTED(inode) && size)
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3633  		size = extra_info->fscrypt_file_size;
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3634  
a733c1207d9703 Alex Markuze      2026-08-20  3635  	boutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
38d46409c4639a Xiubo Li          2023-06-12  3636  	      ceph_vinop(inode), cap, session->s_mds, seq,
38d46409c4639a Xiubo Li          2023-06-12  3637  	      ceph_cap_string(newcaps));
a733c1207d9703 Alex Markuze      2026-08-20  3638  	boutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
38d46409c4639a Xiubo Li          2023-06-12  3639  	      max_size, i_size_read(inode));
a8599bd821d084 Sage Weil         2009-10-06  3640  
11df2dfb610d68 Yan, Zheng        2013-11-24  3641  
a8599bd821d084 Sage Weil         2009-10-06  3642  	/*
a8599bd821d084 Sage Weil         2009-10-06  3643  	 * If CACHE is being revoked, and we have no dirty buffers,
a8599bd821d084 Sage Weil         2009-10-06  3644  	 * try to invalidate (once).  (If there are dirty buffers, we
a8599bd821d084 Sage Weil         2009-10-06  3645  	 * will invalidate _after_ writeback.)
a8599bd821d084 Sage Weil         2009-10-06  3646  	 */
525d15e8e5ad77 Yan, Zheng        2019-05-11  3647  	if (S_ISREG(inode->i_mode) && /* don't invalidate readdir cache */
fdd4e15838e59c Yan, Zheng        2015-06-16  3648  	    ((cap->issued & ~newcaps) & CEPH_CAP_FILE_CACHE) &&
3b454c4945c756 Sage Weil         2010-06-10  3649  	    (newcaps & CEPH_CAP_FILE_LAZYIO) == 0 &&
9abd4db713704a Yan, Zheng        2016-05-18  3650  	    !(ci->i_wrbuffer_ref || ci->i_wb_ref)) {
e90757432361bb Li Wang           2013-08-15  3651  		if (try_nonblocking_invalidate(inode)) {
a8599bd821d084 Sage Weil         2009-10-06  3652  			/* there were locked pages.. invalidate later
a8599bd821d084 Sage Weil         2009-10-06  3653  			   in a separate thread. */
a8599bd821d084 Sage Weil         2009-10-06  3654  			if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3655  				queue_invalidate = true;
a8599bd821d084 Sage Weil         2009-10-06  3656  				ci->i_rdcache_revoking = ci->i_rdcache_gen;
a8599bd821d084 Sage Weil         2009-10-06  3657  			}
a8599bd821d084 Sage Weil         2009-10-06  3658  		}
a8599bd821d084 Sage Weil         2009-10-06  3659  	}
a8599bd821d084 Sage Weil         2009-10-06  3660  
d2f8bb27c87945 Yan, Zheng        2018-12-10  3661  	if (was_stale)
d2f8bb27c87945 Yan, Zheng        2018-12-10  3662  		cap->issued = cap->implemented = CEPH_CAP_PIN;
d2f8bb27c87945 Yan, Zheng        2018-12-10  3663  
d2f8bb27c87945 Yan, Zheng        2018-12-10  3664  	/*
d2f8bb27c87945 Yan, Zheng        2018-12-10  3665  	 * auth mds of the inode changed. we received the cap export message,
d2f8bb27c87945 Yan, Zheng        2018-12-10  3666  	 * but still haven't received the cap import message. handle_cap_export
d2f8bb27c87945 Yan, Zheng        2018-12-10  3667  	 * updated the new auth MDS' cap.
d2f8bb27c87945 Yan, Zheng        2018-12-10  3668  	 *
d2f8bb27c87945 Yan, Zheng        2018-12-10  3669  	 * "ceph_seq_cmp(seq, cap->seq) <= 0" means we are processing a message
d2f8bb27c87945 Yan, Zheng        2018-12-10  3670  	 * that was sent before the cap import message. So don't remove caps.
d2f8bb27c87945 Yan, Zheng        2018-12-10  3671  	 */
d2f8bb27c87945 Yan, Zheng        2018-12-10  3672  	if (ceph_seq_cmp(seq, cap->seq) <= 0) {
d2f8bb27c87945 Yan, Zheng        2018-12-10  3673  		WARN_ON(cap != ci->i_auth_cap);
d2f8bb27c87945 Yan, Zheng        2018-12-10  3674  		WARN_ON(cap->cap_id != le64_to_cpu(grant->cap_id));
d2f8bb27c87945 Yan, Zheng        2018-12-10  3675  		seq = cap->seq;
d2f8bb27c87945 Yan, Zheng        2018-12-10  3676  		newcaps |= cap->issued;
d2f8bb27c87945 Yan, Zheng        2018-12-10  3677  	}
d2f8bb27c87945 Yan, Zheng        2018-12-10  3678  
a8599bd821d084 Sage Weil         2009-10-06  3679  	/* side effects now are allowed */
52d60f8e18b855 Jeff Layton       2021-06-04  3680  	cap->cap_gen = atomic_read(&session->s_cap_gen);
11df2dfb610d68 Yan, Zheng        2013-11-24  3681  	cap->seq = seq;
a8599bd821d084 Sage Weil         2009-10-06  3682  
a8599bd821d084 Sage Weil         2009-10-06  3683  	__check_cap_issue(ci, cap, newcaps);
a8599bd821d084 Sage Weil         2009-10-06  3684  
176c77c9c9b1f8 Jeff Layton       2019-06-06  3685  	inode_set_max_iversion_raw(inode, extra_info->change_attr);
176c77c9c9b1f8 Jeff Layton       2019-06-06  3686  
f98a128a55ff85 Yan, Zheng        2014-04-17  3687  	if ((newcaps & CEPH_CAP_AUTH_SHARED) &&
a1c6b8358171c1 Yan, Zheng        2018-04-27  3688  	    (extra_info->issued & CEPH_CAP_AUTH_EXCL) == 0) {
ed94f87c2b1232 Jeff Layton       2021-02-25  3689  		umode_t mode = le32_to_cpu(grant->mode);
ed94f87c2b1232 Jeff Layton       2021-02-25  3690  
ed94f87c2b1232 Jeff Layton       2021-02-25  3691  		if (inode_wrong_type(inode, mode))
ed94f87c2b1232 Jeff Layton       2021-02-25  3692  			pr_warn_once("inode type changed! (ino %llx.%llx is 0%o, mds says 0%o)\n",
ed94f87c2b1232 Jeff Layton       2021-02-25  3693  				     ceph_vinop(inode), inode->i_mode, mode);
ed94f87c2b1232 Jeff Layton       2021-02-25  3694  		else
ed94f87c2b1232 Jeff Layton       2021-02-25  3695  			inode->i_mode = mode;
05cb11c17e892f Eric W. Biederman 2013-01-31  3696  		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
05cb11c17e892f Eric W. Biederman 2013-01-31  3697  		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
ec62b894df1ae6 Jeff Layton       2019-05-29  3698  		ci->i_btime = extra_info->btime;
a733c1207d9703 Alex Markuze      2026-08-20  3699  		boutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
38d46409c4639a Xiubo Li          2023-06-12  3700  		      ceph_vinop(inode), inode->i_mode,
bd2bae6a66df92 Eric W. Biederman 2013-01-31  3701  		      from_kuid(&init_user_ns, inode->i_uid),
bd2bae6a66df92 Eric W. Biederman 2013-01-31  3702  		      from_kgid(&init_user_ns, inode->i_gid));
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3703  #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3704  		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3705  		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3706  			   ci->fscrypt_auth_len))
38d46409c4639a Xiubo Li          2023-06-12  3707  			pr_warn_ratelimited_client(cl,
38d46409c4639a Xiubo Li          2023-06-12  3708  				"cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
38d46409c4639a Xiubo Li          2023-06-12  3709  				ci->fscrypt_auth_len,
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3710  				extra_info->fscrypt_auth_len);
0d91f0ad6a01c8 Jeff Layton       2022-08-25  3711  #endif
a8599bd821d084 Sage Weil         2009-10-06  3712  	}
a8599bd821d084 Sage Weil         2009-10-06  3713  
fa466743a9fc6e Yan, Zheng        2018-05-25  3714  	if ((newcaps & CEPH_CAP_LINK_SHARED) &&
a1c6b8358171c1 Yan, Zheng        2018-04-27  3715  	    (extra_info->issued & CEPH_CAP_LINK_EXCL) == 0) {
bfe8684869601d Miklos Szeredi    2011-10-28  3716  		set_nlink(inode, le32_to_cpu(grant->nlink));
76bdbc7ac777ad Xiubo Li          2022-01-06  3717  		if (inode->i_nlink == 0)
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3718  			deleted_inode = true;
ca20c991917ef6 Yan, Zheng        2013-07-21  3719  	}
a8599bd821d084 Sage Weil         2009-10-06  3720  
a1c6b8358171c1 Yan, Zheng        2018-04-27  3721  	if ((extra_info->issued & CEPH_CAP_XATTR_EXCL) == 0 &&
a1c6b8358171c1 Yan, Zheng        2018-04-27  3722  	    grant->xattr_len) {
a8599bd821d084 Sage Weil         2009-10-06  3723  		int len = le32_to_cpu(grant->xattr_len);
a8599bd821d084 Sage Weil         2009-10-06  3724  		u64 version = le64_to_cpu(grant->xattr_version);
a8599bd821d084 Sage Weil         2009-10-06  3725  
a8599bd821d084 Sage Weil         2009-10-06  3726  		if (version > ci->i_xattrs.version) {
a733c1207d9703 Alex Markuze      2026-08-20  3727  			boutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
38d46409c4639a Xiubo Li          2023-06-12  3728  			      version, inode, ceph_vinop(inode), len);
a8599bd821d084 Sage Weil         2009-10-06  3729  			if (ci->i_xattrs.blob)
a8599bd821d084 Sage Weil         2009-10-06  3730  				ceph_buffer_put(ci->i_xattrs.blob);
a8599bd821d084 Sage Weil         2009-10-06  3731  			ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
a8599bd821d084 Sage Weil         2009-10-06  3732  			ci->i_xattrs.version = version;
7221fe4c2ed728 Guangliang Zhao   2013-11-11  3733  			ceph_forget_all_cached_acls(inode);
ac6713ccb5a6d1 Yan, Zheng        2019-05-26  3734  			ceph_security_invalidate_secctx(inode);
a8599bd821d084 Sage Weil         2009-10-06  3735  		}
a8599bd821d084 Sage Weil         2009-10-06  3736  	}
a8599bd821d084 Sage Weil         2009-10-06  3737  
f98a128a55ff85 Yan, Zheng        2014-04-17  3738  	if (newcaps & CEPH_CAP_ANY_RD) {
9bbeab41ce5054 Arnd Bergmann     2018-07-13  3739  		struct timespec64 mtime, atime, ctime;
f98a128a55ff85 Yan, Zheng        2014-04-17  3740  		/* ctime/mtime/atime? */
9bbeab41ce5054 Arnd Bergmann     2018-07-13  3741  		ceph_decode_timespec64(&mtime, &grant->mtime);
9bbeab41ce5054 Arnd Bergmann     2018-07-13  3742  		ceph_decode_timespec64(&atime, &grant->atime);
9bbeab41ce5054 Arnd Bergmann     2018-07-13  3743  		ceph_decode_timespec64(&ctime, &grant->ctime);
a1c6b8358171c1 Yan, Zheng        2018-04-27  3744  		ceph_fill_file_time(inode, extra_info->issued,
f98a128a55ff85 Yan, Zheng        2014-04-17  3745  				    le32_to_cpu(grant->time_warp_seq),
f98a128a55ff85 Yan, Zheng        2014-04-17  3746  				    &ctime, &mtime, &atime);
f98a128a55ff85 Yan, Zheng        2014-04-17  3747  	}
11df2dfb610d68 Yan, Zheng        2013-11-24  3748  
4985d6f9e50fa4 Yan, Zheng        2018-04-27  3749  	if ((newcaps & CEPH_CAP_FILE_SHARED) && extra_info->dirstat_valid) {
4985d6f9e50fa4 Yan, Zheng        2018-04-27  3750  		ci->i_files = extra_info->nfiles;
4985d6f9e50fa4 Yan, Zheng        2018-04-27  3751  		ci->i_subdirs = extra_info->nsubdirs;
4985d6f9e50fa4 Yan, Zheng        2018-04-27  3752  	}
4985d6f9e50fa4 Yan, Zheng        2018-04-27  3753  
f98a128a55ff85 Yan, Zheng        2014-04-17  3754  	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
11df2dfb610d68 Yan, Zheng        2013-11-24  3755  		/* file layout may have changed */
7627151ea30bce Yan, Zheng        2016-02-03  3756  		s64 old_pool = ci->i_layout.pool_id;
779fe0fb8e1883 Yan, Zheng        2016-03-07  3757  		struct ceph_string *old_ns;
779fe0fb8e1883 Yan, Zheng        2016-03-07  3758  
7627151ea30bce Yan, Zheng        2016-02-03  3759  		ceph_file_layout_from_legacy(&ci->i_layout, &grant->layout);
779fe0fb8e1883 Yan, Zheng        2016-03-07  3760  		old_ns = rcu_dereference_protected(ci->i_layout.pool_ns,
779fe0fb8e1883 Yan, Zheng        2016-03-07  3761  					lockdep_is_held(&ci->i_ceph_lock));
a1c6b8358171c1 Yan, Zheng        2018-04-27  3762  		rcu_assign_pointer(ci->i_layout.pool_ns, extra_info->pool_ns);
779fe0fb8e1883 Yan, Zheng        2016-03-07  3763  
a1c6b8358171c1 Yan, Zheng        2018-04-27  3764  		if (ci->i_layout.pool_id != old_pool ||
a1c6b8358171c1 Yan, Zheng        2018-04-27  3765  		    extra_info->pool_ns != old_ns)
e120e2b666851c Alex Markuze      2026-05-07  3766  			clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
5ea5c5e0a7f70b Yan, Zheng        2016-02-14  3767  
a1c6b8358171c1 Yan, Zheng        2018-04-27  3768  		extra_info->pool_ns = old_ns;
779fe0fb8e1883 Yan, Zheng        2016-03-07  3769  
f98a128a55ff85 Yan, Zheng        2014-04-17  3770  		/* size/truncate_seq? */
a1c6b8358171c1 Yan, Zheng        2018-04-27  3771  		queue_trunc = ceph_fill_file_size(inode, extra_info->issued,
f98a128a55ff85 Yan, Zheng        2014-04-17  3772  					le32_to_cpu(grant->truncate_seq),
f98a128a55ff85 Yan, Zheng        2014-04-17  3773  					le64_to_cpu(grant->truncate_size),
f98a128a55ff85 Yan, Zheng        2014-04-17  3774  					size);
84eea8c79090c4 Yan, Zheng        2017-05-16  3775  	}
84eea8c79090c4 Yan, Zheng        2017-05-16  3776  
84eea8c79090c4 Yan, Zheng        2017-05-16  3777  	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
84eea8c79090c4 Yan, Zheng        2017-05-16  3778  		if (max_size != ci->i_max_size) {
a733c1207d9703 Alex Markuze      2026-08-20  3779  			boutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
38d46409c4639a Xiubo Li          2023-06-12  3780  			      max_size);
a8599bd821d084 Sage Weil         2009-10-06  3781  			ci->i_max_size = max_size;
a8599bd821d084 Sage Weil         2009-10-06  3782  			if (max_size >= ci->i_wanted_max_size) {
a8599bd821d084 Sage Weil         2009-10-06  3783  				ci->i_wanted_max_size = 0;  /* reset */
a8599bd821d084 Sage Weil         2009-10-06  3784  				ci->i_requested_max_size = 0;
a8599bd821d084 Sage Weil         2009-10-06  3785  			}
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3786  			wake = true;
a8599bd821d084 Sage Weil         2009-10-06  3787  		}
f98a128a55ff85 Yan, Zheng        2014-04-17  3788  	}
a8599bd821d084 Sage Weil         2009-10-06  3789  
a8599bd821d084 Sage Weil         2009-10-06  3790  	/* check cap bits */
a8599bd821d084 Sage Weil         2009-10-06  3791  	wanted = __ceph_caps_wanted(ci);
a8599bd821d084 Sage Weil         2009-10-06  3792  	used = __ceph_caps_used(ci);
a8599bd821d084 Sage Weil         2009-10-06  3793  	dirty = __ceph_caps_dirty(ci);
a733c1207d9703 Alex Markuze      2026-08-20  3794  	boutc(cl, " my wanted = %s, used = %s, dirty %s\n",
38d46409c4639a Xiubo Li          2023-06-12  3795  	      ceph_cap_string(wanted), ceph_cap_string(used),
a8599bd821d084 Sage Weil         2009-10-06  3796  	      ceph_cap_string(dirty));
fdac94fab7995e Yan, Zheng        2018-11-22  3797  
fdac94fab7995e Yan, Zheng        2018-11-22  3798  	if ((was_stale || le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) &&
fdac94fab7995e Yan, Zheng        2018-11-22  3799  	    (wanted & ~(cap->mds_wanted | newcaps))) {
fdac94fab7995e Yan, Zheng        2018-11-22  3800  		/*
fdac94fab7995e Yan, Zheng        2018-11-22  3801  		 * If mds is importing cap, prior cap messages that update
fdac94fab7995e Yan, Zheng        2018-11-22  3802  		 * 'wanted' may get dropped by mds (migrate seq mismatch).
fdac94fab7995e Yan, Zheng        2018-11-22  3803  		 *
fdac94fab7995e Yan, Zheng        2018-11-22  3804  		 * We don't send cap message to update 'wanted' if what we
fdac94fab7995e Yan, Zheng        2018-11-22  3805  		 * want are already issued. If mds revokes caps, cap message
fdac94fab7995e Yan, Zheng        2018-11-22  3806  		 * that releases caps also tells mds what we want. But if
fdac94fab7995e Yan, Zheng        2018-11-22  3807  		 * caps got revoked by mds forcedly (session stale). We may
fdac94fab7995e Yan, Zheng        2018-11-22  3808  		 * haven't told mds what we want.
fdac94fab7995e Yan, Zheng        2018-11-22  3809  		 */
390306c38dd439 Yan, Zheng        2013-01-04  3810  		check_caps = 1;
a8599bd821d084 Sage Weil         2009-10-06  3811  	}
a8599bd821d084 Sage Weil         2009-10-06  3812  
a8599bd821d084 Sage Weil         2009-10-06  3813  	/* revocation, grant, or no-op? */
a8599bd821d084 Sage Weil         2009-10-06  3814  	if (cap->issued & ~newcaps) {
3b454c4945c756 Sage Weil         2010-06-10  3815  		int revoking = cap->issued & ~newcaps;
3b454c4945c756 Sage Weil         2010-06-10  3816  
a733c1207d9703 Alex Markuze      2026-08-20  3817  		boutc(cl, "revocation: %s -> %s (revoking %s)\n",
38d46409c4639a Xiubo Li          2023-06-12  3818  		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
3b454c4945c756 Sage Weil         2010-06-10  3819  		      ceph_cap_string(revoking));
525d15e8e5ad77 Yan, Zheng        2019-05-11  3820  		if (S_ISREG(inode->i_mode) &&
31634d7597d8c5 Xiubo Li          2024-07-12  3821  		    (revoking & used & CEPH_CAP_FILE_BUFFER)) {
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3822  			writeback = true;  /* initiate writeback; will delay ack */
31634d7597d8c5 Xiubo Li          2024-07-12  3823  			revoke_wait = true;
31634d7597d8c5 Xiubo Li          2024-07-12  3824  		} else if (queue_invalidate &&
525d15e8e5ad77 Yan, Zheng        2019-05-11  3825  			 revoking == CEPH_CAP_FILE_CACHE &&
31634d7597d8c5 Xiubo Li          2024-07-12  3826  			 (newcaps & CEPH_CAP_FILE_LAZYIO) == 0) {
31634d7597d8c5 Xiubo Li          2024-07-12  3827  			revoke_wait = true; /* do nothing yet, invalidation will be queued */
31634d7597d8c5 Xiubo Li          2024-07-12  3828  		} else if (cap == ci->i_auth_cap) {
3b454c4945c756 Sage Weil         2010-06-10  3829  			check_caps = 1; /* check auth cap only */
31634d7597d8c5 Xiubo Li          2024-07-12  3830  		} else {
3b454c4945c756 Sage Weil         2010-06-10  3831  			check_caps = 2; /* check all caps */
31634d7597d8c5 Xiubo Li          2024-07-12  3832  		}
f791357330b004 Xiubo Li          2022-08-05  3833  		/* If there is new caps, try to wake up the waiters */
f791357330b004 Xiubo Li          2022-08-05  3834  		if (~cap->issued & newcaps)
f791357330b004 Xiubo Li          2022-08-05  3835  			wake = true;
a8599bd821d084 Sage Weil         2009-10-06  3836  		cap->issued = newcaps;
978097c907b58a Sage Weil         2010-03-08  3837  		cap->implemented |= newcaps;
a8599bd821d084 Sage Weil         2009-10-06  3838  	} else if (cap->issued == newcaps) {
a733c1207d9703 Alex Markuze      2026-08-20  3839  		boutc(cl, "caps unchanged: %s -> %s\n",
38d46409c4639a Xiubo Li          2023-06-12  3840  		      ceph_cap_string(cap->issued),
38d46409c4639a Xiubo Li          2023-06-12  3841  		      ceph_cap_string(newcaps));
a8599bd821d084 Sage Weil         2009-10-06  3842  	} else {
a733c1207d9703 Alex Markuze      2026-08-20  3843  		boutc(cl, "grant: %s -> %s\n", ceph_cap_string(cap->issued),
a8599bd821d084 Sage Weil         2009-10-06  3844  		      ceph_cap_string(newcaps));
6ee6b95373dfa1 Yan, Zheng        2013-07-02  3845  		/* non-auth MDS is revoking the newly grant caps ? */
6ee6b95373dfa1 Yan, Zheng        2013-07-02  3846  		if (cap == ci->i_auth_cap &&
6ee6b95373dfa1 Yan, Zheng        2013-07-02  3847  		    __ceph_caps_revoking_other(ci, cap, newcaps))
6ee6b95373dfa1 Yan, Zheng        2013-07-02  3848  		    check_caps = 2;
6ee6b95373dfa1 Yan, Zheng        2013-07-02  3849  
a8599bd821d084 Sage Weil         2009-10-06  3850  		cap->issued = newcaps;
a8599bd821d084 Sage Weil         2009-10-06  3851  		cap->implemented |= newcaps; /* add bits only, to
a8599bd821d084 Sage Weil         2009-10-06  3852  					      * avoid stepping on a
a8599bd821d084 Sage Weil         2009-10-06  3853  					      * pending revocation */
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3854  		wake = true;
a8599bd821d084 Sage Weil         2009-10-06  3855  	}
978097c907b58a Sage Weil         2010-03-08  3856  	BUG_ON(cap->issued & ~cap->implemented);
a8599bd821d084 Sage Weil         2009-10-06  3857  
257e6172ab36eb Xiubo Li          2023-06-28  3858  	/* don't let check_caps skip sending a response to MDS for revoke msgs */
8fdf946445732c Max Kellermann    2026-08-18  3859  	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
8fdf946445732c Max Kellermann    2026-08-18  3860  		if (revoke_wait) {
8fdf946445732c Max Kellermann    2026-08-18  3861  			/*
8fdf946445732c Max Kellermann    2026-08-18  3862  			 * We can't ack the revoke yet: the response is deferred
8fdf946445732c Max Kellermann    2026-08-18  3863  			 * until the writeback or cache invalidation queued above
8fdf946445732c Max Kellermann    2026-08-18  3864  			 * completes.  Set the CEPH_I_FLUSH_FORCE flag to remember
8fdf946445732c Max Kellermann    2026-08-18  3865  			 * that a forced cap message is owed so that deferred
8fdf946445732c Max Kellermann    2026-08-18  3866  			 * completion (ceph_put_wrbuffer_cap_refs() or the
8fdf946445732c Max Kellermann    2026-08-18  3867  			 * invalidate worker, both of which call ceph_check_caps())
8fdf946445732c Max Kellermann    2026-08-18  3868  			 * actually sends one, even if by then the revoked caps look
8fdf946445732c Max Kellermann    2026-08-18  3869  			 * unused, the inode is retaining caps, or the MDS has
8fdf946445732c Max Kellermann    2026-08-18  3870  			 * re-granted them.  Without this, the cap message is never
8fdf946445732c Max Kellermann    2026-08-18  3871  			 * sent and the MDS hangs ("isn't responding to
8fdf946445732c Max Kellermann    2026-08-18  3872  			 * mclientcaps(revoke)").
8fdf946445732c Max Kellermann    2026-08-18  3873  			 */
8fdf946445732c Max Kellermann    2026-08-18  3874  			set_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
8fdf946445732c Max Kellermann    2026-08-18  3875  		} else {
257e6172ab36eb Xiubo Li          2023-06-28  3876  			cap->mds_wanted = 0;
31634d7597d8c5 Xiubo Li          2024-07-12  3877  			flags |= CHECK_CAPS_FLUSH_FORCE;
257e6172ab36eb Xiubo Li          2023-06-28  3878  			if (cap == ci->i_auth_cap)
257e6172ab36eb Xiubo Li          2023-06-28  3879  				check_caps = 1; /* check auth cap only */
257e6172ab36eb Xiubo Li          2023-06-28  3880  			else
257e6172ab36eb Xiubo Li          2023-06-28  3881  				check_caps = 2; /* check all caps */
257e6172ab36eb Xiubo Li          2023-06-28  3882  		}
8fdf946445732c Max Kellermann    2026-08-18  3883  	}
257e6172ab36eb Xiubo Li          2023-06-28  3884  
a1c6b8358171c1 Yan, Zheng        2018-04-27  3885  	if (extra_info->inline_version > 0 &&
22754c2b594299 Xiubo Li          2026-08-25  3886  	    extra_info->inline_version >= ceph_inline_version(ci)) {
22754c2b594299 Xiubo Li          2026-08-25  3887  		ceph_set_inline_version(ci, extra_info->inline_version);
22754c2b594299 Xiubo Li          2026-08-25  3888  		if (extra_info->inline_version != CEPH_INLINE_NONE &&
31c542a199d79f Yan, Zheng        2014-11-14  3889  		    (newcaps & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
31c542a199d79f Yan, Zheng        2014-11-14  3890  			fill_inline = true;
31c542a199d79f Yan, Zheng        2014-11-14  3891  	}
31c542a199d79f Yan, Zheng        2014-11-14  3892  
58dd4385577ed7 Jeff Layton       2022-06-03  3893  	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
58dd4385577ed7 Jeff Layton       2022-06-03  3894  		if (ci->i_auth_cap == cap) {
a1c6b8358171c1 Yan, Zheng        2018-04-27  3895  			if (newcaps & ~extra_info->issued)
ab6c2c3ebe1d4f Fabian Frederick  2014-10-09  3896  				wake = true;
6f05b30ea063a2 Yan, Zheng        2020-03-30  3897  
6f05b30ea063a2 Yan, Zheng        2020-03-30  3898  			if (ci->i_requested_max_size > max_size ||
6f05b30ea063a2 Yan, Zheng        2020-03-30  3899  			    !(le32_to_cpu(grant->wanted) & CEPH_CAP_ANY_FILE_WR)) {
6f05b30ea063a2 Yan, Zheng        2020-03-30  3900  				/* re-request max_size if necessary */
6f05b30ea063a2 Yan, Zheng        2020-03-30  3901  				ci->i_requested_max_size = 0;
6f05b30ea063a2 Yan, Zheng        2020-03-30  3902  				wake = true;
6f05b30ea063a2 Yan, Zheng        2020-03-30  3903  			}
6f05b30ea063a2 Yan, Zheng        2020-03-30  3904  
e8a4d26771547c Jeff Layton       2020-02-25  3905  			ceph_kick_flushing_inode_caps(session, ci);
58dd4385577ed7 Jeff Layton       2022-06-03  3906  		}
a1c6b8358171c1 Yan, Zheng        2018-04-27  3907  		up_read(&session->s_mdsc->snap_rwsem);
2cd698be9a3d3a Yan, Zheng        2014-04-18  3908  	}
58dd4385577ed7 Jeff Layton       2022-06-03  3909  	spin_unlock(&ci->i_ceph_lock);
2cd698be9a3d3a Yan, Zheng        2014-04-18  3910  
31c542a199d79f Yan, Zheng        2014-11-14  3911  	if (fill_inline)
a1c6b8358171c1 Yan, Zheng        2018-04-27  3912  		ceph_fill_inline_data(inode, NULL, extra_info->inline_data,
a1c6b8358171c1 Yan, Zheng        2018-04-27  3913  				      extra_info->inline_len);
31c542a199d79f Yan, Zheng        2014-11-14  3914  
1464975816c79a Yan, Zheng        2016-05-20  3915  	if (queue_trunc)
c6bcda6f525129 Yan, Zheng        2014-04-11  3916  		ceph_queue_vmtruncate(inode);
c6bcda6f525129 Yan, Zheng        2014-04-11  3917  
3c6f6b79a64db7 Sage Weil         2010-02-09  3918  	if (writeback)
a8599bd821d084 Sage Weil         2009-10-06  3919  		/*
a8599bd821d084 Sage Weil         2009-10-06  3920  		 * queue inode for writeback: we can't actually call
a8599bd821d084 Sage Weil         2009-10-06  3921  		 * filemap_write_and_wait, etc. from message handler
a8599bd821d084 Sage Weil         2009-10-06  3922  		 * context.
a8599bd821d084 Sage Weil         2009-10-06  3923  		 */
3c6f6b79a64db7 Sage Weil         2010-02-09  3924  		ceph_queue_writeback(inode);
3c6f6b79a64db7 Sage Weil         2010-02-09  3925  	if (queue_invalidate)
3c6f6b79a64db7 Sage Weil         2010-02-09  3926  		ceph_queue_invalidate(inode);
ca20c991917ef6 Yan, Zheng        2013-07-21  3927  	if (deleted_inode)
ca20c991917ef6 Yan, Zheng        2013-07-21  3928  		invalidate_aliases(inode);
a8599bd821d084 Sage Weil         2009-10-06  3929  	if (wake)
03066f23452ff0 Yehuda Sadeh      2010-07-27  3930  		wake_up_all(&ci->i_cap_wq);
15637c8b1251c3 Sage Weil         2010-03-16  3931  
6a92b08fdad22a Jeff Layton       2021-06-04  3932  	mutex_unlock(&session->s_mutex);
15637c8b1251c3 Sage Weil         2010-03-16  3933  	if (check_caps == 1)
31634d7597d8c5 Xiubo Li          2024-07-12  3934  		ceph_check_caps(ci, flags | CHECK_CAPS_AUTHONLY | CHECK_CAPS_NOINVAL);
15637c8b1251c3 Sage Weil         2010-03-16  3935  	else if (check_caps == 2)
31634d7597d8c5 Xiubo Li          2024-07-12  3936  		ceph_check_caps(ci, flags | CHECK_CAPS_NOINVAL);
a8599bd821d084 Sage Weil         2009-10-06 @3937  }
a8599bd821d084 Sage Weil         2009-10-06  3938  

:::::: The code at line 3937 was first introduced by commit
:::::: a8599bd821d084d04a3290fffae1071624ec00ea ceph: capability management

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
