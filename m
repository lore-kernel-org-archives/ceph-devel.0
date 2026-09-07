Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7F51FCB5
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806237; cv=none; b=hlcKUZYtxTjbgMOikBg2cMVp4cHgm2xfExpmkGo1Esa1ge22ZQyMsa5fDec06DK6J9sl16U1N7VcjhBuHf43Iwvi/cMso19EGMpsqhAytcMTtfNvfIbmfhhCJ0NPIIe4qqVLQS2x5GzoB3XQzHIWQNnqn7I7CjCa6DmUI1gWs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806237; c=relaxed/simple;
	bh=T5iZGM/GXc8KpfwM+O7haiguVQtnI/rKk43bXoo9kTA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ww7A4UhJDC504yK5epLRoyvvGtgz28HEZAjgzVTntNBDk4ejL1BiwknjN4zsDZEMX3LfuRPouP+mbriI/HCrn9ZwfWnBO6A+ajJuUZc6VUpnr+XNQQCN7Pewk/F7+h9+fDoDq7+GprvCAKOW1Xc9XEZ0/yQW9CVWn25tfZX+Vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTZdcoVJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTZdcoVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788806235; x=1820342235;
  h=date:from:to:cc:subject:message-id;
  bh=T5iZGM/GXc8KpfwM+O7haiguVQtnI/rKk43bXoo9kTA=;
  b=WTZdcoVJ0hWEi3SJjApy0UIudKESY2GPVF16ruPje9YkrjBHDb0MZQZZ
   x5Fgq76ygctno6ElGY9+dCUZkrzxBDGmOmratUHTHnrNi6GyjSs40U0VW
   RYS/s5fPvkzXy24/jyj3XItGAUtbYSIKUyEViHVA80WJoqvBZ6m3l8J4K
   sMaobzl3+nT3wg8tJKm6mEUzviasPPpUiheCb2FDYyZ4vsc1CCeaqc1rT
   4qQnUUydnovIpHN/XHv57XWpKfJ9U4sDpb1GJ7BdfpmuFod53jFvMFBEN
   If1+py1hqE4jPimtSoPy6Tm7s9eIUrkJPeJcd+JVyEPJjdO+0Mx0fkhHP
   A==;
X-CSE-ConnectionGUID: raAhgjglQXGnz+pgq08PZA==
X-CSE-MsgGUID: g8CmJOoMRd6bAsT3yFoO/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89243278"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89243278"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 11:37:15 -0700
X-CSE-ConnectionGUID: T84EJh2PQdOgInS9iQ2hVQ==
X-CSE-MsgGUID: C8UxqRI0Q1imfwdGY472eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="272715593"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Sep 2026 11:37:13 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3eDO-000000001EN-2HyH;
	Mon, 07 Sep 2026 18:37:10 +0000
Date: Tue, 08 Sep 2026 02:36:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:testing 29/33] fs/ceph/inode.c:1983:1: warning:
 the frame size of 1392 bytes is larger than 1280 bytes
Message-ID: <202609080252.V6W7YmNU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: 20d024e610cdb8123a26ed3e93c0e8a506933d52 [29/33] ceph: convert VFS inode and directory paths to bout
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609080252.V6W7YmNU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080252.V6W7YmNU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080252.V6W7YmNU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ceph/inode.c: In function 'ceph_fill_trace':
>> fs/ceph/inode.c:1983:1: warning: the frame size of 1392 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    1983 | }
         | ^
   fs/ceph/inode.c: In function '__ceph_setattr':
   fs/ceph/inode.c:3012:1: warning: the frame size of 1512 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    3012 | }
         | ^
--
   fs/ceph/dir.c: In function 'ceph_readdir':
>> fs/ceph/dir.c:680:1: warning: the frame size of 2216 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     680 | }
         | ^


vim +1983 fs/ceph/inode.c

