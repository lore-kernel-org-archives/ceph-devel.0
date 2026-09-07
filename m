Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745F3EC691
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802092; cv=none; b=lqLHBsbevmfsmyS1B4+you3lgQykl0gdHUmdCWyvxu9AuqnSNm2krKYRqmNg2tyavGl1IANGAxQEB2V8EZ8Y+G6kR6KYyqCX8w+MKIfM7WzjbZCG+o6GA7lRCj2pkWKWdRgBm5Mm4vTpV0MhaSC761ZJEyIZNCc7NH2wRGfT0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802092; c=relaxed/simple;
	bh=Pz5w6KrBYeGCzMVTZJGX1ZkMymI8+2Qbvc7/IyPNk88=;
	h=Date:From:To:Cc:Subject:Message-ID; b=exXf3IryeVXhEtJot5cM6Lj7jM22nxs0HgihovhocX8RWunCe2gjDyuwDg50hRBPThAYFXCRHTYkTCS7DP/IGvWwGjOZHtFAp853RgkC90+HI/zSkiqS673VicJK/P1buycFT1uFOvjsy2MzAnxILMSKpSXTp1fuEGCSdCG0BqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzPQOXpn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzPQOXpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788802090; x=1820338090;
  h=date:from:to:cc:subject:message-id;
  bh=Pz5w6KrBYeGCzMVTZJGX1ZkMymI8+2Qbvc7/IyPNk88=;
  b=PzPQOXpnDZ1H8S9H8nPhVGjkQKQvNaZ6vNJoseNsuFL6JETh8cu36sPZ
   O8UOwkZCqOqs3toEV9he7TM1F2Hukncqosot7g9ZSR8xxVSdDsVOjqBP+
   GV5XpcpMcDLnR6hAAPim9+KqzM+nw2wMCsYDZ6sNfUBXo02uxRCFGJqsF
   AAmGfBHBc8KWNqe79r6AmaHBFl3omAkQ8ybycu0cTiPO3MD55y126TaXs
   d1q3fToYRR7PYztVkfWlMp4BoNKVjE75KtcHHAaUfVFfExrti+59yYdeC
   6xEad/r2EIDCR82seyFPdH5p8idM/ZGzpOdR3MjO29GfFwkrBgYeLSAnz
   A==;
X-CSE-ConnectionGUID: BztOyfrmSqq5fq6U/z0Fzw==
X-CSE-MsgGUID: EX7/mpG4S6OSA6AyO0kC8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89239922"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89239922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 10:28:10 -0700
X-CSE-ConnectionGUID: K+Y7d9rNTSih2j9K5VZ0Ag==
X-CSE-MsgGUID: pjecLDRJTLKQlz+kCUD8yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="270740556"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Sep 2026 10:28:08 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3d8Y-0000000019z-0mfP;
	Mon, 07 Sep 2026 17:28:06 +0000
Date: Tue, 08 Sep 2026 01:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org
Subject: [ceph-client:testing 27/33] fs/ceph/mds_client.c:1570:1:
 warning: the frame size of 1336 bytes is larger than 1280 bytes
Message-ID: <202609080111.BlLtlFth-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   190736464f4572bfb360fd3747fb827493e02e09
commit: 27901d0a65af9fd24268a3bcbaaee2ec8dc3366d [27/33] ceph: switch MDS request plumbing to struct ceph_journal_info
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260908/202609080111.BlLtlFth-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080111.BlLtlFth-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080111.BlLtlFth-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ceph/mds_client.c: In function '__choose_mds':
>> fs/ceph/mds_client.c:1570:1: warning: the frame size of 1336 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    1570 | }
         | ^


vim +1570 fs/ceph/mds_client.c

30c71233a1d4b5 Jeff Layton    2016-12-15  1408  
2f2dc053404feb Sage Weil      2009-10-06  1409  /*
2f2dc053404feb Sage Weil      2009-10-06  1410   * Choose mds to send request to next.  If there is a hint set in the
2f2dc053404feb Sage Weil      2009-10-06  1411   * request (e.g., due to a prior forward hint from the mds), use that.
2f2dc053404feb Sage Weil      2009-10-06  1412   * Otherwise, consult frag tree and/or caps to identify the
2f2dc053404feb Sage Weil      2009-10-06  1413   * appropriate mds.  If all else fails, choose randomly.
2f2dc053404feb Sage Weil      2009-10-06  1414   *
2f2dc053404feb Sage Weil      2009-10-06  1415   * Called under mdsc->mutex.
2f2dc053404feb Sage Weil      2009-10-06  1416   */
2f2dc053404feb Sage Weil      2009-10-06  1417  static int __choose_mds(struct ceph_mds_client *mdsc,
c4853e9776caef Xiubo Li       2019-12-09  1418  			struct ceph_mds_request *req,
c4853e9776caef Xiubo Li       2019-12-09  1419  			bool *random)
2f2dc053404feb Sage Weil      2009-10-06  1420  {
2f2dc053404feb Sage Weil      2009-10-06  1421  	struct inode *inode;
2f2dc053404feb Sage Weil      2009-10-06  1422  	struct ceph_inode_info *ci;
2f2dc053404feb Sage Weil      2009-10-06  1423  	struct ceph_cap *cap;
2f2dc053404feb Sage Weil      2009-10-06  1424  	int mode = req->r_direct_mode;
2f2dc053404feb Sage Weil      2009-10-06  1425  	int mds = -1;
2f2dc053404feb Sage Weil      2009-10-06  1426  	u32 hash = req->r_direct_hash;
bc2de10dc4da50 Jeff Layton    2017-02-01  1427  	bool is_hash = test_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
38d46409c4639a Xiubo Li       2023-06-12  1428  	struct ceph_client *cl = mdsc->fsc->client;
2f2dc053404feb Sage Weil      2009-10-06  1429  
c4853e9776caef Xiubo Li       2019-12-09  1430  	if (random)
c4853e9776caef Xiubo Li       2019-12-09  1431  		*random = false;
c4853e9776caef Xiubo Li       2019-12-09  1432  
2f2dc053404feb Sage Weil      2009-10-06  1433  	/*
2f2dc053404feb Sage Weil      2009-10-06  1434  	 * is there a specific mds we should try?  ignore hint if we have
2f2dc053404feb Sage Weil      2009-10-06  1435  	 * no session and the mds is not up (active or recovering).
2f2dc053404feb Sage Weil      2009-10-06  1436  	 */
2f2dc053404feb Sage Weil      2009-10-06  1437  	if (req->r_resend_mds >= 0 &&
2f2dc053404feb Sage Weil      2009-10-06  1438  	    (__have_session(mdsc, req->r_resend_mds) ||
2f2dc053404feb Sage Weil      2009-10-06  1439  	     ceph_mdsmap_get_state(mdsc->mdsmap, req->r_resend_mds) > 0)) {
27901d0a65af9f Alex Markuze   2026-08-20  1440  		boutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
2f2dc053404feb Sage Weil      2009-10-06  1441  		return req->r_resend_mds;
2f2dc053404feb Sage Weil      2009-10-06  1442  	}
2f2dc053404feb Sage Weil      2009-10-06  1443  
2f2dc053404feb Sage Weil      2009-10-06  1444  	if (mode == USE_RANDOM_MDS)
2f2dc053404feb Sage Weil      2009-10-06  1445  		goto random;
2f2dc053404feb Sage Weil      2009-10-06  1446  
2f2dc053404feb Sage Weil      2009-10-06  1447  	inode = NULL;
2f2dc053404feb Sage Weil      2009-10-06  1448  	if (req->r_inode) {
5d37ca1480a70f Yan, Zheng     2017-07-26  1449  		if (ceph_snap(req->r_inode) != CEPH_SNAPDIR) {
2f2dc053404feb Sage Weil      2009-10-06  1450  			inode = req->r_inode;
30c71233a1d4b5 Jeff Layton    2016-12-15  1451  			ihold(inode);
5d37ca1480a70f Yan, Zheng     2017-07-26  1452  		} else {
38f340ccdf9ed5 Yan, Zheng     2017-09-22  1453  			/* req->r_dentry is non-null for LSSNAP request */
38f340ccdf9ed5 Yan, Zheng     2017-09-22  1454  			rcu_read_lock();
38f340ccdf9ed5 Yan, Zheng     2017-09-22  1455  			inode = get_nonsnap_parent(req->r_dentry);
38f340ccdf9ed5 Yan, Zheng     2017-09-22  1456  			rcu_read_unlock();
27901d0a65af9f Alex Markuze   2026-08-20  1457  			boutc(cl, "using snapdir's parent %p %llx.%llx\n",
38d46409c4639a Xiubo Li       2023-06-12  1458  			      inode, ceph_vinop(inode));
5d37ca1480a70f Yan, Zheng     2017-07-26  1459  		}
38f340ccdf9ed5 Yan, Zheng     2017-09-22  1460  	} else if (req->r_dentry) {
d79698da32b317 Sage Weil      2011-07-26  1461  		/* ignore race with rename; old or new d_parent is okay */
30c71233a1d4b5 Jeff Layton    2016-12-15  1462  		struct dentry *parent;
30c71233a1d4b5 Jeff Layton    2016-12-15  1463  		struct inode *dir;
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1464  
30c71233a1d4b5 Jeff Layton    2016-12-15  1465  		rcu_read_lock();
41883ba8ee91af Yan, Zheng     2019-05-23  1466  		parent = READ_ONCE(req->r_dentry->d_parent);
3dd69aabcef3d8 Jeff Layton    2017-01-31  1467  		dir = req->r_parent ? : d_inode_rcu(parent);
30c71233a1d4b5 Jeff Layton    2016-12-15  1468  
30c71233a1d4b5 Jeff Layton    2016-12-15  1469  		if (!dir || dir->i_sb != mdsc->fsc->sb) {
30c71233a1d4b5 Jeff Layton    2016-12-15  1470  			/*  not this fs or parent went negative */
2b0143b5c986be David Howells  2015-03-17  1471  			inode = d_inode(req->r_dentry);
30c71233a1d4b5 Jeff Layton    2016-12-15  1472  			if (inode)
30c71233a1d4b5 Jeff Layton    2016-12-15  1473  				ihold(inode);
ccb36aa1b70369 Max Kellermann 2026-08-24  1474  		} else if (ceph_in_snap(dir)) {
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1475  			/* direct snapped/virtual snapdir requests
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1476  			 * based on parent dir inode */
30c71233a1d4b5 Jeff Layton    2016-12-15  1477  			inode = get_nonsnap_parent(parent);
27901d0a65af9f Alex Markuze   2026-08-20  1478  			boutc(cl, "using nonsnap parent %p %llx.%llx\n",
38d46409c4639a Xiubo Li       2023-06-12  1479  			      inode, ceph_vinop(inode));
ca18bede048e95 Yan, Zheng     2013-11-22  1480  		} else {
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1481  			/* dentry target */
2b0143b5c986be David Howells  2015-03-17  1482  			inode = d_inode(req->r_dentry);
ca18bede048e95 Yan, Zheng     2013-11-22  1483  			if (!inode || mode == USE_AUTH_MDS) {
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1484  				/* dir + name */
30c71233a1d4b5 Jeff Layton    2016-12-15  1485  				inode = igrab(dir);
e5f86dc377e7ff Sage Weil      2011-07-26  1486  				hash = ceph_dentry_hash(dir, req->r_dentry);
2f2dc053404feb Sage Weil      2009-10-06  1487  				is_hash = true;
30c71233a1d4b5 Jeff Layton    2016-12-15  1488  			} else {
30c71233a1d4b5 Jeff Layton    2016-12-15  1489  				ihold(inode);
2f2dc053404feb Sage Weil      2009-10-06  1490  			}
2f2dc053404feb Sage Weil      2009-10-06  1491  		}
30c71233a1d4b5 Jeff Layton    2016-12-15  1492  		rcu_read_unlock();
ca18bede048e95 Yan, Zheng     2013-11-22  1493  	}
eb6bb1c5bdc6e4 Sage Weil      2010-08-16  1494  
2f2dc053404feb Sage Weil      2009-10-06  1495  	if (!inode)
2f2dc053404feb Sage Weil      2009-10-06  1496  		goto random;
38d46409c4639a Xiubo Li       2023-06-12  1497  
27901d0a65af9f Alex Markuze   2026-08-20  1498  	boutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
38d46409c4639a Xiubo Li       2023-06-12  1499  	      ceph_vinop(inode), (int)is_hash, hash, mode);
2f2dc053404feb Sage Weil      2009-10-06  1500  	ci = ceph_inode(inode);
2f2dc053404feb Sage Weil      2009-10-06  1501  
2f2dc053404feb Sage Weil      2009-10-06  1502  	if (is_hash && S_ISDIR(inode->i_mode)) {
2f2dc053404feb Sage Weil      2009-10-06  1503  		struct ceph_inode_frag frag;
2f2dc053404feb Sage Weil      2009-10-06  1504  		int found;
2f2dc053404feb Sage Weil      2009-10-06  1505  
2f2dc053404feb Sage Weil      2009-10-06  1506  		ceph_choose_frag(ci, hash, &frag, &found);
2f2dc053404feb Sage Weil      2009-10-06  1507  		if (found) {
2f2dc053404feb Sage Weil      2009-10-06  1508  			if (mode == USE_ANY_MDS && frag.ndist > 0) {
2f2dc053404feb Sage Weil      2009-10-06  1509  				u8 r;
2f2dc053404feb Sage Weil      2009-10-06  1510  
2f2dc053404feb Sage Weil      2009-10-06  1511  				/* choose a random replica */
2f2dc053404feb Sage Weil      2009-10-06  1512  				get_random_bytes(&r, 1);
2f2dc053404feb Sage Weil      2009-10-06  1513  				r %= frag.ndist;
2f2dc053404feb Sage Weil      2009-10-06  1514  				mds = frag.dist[r];
27901d0a65af9f Alex Markuze   2026-08-20  1515  				boutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
38d46409c4639a Xiubo Li       2023-06-12  1516  				      inode, ceph_vinop(inode), frag.frag,
38d46409c4639a Xiubo Li       2023-06-12  1517  				      mds, (int)r, frag.ndist);
d66bbd441c08fe Sage Weil      2011-01-21  1518  				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
5d47648fe95412 Xiubo Li       2019-11-26  1519  				    CEPH_MDS_STATE_ACTIVE &&
5d47648fe95412 Xiubo Li       2019-11-26  1520  				    !ceph_mdsmap_is_laggy(mdsc->mdsmap, mds))
30c71233a1d4b5 Jeff Layton    2016-12-15  1521  					goto out;
2f2dc053404feb Sage Weil      2009-10-06  1522  			}
2f2dc053404feb Sage Weil      2009-10-06  1523  
2f2dc053404feb Sage Weil      2009-10-06  1524  			/* since this file/dir wasn't known to be
2f2dc053404feb Sage Weil      2009-10-06  1525  			 * replicated, then we want to look for the
2f2dc053404feb Sage Weil      2009-10-06  1526  			 * authoritative mds. */
2f2dc053404feb Sage Weil      2009-10-06  1527  			if (frag.mds >= 0) {
2f2dc053404feb Sage Weil      2009-10-06  1528  				/* choose auth mds */
2f2dc053404feb Sage Weil      2009-10-06  1529  				mds = frag.mds;
27901d0a65af9f Alex Markuze   2026-08-20  1530  				boutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
38d46409c4639a Xiubo Li       2023-06-12  1531  				      inode, ceph_vinop(inode), frag.frag, mds);
d66bbd441c08fe Sage Weil      2011-01-21  1532  				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
5d47648fe95412 Xiubo Li       2019-11-26  1533  				    CEPH_MDS_STATE_ACTIVE) {
224c7b6778fe08 Yanhu Cao      2020-07-31  1534  					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
5d47648fe95412 Xiubo Li       2019-11-26  1535  								  mds))
30c71233a1d4b5 Jeff Layton    2016-12-15  1536  						goto out;
2f2dc053404feb Sage Weil      2009-10-06  1537  				}
2f2dc053404feb Sage Weil      2009-10-06  1538  			}
5d47648fe95412 Xiubo Li       2019-11-26  1539  			mode = USE_AUTH_MDS;
5d47648fe95412 Xiubo Li       2019-11-26  1540  		}
2f2dc053404feb Sage Weil      2009-10-06  1541  	}
2f2dc053404feb Sage Weil      2009-10-06  1542  
be655596b3de58 Sage Weil      2011-11-30  1543  	spin_lock(&ci->i_ceph_lock);
2f2dc053404feb Sage Weil      2009-10-06  1544  	cap = NULL;
2f2dc053404feb Sage Weil      2009-10-06  1545  	if (mode == USE_AUTH_MDS)
2f2dc053404feb Sage Weil      2009-10-06  1546  		cap = ci->i_auth_cap;
2f2dc053404feb Sage Weil      2009-10-06  1547  	if (!cap && !RB_EMPTY_ROOT(&ci->i_caps))
2f2dc053404feb Sage Weil      2009-10-06  1548  		cap = rb_entry(rb_first(&ci->i_caps), struct ceph_cap, ci_node);
2f2dc053404feb Sage Weil      2009-10-06  1549  	if (!cap) {
be655596b3de58 Sage Weil      2011-11-30  1550  		spin_unlock(&ci->i_ceph_lock);
23c2c76ead541b Jeff Layton    2021-06-04  1551  		iput(inode);
2f2dc053404feb Sage Weil      2009-10-06  1552  		goto random;
2f2dc053404feb Sage Weil      2009-10-06  1553  	}
2f2dc053404feb Sage Weil      2009-10-06  1554  	mds = cap->session->s_mds;
27901d0a65af9f Alex Markuze   2026-08-20  1555  	boutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
38d46409c4639a Xiubo Li       2023-06-12  1556  	      ceph_vinop(inode), mds,
2f2dc053404feb Sage Weil      2009-10-06  1557  	      cap == ci->i_auth_cap ? "auth " : "", cap);
be655596b3de58 Sage Weil      2011-11-30  1558  	spin_unlock(&ci->i_ceph_lock);
30c71233a1d4b5 Jeff Layton    2016-12-15  1559  out:
23c2c76ead541b Jeff Layton    2021-06-04  1560  	iput(inode);
2f2dc053404feb Sage Weil      2009-10-06  1561  	return mds;
2f2dc053404feb Sage Weil      2009-10-06  1562  
2f2dc053404feb Sage Weil      2009-10-06  1563  random:
c4853e9776caef Xiubo Li       2019-12-09  1564  	if (random)
c4853e9776caef Xiubo Li       2019-12-09  1565  		*random = true;
c4853e9776caef Xiubo Li       2019-12-09  1566  
2f2dc053404feb Sage Weil      2009-10-06  1567  	mds = ceph_mdsmap_get_random_mds(mdsc->mdsmap);
27901d0a65af9f Alex Markuze   2026-08-20  1568  	boutc(cl, "chose random mds%d\n", mds);
2f2dc053404feb Sage Weil      2009-10-06  1569  	return mds;
2f2dc053404feb Sage Weil      2009-10-06 @1570  }
2f2dc053404feb Sage Weil      2009-10-06  1571  

:::::: The code at line 1570 was first introduced by commit
:::::: 2f2dc053404febedc9c273452d9d518fb31fde72 ceph: MDS client

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