355da1eb7a1f91c Sage Weil          2009-10-06  1657  
355da1eb7a1f91c Sage Weil          2009-10-06  1658  /*
355da1eb7a1f91c Sage Weil          2009-10-06  1659   * Incorporate results into the local cache.  This is either just
355da1eb7a1f91c Sage Weil          2009-10-06  1660   * one inode, or a directory, dentry, and possibly linked-to inode (e.g.,
355da1eb7a1f91c Sage Weil          2009-10-06  1661   * after a lookup).
355da1eb7a1f91c Sage Weil          2009-10-06  1662   *
355da1eb7a1f91c Sage Weil          2009-10-06  1663   * A reply may contain
355da1eb7a1f91c Sage Weil          2009-10-06  1664   *         a directory inode along with a dentry.
355da1eb7a1f91c Sage Weil          2009-10-06  1665   *  and/or a target inode
355da1eb7a1f91c Sage Weil          2009-10-06  1666   *
355da1eb7a1f91c Sage Weil          2009-10-06  1667   * Called with snap_rwsem (read).
355da1eb7a1f91c Sage Weil          2009-10-06  1668   */
f5a03b080450784 Jeff Layton        2017-01-31  1669  int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
355da1eb7a1f91c Sage Weil          2009-10-06  1670  {
f5a03b080450784 Jeff Layton        2017-01-31  1671  	struct ceph_mds_session *session = req->r_session;
355da1eb7a1f91c Sage Weil          2009-10-06  1672  	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
355da1eb7a1f91c Sage Weil          2009-10-06  1673  	struct inode *in = NULL;
f5d55f03973f79a Jeff Layton        2017-01-27  1674  	struct ceph_vino tvino, dvino;
5995d90d2d19f33 Xiubo Li           2023-06-12  1675  	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
38d46409c4639a1 Xiubo Li           2023-06-12  1676  	struct ceph_client *cl = fsc->client;
bec324f33d1ed34 Alex Markuze       2025-08-12  1677  	struct inode *parent_dir = NULL;
355da1eb7a1f91c Sage Weil          2009-10-06  1678  	int err = 0;
355da1eb7a1f91c Sage Weil          2009-10-06  1679  
20d024e610cdb81 Alex Markuze       2026-08-20  1680  	boutc(cl, "%p is_dentry %d is_target %d\n", req,
355da1eb7a1f91c Sage Weil          2009-10-06  1681  	      rinfo->head->is_dentry, rinfo->head->is_target);
355da1eb7a1f91c Sage Weil          2009-10-06  1682  
355da1eb7a1f91c Sage Weil          2009-10-06  1683  	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
20d024e610cdb81 Alex Markuze       2026-08-20  1684  		boutc(cl, "reply is empty!\n");
3dd69aabcef3d83 Jeff Layton        2017-01-31  1685  		if (rinfo->head->result == 0 && req->r_parent)
167c9e352deb7e2 Sage Weil          2010-05-14  1686  			ceph_invalidate_dir_request(req);
355da1eb7a1f91c Sage Weil          2009-10-06  1687  		return 0;
355da1eb7a1f91c Sage Weil          2009-10-06  1688  	}
355da1eb7a1f91c Sage Weil          2009-10-06  1689  
355da1eb7a1f91c Sage Weil          2009-10-06  1690  	if (rinfo->head->is_dentry) {
bec324f33d1ed34 Alex Markuze       2025-08-12  1691  		/*
bec324f33d1ed34 Alex Markuze       2025-08-12  1692  		 * r_parent may be stale, in cases when R_PARENT_LOCKED is not set,
bec324f33d1ed34 Alex Markuze       2025-08-12  1693  		 * so we need to get the correct inode
bec324f33d1ed34 Alex Markuze       2025-08-12  1694  		 */
bec324f33d1ed34 Alex Markuze       2025-08-12  1695  		parent_dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
bec324f33d1ed34 Alex Markuze       2025-08-12  1696  		if (unlikely(IS_ERR(parent_dir))) {
bec324f33d1ed34 Alex Markuze       2025-08-12  1697  			err = PTR_ERR(parent_dir);
bec324f33d1ed34 Alex Markuze       2025-08-12  1698  			goto done;
bec324f33d1ed34 Alex Markuze       2025-08-12  1699  		}
bec324f33d1ed34 Alex Markuze       2025-08-12  1700  		if (parent_dir) {
4a1c5434792df72 Alex Markuze       2026-02-10  1701  			ceph_inode_set_subvolume(parent_dir,
4a1c5434792df72 Alex Markuze       2026-02-10  1702  						 rinfo->diri.subvolume_id);
bec324f33d1ed34 Alex Markuze       2025-08-12  1703  			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
966c716018de1c0 Jeff Layton        2019-12-05  1704  					      rinfo->dirfrag, session, -1,
5b1daecd59f95eb Sage Weil          2010-01-25  1705  					      &req->r_caps_reservation);
5b1daecd59f95eb Sage Weil          2010-01-25  1706  			if (err < 0)
19913b4eac4a230 Yan, Zheng         2014-03-06  1707  				goto done;
6c5e50fa614fea5 Sage Weil          2012-08-21  1708  		} else {
6c5e50fa614fea5 Sage Weil          2012-08-21  1709  			WARN_ON_ONCE(1);
6c5e50fa614fea5 Sage Weil          2012-08-21  1710  		}
19913b4eac4a230 Yan, Zheng         2014-03-06  1711  
bec324f33d1ed34 Alex Markuze       2025-08-12  1712  		if (parent_dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
74c9e6bf4c888e4 Yan, Zheng         2018-09-28  1713  		    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
74c9e6bf4c888e4 Yan, Zheng         2018-09-28  1714  		    !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
855290962c55812 Jeff Layton        2020-08-10  1715  			bool is_nokey = false;
19913b4eac4a230 Yan, Zheng         2014-03-06  1716  			struct qstr dname;
19913b4eac4a230 Yan, Zheng         2014-03-06  1717  			struct dentry *dn, *parent;
855290962c55812 Jeff Layton        2020-08-10  1718  			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
bec324f33d1ed34 Alex Markuze       2025-08-12  1719  			struct ceph_fname fname = { .dir	= parent_dir,
855290962c55812 Jeff Layton        2020-08-10  1720  						    .name	= rinfo->dname,
855290962c55812 Jeff Layton        2020-08-10  1721  						    .ctext	= rinfo->altname,
855290962c55812 Jeff Layton        2020-08-10  1722  						    .name_len	= rinfo->dname_len,
855290962c55812 Jeff Layton        2020-08-10  1723  						    .ctext_len	= rinfo->altname_len };
19913b4eac4a230 Yan, Zheng         2014-03-06  1724  
19913b4eac4a230 Yan, Zheng         2014-03-06  1725  			BUG_ON(!rinfo->head->is_target);
19913b4eac4a230 Yan, Zheng         2014-03-06  1726  			BUG_ON(req->r_dentry);
19913b4eac4a230 Yan, Zheng         2014-03-06  1727  
bec324f33d1ed34 Alex Markuze       2025-08-12  1728  			parent = d_find_any_alias(parent_dir);
19913b4eac4a230 Yan, Zheng         2014-03-06  1729  			BUG_ON(!parent);
19913b4eac4a230 Yan, Zheng         2014-03-06  1730  
bec324f33d1ed34 Alex Markuze       2025-08-12  1731  			err = ceph_fname_alloc_buffer(parent_dir, &oname);
855290962c55812 Jeff Layton        2020-08-10  1732  			if (err < 0) {
855290962c55812 Jeff Layton        2020-08-10  1733  				dput(parent);
855290962c55812 Jeff Layton        2020-08-10  1734  				goto done;
855290962c55812 Jeff Layton        2020-08-10  1735  			}
855290962c55812 Jeff Layton        2020-08-10  1736  
855290962c55812 Jeff Layton        2020-08-10  1737  			err = ceph_fname_to_usr(&fname, NULL, &oname, &is_nokey);
855290962c55812 Jeff Layton        2020-08-10  1738  			if (err < 0) {
855290962c55812 Jeff Layton        2020-08-10  1739  				dput(parent);
bec324f33d1ed34 Alex Markuze       2025-08-12  1740  				ceph_fname_free_buffer(parent_dir, &oname);
855290962c55812 Jeff Layton        2020-08-10  1741  				goto done;
855290962c55812 Jeff Layton        2020-08-10  1742  			}
855290962c55812 Jeff Layton        2020-08-10  1743  			dname.name = oname.name;
855290962c55812 Jeff Layton        2020-08-10  1744  			dname.len = oname.len;
8387ff2577eb9ed Linus Torvalds     2016-06-10  1745  			dname.hash = full_name_hash(parent, dname.name, dname.len);
f5d55f03973f79a Jeff Layton        2017-01-27  1746  			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
f5d55f03973f79a Jeff Layton        2017-01-27  1747  			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
19913b4eac4a230 Yan, Zheng         2014-03-06  1748  retry_lookup:
19913b4eac4a230 Yan, Zheng         2014-03-06  1749  			dn = d_lookup(parent, &dname);
20d024e610cdb81 Alex Markuze       2026-08-20  1750  			boutc_bounded(cl,
20d024e610cdb81 Alex Markuze       2026-08-20  1751  				      "d_lookup on parent=%p name=%.*s got %p\n",
20d024e610cdb81 Alex Markuze       2026-08-20  1752  				      (parent, dname.len,
20d024e610cdb81 Alex Markuze       2026-08-20  1753  				       BLOG_STR(dname.name, dname.len), dn),
20d024e610cdb81 Alex Markuze       2026-08-20  1754  				      (parent, dname.len,
20d024e610cdb81 Alex Markuze       2026-08-20  1755  				       (const char *)dname.name, dn));
19913b4eac4a230 Yan, Zheng         2014-03-06  1756  
19913b4eac4a230 Yan, Zheng         2014-03-06  1757  			if (!dn) {
19913b4eac4a230 Yan, Zheng         2014-03-06  1758  				dn = d_alloc(parent, &dname);
20d024e610cdb81 Alex Markuze       2026-08-20  1759  				boutc_bounded(cl, "d_alloc %p '%.*s' = %p\n",
20d024e610cdb81 Alex Markuze       2026-08-20  1760  					      (parent, dname.len,
20d024e610cdb81 Alex Markuze       2026-08-20  1761  					       BLOG_STR(dname.name, dname.len), dn),
20d024e610cdb81 Alex Markuze       2026-08-20  1762  					      (parent, dname.len,
20d024e610cdb81 Alex Markuze       2026-08-20  1763  					       (const char *)dname.name, dn));
d37b1d9943d5138 Markus Elfring     2017-08-20  1764  				if (!dn) {
19913b4eac4a230 Yan, Zheng         2014-03-06  1765  					dput(parent);
bec324f33d1ed34 Alex Markuze       2025-08-12  1766  					ceph_fname_free_buffer(parent_dir, &oname);
19913b4eac4a230 Yan, Zheng         2014-03-06  1767  					err = -ENOMEM;
19913b4eac4a230 Yan, Zheng         2014-03-06  1768  					goto done;
19913b4eac4a230 Yan, Zheng         2014-03-06  1769  				}
855290962c55812 Jeff Layton        2020-08-10  1770  				if (is_nokey) {
855290962c55812 Jeff Layton        2020-08-10  1771  					spin_lock(&dn->d_lock);
855290962c55812 Jeff Layton        2020-08-10  1772  					dn->d_flags |= DCACHE_NOKEY_NAME;
855290962c55812 Jeff Layton        2020-08-10  1773  					spin_unlock(&dn->d_lock);
855290962c55812 Jeff Layton        2020-08-10  1774  				}
ad5cb123fd0e4d9 Al Viro            2016-10-28  1775  				err = 0;
2b0143b5c986be1 David Howells      2015-03-17  1776  			} else if (d_really_is_positive(dn) &&
f5d55f03973f79a Jeff Layton        2017-01-27  1777  				   (ceph_ino(d_inode(dn)) != tvino.ino ||
f5d55f03973f79a Jeff Layton        2017-01-27  1778  				    ceph_snap(d_inode(dn)) != tvino.snap)) {
20d024e610cdb81 Alex Markuze       2026-08-20  1779  				boutc(cl, " dn %p points to wrong inode %p\n",
2b0143b5c986be1 David Howells      2015-03-17  1780  				      dn, d_inode(dn));
bec324f33d1ed34 Alex Markuze       2025-08-12  1781  				ceph_dir_clear_ordered(parent_dir);
19913b4eac4a230 Yan, Zheng         2014-03-06  1782  				d_delete(dn);
19913b4eac4a230 Yan, Zheng         2014-03-06  1783  				dput(dn);
19913b4eac4a230 Yan, Zheng         2014-03-06  1784  				goto retry_lookup;
19913b4eac4a230 Yan, Zheng         2014-03-06  1785  			}
bec324f33d1ed34 Alex Markuze       2025-08-12  1786  			ceph_fname_free_buffer(parent_dir, &oname);
19913b4eac4a230 Yan, Zheng         2014-03-06  1787  
19913b4eac4a230 Yan, Zheng         2014-03-06  1788  			req->r_dentry = dn;
19913b4eac4a230 Yan, Zheng         2014-03-06  1789  			dput(parent);
19913b4eac4a230 Yan, Zheng         2014-03-06  1790  		}
5b1daecd59f95eb Sage Weil          2010-01-25  1791  	}
5b1daecd59f95eb Sage Weil          2010-01-25  1792  
86b58d13134ef14 Yan, Zheng         2013-12-05  1793  	if (rinfo->head->is_target) {
bca9fc14c70fcbb Jeff Layton        2020-11-12  1794  		/* Should be filled in by handle_reply */
bca9fc14c70fcbb Jeff Layton        2020-11-12  1795  		BUG_ON(!req->r_target_inode);
86b58d13134ef14 Yan, Zheng         2013-12-05  1796  
bca9fc14c70fcbb Jeff Layton        2020-11-12  1797  		in = req->r_target_inode;
4a1c5434792df72 Alex Markuze       2026-02-10  1798  		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
4ad93ceb94be439 Tal Zussman        2026-09-02  1799  		err = ceph_fill_inode(in, req->r_locked_folio, &rinfo->targeti,
966c716018de1c0 Jeff Layton        2019-12-05  1800  				NULL, session,
bc2de10dc4da503 Jeff Layton        2017-02-01  1801  				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
3bb48b4142bbf72 Jeff Layton        2019-12-02  1802  				 !test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags) &&
bc2de10dc4da503 Jeff Layton        2017-02-01  1803  				 rinfo->head->result == 0) ?  req->r_fmode : -1,
86b58d13134ef14 Yan, Zheng         2013-12-05  1804  				&req->r_caps_reservation);
86b58d13134ef14 Yan, Zheng         2013-12-05  1805  		if (err < 0) {
38d46409c4639a1 Xiubo Li           2023-06-12  1806  			pr_err_client(cl, "badness %p %llx.%llx\n", in,
38d46409c4639a1 Xiubo Li           2023-06-12  1807  				      ceph_vinop(in));
bca9fc14c70fcbb Jeff Layton        2020-11-12  1808  			req->r_target_inode = NULL;
fa49168ea091b5e Mateusz Guzik      2025-10-09  1809  			if (inode_state_read_once(in) & I_NEW)
893e456b2c0bae6 Jeff Layton        2019-12-11  1810  				discard_new_inode(in);
68cbb8056a4c24c Jeff Layton        2020-11-12  1811  			else
68cbb8056a4c24c Jeff Layton        2020-11-12  1812  				iput(in);
86b58d13134ef14 Yan, Zheng         2013-12-05  1813  			goto done;
86b58d13134ef14 Yan, Zheng         2013-12-05  1814  		}
fa49168ea091b5e Mateusz Guzik      2025-10-09  1815  		if (inode_state_read_once(in) & I_NEW)
893e456b2c0bae6 Jeff Layton        2019-12-11  1816  			unlock_new_inode(in);
86b58d13134ef14 Yan, Zheng         2013-12-05  1817  	}
86b58d13134ef14 Yan, Zheng         2013-12-05  1818  
9358c6d4c0264b1 Sage Weil          2010-03-30  1819  	/*
9358c6d4c0264b1 Sage Weil          2010-03-30  1820  	 * ignore null lease/binding on snapdir ENOENT, or else we
9358c6d4c0264b1 Sage Weil          2010-03-30  1821  	 * will have trouble splicing in the virtual snapdir later
9358c6d4c0264b1 Sage Weil          2010-03-30  1822  	 */
3dd69aabcef3d83 Jeff Layton        2017-01-31  1823  	if (rinfo->head->is_dentry &&
bc2de10dc4da503 Jeff Layton        2017-02-01  1824              !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
3dd69aabcef3d83 Jeff Layton        2017-01-31  1825  	    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
9358c6d4c0264b1 Sage Weil          2010-03-30  1826  	    (rinfo->head->is_target || strncmp(req->r_dentry->d_name.name,
3d14c5d2b6e15c2 Yehuda Sadeh       2010-04-06  1827  					       fsc->mount_options->snapdir_name,
9358c6d4c0264b1 Sage Weil          2010-03-30  1828  					       req->r_dentry->d_name.len))) {
355da1eb7a1f91c Sage Weil          2009-10-06  1829  		/*
355da1eb7a1f91c Sage Weil          2009-10-06  1830  		 * lookup link rename   : null -> possibly existing inode
355da1eb7a1f91c Sage Weil          2009-10-06  1831  		 * mknod symlink mkdir  : null -> new inode
355da1eb7a1f91c Sage Weil          2009-10-06  1832  		 * unlink               : linked -> null
355da1eb7a1f91c Sage Weil          2009-10-06  1833  		 */
3dd69aabcef3d83 Jeff Layton        2017-01-31  1834  		struct inode *dir = req->r_parent;
355da1eb7a1f91c Sage Weil          2009-10-06  1835  		struct dentry *dn = req->r_dentry;
355da1eb7a1f91c Sage Weil          2009-10-06  1836  		bool have_dir_cap, have_lease;
355da1eb7a1f91c Sage Weil          2009-10-06  1837  
355da1eb7a1f91c Sage Weil          2009-10-06  1838  		BUG_ON(!dn);
355da1eb7a1f91c Sage Weil          2009-10-06  1839  		BUG_ON(!dir);
2b0143b5c986be1 David Howells      2015-03-17  1840  		BUG_ON(d_inode(dn->d_parent) != dir);
f5d55f03973f79a Jeff Layton        2017-01-27  1841  
f5d55f03973f79a Jeff Layton        2017-01-27  1842  		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
f5d55f03973f79a Jeff Layton        2017-01-27  1843  		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
f5d55f03973f79a Jeff Layton        2017-01-27  1844  
f5d55f03973f79a Jeff Layton        2017-01-27  1845  		BUG_ON(ceph_ino(dir) != dvino.ino);
f5d55f03973f79a Jeff Layton        2017-01-27  1846  		BUG_ON(ceph_snap(dir) != dvino.snap);
355da1eb7a1f91c Sage Weil          2009-10-06  1847  
355da1eb7a1f91c Sage Weil          2009-10-06  1848  		/* do we have a lease on the whole dir? */
355da1eb7a1f91c Sage Weil          2009-10-06  1849  		have_dir_cap =
355da1eb7a1f91c Sage Weil          2009-10-06  1850  			(le32_to_cpu(rinfo->diri.in->cap.caps) &
355da1eb7a1f91c Sage Weil          2009-10-06  1851  			 CEPH_CAP_FILE_SHARED);
355da1eb7a1f91c Sage Weil          2009-10-06  1852  
355da1eb7a1f91c Sage Weil          2009-10-06  1853  		/* do we have a dn lease? */
355da1eb7a1f91c Sage Weil          2009-10-06  1854  		have_lease = have_dir_cap ||
2f90b852e3ae738 Sage Weil          2011-07-26  1855  			le32_to_cpu(rinfo->dlease->duration_ms);
355da1eb7a1f91c Sage Weil          2009-10-06  1856  		if (!have_lease)
20d024e610cdb81 Alex Markuze       2026-08-20  1857  			boutc(cl, "no dentry lease or dir cap\n");
355da1eb7a1f91c Sage Weil          2009-10-06  1858  
355da1eb7a1f91c Sage Weil          2009-10-06  1859  		/* rename? */
355da1eb7a1f91c Sage Weil          2009-10-06  1860  		if (req->r_old_dentry && req->r_op == CEPH_MDS_OP_RENAME) {
0a8a70f96fe1bd3 Yan, Zheng         2014-04-14  1861  			struct inode *olddir = req->r_old_dentry_dir;
0a8a70f96fe1bd3 Yan, Zheng         2014-04-14  1862  			BUG_ON(!olddir);
0a8a70f96fe1bd3 Yan, Zheng         2014-04-14  1863  
20d024e610cdb81 Alex Markuze       2026-08-20  1864  			boutc(cl, " src %p '%s' dst %p '%s'\n",
20d024e610cdb81 Alex Markuze       2026-08-20  1865  			      req->r_old_dentry, req->r_old_dentry->d_name.name, dn, dn->d_name.name);
20d024e610cdb81 Alex Markuze       2026-08-20  1866  			boutc(cl, "doing d_move %p -> %p\n", req->r_old_dentry, dn);
c10f5e12bafde7f Sage Weil          2010-04-16  1867  
fdd4e15838e59c3 Yan, Zheng         2015-06-16  1868  			/* d_move screws up sibling dentries' offsets */
fdd4e15838e59c3 Yan, Zheng         2015-06-16  1869  			ceph_dir_clear_ordered(dir);
fdd4e15838e59c3 Yan, Zheng         2015-06-16  1870  			ceph_dir_clear_ordered(olddir);
fdd4e15838e59c3 Yan, Zheng         2015-06-16  1871  
355da1eb7a1f91c Sage Weil          2009-10-06  1872  			d_move(req->r_old_dentry, dn);
20d024e610cdb81 Alex Markuze       2026-08-20  1873  			boutc(cl, " src %p '%s' dst %p '%s'\n",
20d024e610cdb81 Alex Markuze       2026-08-20  1874  			      req->r_old_dentry, req->r_old_dentry->d_name.name, dn, dn->d_name.name);
81a6cf2d30eac5d Sage Weil          2010-05-14  1875  
c4a29f26d50bea6 Sage Weil          2009-12-21  1876  			/* ensure target dentry is invalidated, despite
c4a29f26d50bea6 Sage Weil          2009-12-21  1877  			   rehashing bug in vfs_rename_dir */
81a6cf2d30eac5d Sage Weil          2010-05-14  1878  			ceph_invalidate_dentry_lease(dn);
81a6cf2d30eac5d Sage Weil          2010-05-14  1879  
20d024e610cdb81 Alex Markuze       2026-08-20  1880  			boutc(cl, "dn %p gets new offset %lld\n",
38d46409c4639a1 Xiubo Li           2023-06-12  1881  			      req->r_old_dentry,
1cd3935bedccf59 Sage Weil          2010-05-03  1882  			      ceph_dentry(req->r_old_dentry)->offset);
81a6cf2d30eac5d Sage Weil          2010-05-14  1883  
2bf996ac4832664 Yan, Zheng         2018-10-25  1884  			/* swap r_dentry and r_old_dentry in case that
2bf996ac4832664 Yan, Zheng         2018-10-25  1885  			 * splice_dentry() gets called later. This is safe
2bf996ac4832664 Yan, Zheng         2018-10-25  1886  			 * because no other place will use them */
2bf996ac4832664 Yan, Zheng         2018-10-25  1887  			req->r_dentry = req->r_old_dentry;
2bf996ac4832664 Yan, Zheng         2018-10-25  1888  			req->r_old_dentry = dn;
2bf996ac4832664 Yan, Zheng         2018-10-25  1889  			dn = req->r_dentry;
355da1eb7a1f91c Sage Weil          2009-10-06  1890  		}
355da1eb7a1f91c Sage Weil          2009-10-06  1891  
355da1eb7a1f91c Sage Weil          2009-10-06  1892  		/* null dentry? */
355da1eb7a1f91c Sage Weil          2009-10-06  1893  		if (!rinfo->head->is_target) {
20d024e610cdb81 Alex Markuze       2026-08-20  1894  			boutc(cl, "null dentry\n");
2b0143b5c986be1 David Howells      2015-03-17  1895  			if (d_really_is_positive(dn)) {
20d024e610cdb81 Alex Markuze       2026-08-20  1896  				boutc(cl, "d_delete %p\n", dn);
5495c2d04f85da0 Yan, Zheng         2017-11-27  1897  				ceph_dir_clear_ordered(dir);
355da1eb7a1f91c Sage Weil          2009-10-06  1898  				d_delete(dn);
80d025ffede8896 Jeff Layton        2017-01-26  1899  			} else if (have_lease) {
af59562a5b3d34f Xiubo Li           2026-07-23  1900  				if (d_unhashed(dn) &&
af59562a5b3d34f Xiubo Li           2026-07-23  1901  				    ceph_snap(dir) == CEPH_NOSNAP)
f8b31710e46c852 Al Viro            2016-03-07  1902  					d_add(dn, NULL);
7ffe4fcea789552 Xiubo Li           2022-03-30  1903  			}
7ffe4fcea789552 Xiubo Li           2022-03-30  1904  
7ffe4fcea789552 Xiubo Li           2022-03-30  1905  			if (!d_unhashed(dn) && have_lease)
543212b3a4a4abe Yan, Zheng         2019-05-22  1906  				update_dentry_lease(dir, dn,
543212b3a4a4abe Yan, Zheng         2019-05-22  1907  						    rinfo->dlease, session,
543212b3a4a4abe Yan, Zheng         2019-05-22  1908  						    req->r_request_started);
355da1eb7a1f91c Sage Weil          2009-10-06  1909  			goto done;
355da1eb7a1f91c Sage Weil          2009-10-06  1910  		}
355da1eb7a1f91c Sage Weil          2009-10-06  1911  
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1912  		if (unlikely(!in)) {
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1913  			err = -EINVAL;
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1914  			goto done;
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1915  		}
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1916  
355da1eb7a1f91c Sage Weil          2009-10-06  1917  		/* attach proper inode */
2b0143b5c986be1 David Howells      2015-03-17  1918  		if (d_really_is_negative(dn)) {
70db4f3629b3476 Yan, Zheng         2014-10-21  1919  			ceph_dir_clear_ordered(dir);
86b58d13134ef14 Yan, Zheng         2013-12-05  1920  			ihold(in);
2bf996ac4832664 Yan, Zheng         2018-10-25  1921  			err = splice_dentry(&req->r_dentry, in);
2bf996ac4832664 Yan, Zheng         2018-10-25  1922  			if (err < 0)
355da1eb7a1f91c Sage Weil          2009-10-06  1923  				goto done;
2bf996ac4832664 Yan, Zheng         2018-10-25  1924  			dn = req->r_dentry;  /* may have spliced */
2b0143b5c986be1 David Howells      2015-03-17  1925  		} else if (d_really_is_positive(dn) && d_inode(dn) != in) {
20d024e610cdb81 Alex Markuze       2026-08-20  1926  			boutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
2b0143b5c986be1 David Howells      2015-03-17  1927  			      dn, d_inode(dn), ceph_vinop(d_inode(dn)),
86b58d13134ef14 Yan, Zheng         2013-12-05  1928  			      ceph_vinop(in));
200fd27c8fa2ba8 Yan, Zheng         2016-03-17  1929  			d_invalidate(dn);
355da1eb7a1f91c Sage Weil          2009-10-06  1930  			have_lease = false;
355da1eb7a1f91c Sage Weil          2009-10-06  1931  		}
355da1eb7a1f91c Sage Weil          2009-10-06  1932  
f5d55f03973f79a Jeff Layton        2017-01-27  1933  		if (have_lease) {
543212b3a4a4abe Yan, Zheng         2019-05-22  1934  			update_dentry_lease(dir, dn,
543212b3a4a4abe Yan, Zheng         2019-05-22  1935  					    rinfo->dlease, session,
543212b3a4a4abe Yan, Zheng         2019-05-22  1936  					    req->r_request_started);
f5d55f03973f79a Jeff Layton        2017-01-27  1937  		}
20d024e610cdb81 Alex Markuze       2026-08-20  1938  		boutc(cl, " final dn %p\n", dn);
bc2de10dc4da503 Jeff Layton        2017-02-01  1939  	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
bc2de10dc4da503 Jeff Layton        2017-02-01  1940  		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
1f08529c84cfeca Al Viro            2019-10-29  1941  	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
bc2de10dc4da503 Jeff Layton        2017-02-01  1942  		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
3dd69aabcef3d83 Jeff Layton        2017-01-31  1943  		struct inode *dir = req->r_parent;
355da1eb7a1f91c Sage Weil          2009-10-06  1944  
355da1eb7a1f91c Sage Weil          2009-10-06  1945  		/* fill out a snapdir LOOKUPSNAP dentry */
0a8a70f96fe1bd3 Yan, Zheng         2014-04-14  1946  		BUG_ON(!dir);
0a8a70f96fe1bd3 Yan, Zheng         2014-04-14  1947  		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
2bf996ac4832664 Yan, Zheng         2018-10-25  1948  		BUG_ON(!req->r_dentry);
20d024e610cdb81 Alex Markuze       2026-08-20  1949  		boutc(cl, " linking snapped dir %p to dn %p\n", in,
38d46409c4639a1 Xiubo Li           2023-06-12  1950  		      req->r_dentry);
70db4f3629b3476 Yan, Zheng         2014-10-21  1951  		ceph_dir_clear_ordered(dir);
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1952  
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1953  		if (unlikely(!in)) {
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1954  			err = -EINVAL;
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1955  			goto done;
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1956  		}
98a2850de49c10a Viacheslav Dubeyko 2025-08-28  1957  
86b58d13134ef14 Yan, Zheng         2013-12-05  1958  		ihold(in);
2bf996ac4832664 Yan, Zheng         2018-10-25  1959  		err = splice_dentry(&req->r_dentry, in);
2bf996ac4832664 Yan, Zheng         2018-10-25  1960  		if (err < 0)
355da1eb7a1f91c Sage Weil          2009-10-06  1961  			goto done;
543212b3a4a4abe Yan, Zheng         2019-05-22  1962  	} else if (rinfo->head->is_dentry && req->r_dentry) {
0039aebfe87129f Yan Zhen           2024-09-05  1963  		/* parent inode is not locked, be careful */
cdde7c43513de7d Jeff Layton        2017-01-27  1964  		struct ceph_vino *ptvino = NULL;
cdde7c43513de7d Jeff Layton        2017-01-27  1965  		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
cdde7c43513de7d Jeff Layton        2017-01-27  1966  		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
cdde7c43513de7d Jeff Layton        2017-01-27  1967  		if (rinfo->head->is_target) {
cdde7c43513de7d Jeff Layton        2017-01-27  1968  			tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
cdde7c43513de7d Jeff Layton        2017-01-27  1969  			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
cdde7c43513de7d Jeff Layton        2017-01-27  1970  			ptvino = &tvino;
cdde7c43513de7d Jeff Layton        2017-01-27  1971  		}
543212b3a4a4abe Yan, Zheng         2019-05-22  1972  		update_dentry_lease_careful(req->r_dentry, rinfo->dlease,
543212b3a4a4abe Yan, Zheng         2019-05-22  1973  					    session, req->r_request_started,
543212b3a4a4abe Yan, Zheng         2019-05-22  1974  					    rinfo->dname, rinfo->dname_len,
543212b3a4a4abe Yan, Zheng         2019-05-22  1975  					    &dvino, ptvino);
355da1eb7a1f91c Sage Weil          2009-10-06  1976  	}
355da1eb7a1f91c Sage Weil          2009-10-06  1977  done:
bec324f33d1ed34 Alex Markuze       2025-08-12  1978  	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
bec324f33d1ed34 Alex Markuze       2025-08-12  1979  	if (unlikely(!IS_ERR_OR_NULL(parent_dir) && parent_dir != req->r_parent))
bec324f33d1ed34 Alex Markuze       2025-08-12  1980  		iput(parent_dir);
20d024e610cdb81 Alex Markuze       2026-08-20  1981  	boutc(cl, "done err=%d\n", err);
355da1eb7a1f91c Sage Weil          2009-10-06  1982  	return err;
355da1eb7a1f91c Sage Weil          2009-10-06 @1983  }
355da1eb7a1f91c Sage Weil          2009-10-06  1984  

:::::: The code at line 1983 was first introduced by commit
:::::: 355da1eb7a1f91c276b991764e951bbcd8047599 ceph: inode operations

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
