Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801435DA6F
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473183; cv=none; b=gh5UL1W0T6dnXykXmcd0Xhysx3dp+7VI6XqngPY2P63p5No4zHwdxwMhCtvy3oSCM1XWyh5K8fD10Po5WbgN+u6LUDftZq/EJj1iBCVZ1QyaKyMcfLCE+xuQ7xMvJYTaNqgy/zPfd+usvi4ltxOabxTor2svpSfVMq9C1gffVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473183; c=relaxed/simple;
	bh=gQKDg+PjMVfdZ8belB0MhPPvUeOvJ0purvdKquIBMn0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DN3VOakOf+U3f0albmDG6zMdxptoMIEgCetEyRGis8v3Hlo56iuop+GORV2H2hoEGZNSQ4i2U5EcS2Le4gGfki4w0yXfS+/Nr1e3undvl9pcE3uOZR+H6KfYMh4hH9qAE67YZN7BCmiFRuJ3dZfJi5V7MnSDPgrFF7D4ZyeBxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exyRPI8J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exyRPI8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783473182; x=1815009182;
  h=date:from:to:cc:subject:message-id;
  bh=gQKDg+PjMVfdZ8belB0MhPPvUeOvJ0purvdKquIBMn0=;
  b=exyRPI8JsPVH9ypcsegbXJkO1Up/XyrQepsB3JvHcBtAdXB/tNYDC8FZ
   tfN5/12Hka9AEucZ/QWC+uvbzKRRCha4L8ANQzLnye9uIFcdvni1a9sRO
   zdxVxA41nOjkElitmwKTWLyrW3/IKXLf6AvoIk1dZVcl8zfqrD6+lgvYz
   I98iYceRl0MkKNN/6KqbPbh1hUR68d/QChps3hpvHXsylNeqCwphJ/36W
   4TIAwRmtO8c9DP2ZnNZHO9eiLES8zwJUHGpKUEEPJfHMgSMfWiIT8U1aX
   +ytYANzIWcjLrIpXOCS2tAh3sdzPJpBZjjwp3vxCCQotVFmQN4xzBp+w4
   A==;
X-CSE-ConnectionGUID: 98+CtbcKRx63vXf8hCGk5A==
X-CSE-MsgGUID: Y3G+hj1GTv+k95pZz7bzwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94484099"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94484099"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:13:01 -0700
X-CSE-ConnectionGUID: H/RDLTB9Sz6HbBYyE7tV1Q==
X-CSE-MsgGUID: 8EzM34agTZ20FT1rRkq/Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253648628"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 07 Jul 2026 18:12:59 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whGqO-000000002eX-2PNQ;
	Wed, 08 Jul 2026 01:12:56 +0000
Date: Wed, 08 Jul 2026 03:12:53 +0200
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>
Subject: [ceph-client:testing 25/27] fs/ceph/file.c:2573:7: error:
 use of undeclared identifier 'CEPH_MOUNT_OPT_NEARFULL_SYNC'
Message-ID: <202607080354.apa5Nv1u-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

tree:   https://github.com/ceph/ceph-client.git testing
head:   fc67edb66b3c9924c4e0bb366a92b32ea13c526a
commit: cb4ac0e6565fe667dba2760b6a012306e6f796e0 [25/27] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260708/202607080354.apa5Nv1u-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260708/202607080354.apa5Nv1u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607080354.apa5Nv1u-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ceph/file.c:2573:7: error: use of undeclared identifier 'CEPH_MOUNT_OPT_NEARFULL_SYNC'
    2573 |                 if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ceph/super.h:60:36: note: expanded from macro 'ceph_test_mount_opt'
      60 |         (!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
         |                                           ^~~~~~~~~~~~~~~~~~~~
   <scratch space>:27:1: note: expanded from here
      27 | CEPH_MOUNT_OPT_NEARFULL_SYNC
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/CEPH_MOUNT_OPT_NEARFULL_SYNC +2573 fs/ceph/file.c

  2395	
  2396	/*
  2397	 * Take cap references to avoid releasing caps to MDS mid-write.
  2398	 *
  2399	 * If we are synchronous, and write with an old snap context, the OSD
  2400	 * may return EOLDSNAPC.  In that case, retry the write.. _after_
  2401	 * dropping our cap refs and allowing the pending snap to logically
  2402	 * complete _before_ this write occurs.
  2403	 *
  2404	 * If requested, nearfull writes are synced to preserve the legacy
  2405	 * client-side backpressure behavior.
  2406	 */
  2407	static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
  2408	{
  2409		struct file *file = iocb->ki_filp;
  2410		struct ceph_file_info *fi = file->private_data;
  2411		struct inode *inode = file_inode(file);
  2412		struct ceph_inode_info *ci = ceph_inode(inode);
  2413		struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
  2414		struct ceph_client *cl = fsc->client;
  2415		struct ceph_osd_client *osdc = &fsc->client->osdc;
  2416		struct ceph_cap_flush *prealloc_cf;
  2417		ssize_t count, written = 0;
  2418		int err, want = 0, got;
  2419		bool direct_lock = false;
  2420		u32 map_flags;
  2421		u64 pool_flags;
  2422		loff_t pos;
  2423		loff_t limit = max(i_size_read(inode), fsc->max_file_size);
  2424	
  2425		if (ceph_inode_is_shutdown(inode))
  2426			return -ESTALE;
  2427	
  2428		if (ceph_snap(inode) != CEPH_NOSNAP)
  2429			return -EROFS;
  2430	
  2431		prealloc_cf = ceph_alloc_cap_flush();
  2432		if (!prealloc_cf)
  2433			return -ENOMEM;
  2434	
  2435		if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) == IOCB_DIRECT)
  2436			direct_lock = true;
  2437	
  2438	retry_snap:
  2439		err = direct_lock ? ceph_start_io_direct(inode) :
  2440				    ceph_start_io_write(inode);
  2441		if (err)
  2442			goto out_unlocked;
  2443	
  2444		if (iocb->ki_flags & IOCB_APPEND) {
  2445			err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
  2446			if (err < 0)
  2447				goto out;
  2448		}
  2449	
  2450		err = generic_write_checks(iocb, from);
  2451		if (err <= 0)
  2452			goto out;
  2453	
  2454		pos = iocb->ki_pos;
  2455		if (unlikely(pos >= limit)) {
  2456			err = -EFBIG;
  2457			goto out;
  2458		} else {
  2459			iov_iter_truncate(from, limit - pos);
  2460		}
  2461	
  2462		count = iov_iter_count(from);
  2463		if (ceph_quota_is_max_bytes_exceeded(inode, pos + count)) {
  2464			err = -EDQUOT;
  2465			goto out;
  2466		}
  2467	
  2468		down_read(&osdc->lock);
  2469		map_flags = osdc->osdmap->flags;
  2470		pool_flags = ceph_pg_pool_flags(osdc->osdmap, ci->i_layout.pool_id);
  2471		up_read(&osdc->lock);
  2472		if ((map_flags & CEPH_OSDMAP_FULL) ||
  2473		    (pool_flags & CEPH_POOL_FLAG_FULL)) {
  2474			err = -ENOSPC;
  2475			goto out;
  2476		}
  2477	
  2478		err = file_remove_privs(file);
  2479		if (err)
  2480			goto out;
  2481	
  2482		doutc(cl, "%p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
  2483		      inode, ceph_vinop(inode), pos, count,
  2484		      i_size_read(inode));
  2485		if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
  2486			want |= CEPH_CAP_FILE_BUFFER;
  2487		if (fi->fmode & CEPH_FILE_MODE_LAZY)
  2488			want |= CEPH_CAP_FILE_LAZYIO;
  2489		got = 0;
  2490		err = ceph_get_caps(file, CEPH_CAP_FILE_WR, want, pos + count, &got);
  2491		if (err < 0)
  2492			goto out;
  2493	
  2494		err = file_update_time(file);
  2495		if (err)
  2496			goto out_caps;
  2497	
  2498		inode_inc_iversion_raw(inode);
  2499	
  2500		doutc(cl, "%p %llx.%llx %llu~%zd got cap refs on %s\n",
  2501		      inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
  2502	
  2503		if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
  2504		    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
  2505		    test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
  2506			struct ceph_snap_context *snapc;
  2507			struct iov_iter data;
  2508	
  2509			spin_lock(&ci->i_ceph_lock);
  2510			if (__ceph_have_pending_cap_snap(ci)) {
  2511				struct ceph_cap_snap *capsnap =
  2512						list_last_entry(&ci->i_cap_snaps,
  2513								struct ceph_cap_snap,
  2514								ci_item);
  2515				snapc = ceph_get_snap_context(capsnap->context);
  2516			} else {
  2517				BUG_ON(!ci->i_head_snapc);
  2518				snapc = ceph_get_snap_context(ci->i_head_snapc);
  2519			}
  2520			spin_unlock(&ci->i_ceph_lock);
  2521	
  2522			/* we might need to revert back to that point */
  2523			data = *from;
  2524			if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
  2525				written = ceph_direct_read_write(iocb, &data, snapc,
  2526								 &prealloc_cf);
  2527			else
  2528				written = ceph_sync_write(iocb, &data, pos, snapc);
  2529			if (direct_lock)
  2530				ceph_end_io_direct(inode);
  2531			else
  2532				ceph_end_io_write(inode);
  2533			if (written > 0)
  2534				iov_iter_advance(from, written);
  2535			ceph_put_snap_context(snapc);
  2536		} else {
  2537			/*
  2538			 * No need to acquire the i_truncate_mutex. Because
  2539			 * the MDS revokes Fwb caps before sending truncate
  2540			 * message to us. We can't get Fwb cap while there
  2541			 * are pending vmtruncate. So write and vmtruncate
  2542			 * can not run at the same time
  2543			 */
  2544			written = generic_perform_write(iocb, from);
  2545			ceph_end_io_write(inode);
  2546		}
  2547	
  2548		if (written >= 0) {
  2549			int dirty;
  2550	
  2551			spin_lock(&ci->i_ceph_lock);
  2552			dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
  2553						       &prealloc_cf);
  2554			spin_unlock(&ci->i_ceph_lock);
  2555			if (dirty)
  2556				__mark_inode_dirty(inode, dirty);
  2557			if (ceph_quota_is_max_bytes_approaching(inode, iocb->ki_pos))
  2558				ceph_check_caps(ci, CHECK_CAPS_FLUSH);
  2559		}
  2560	
  2561		doutc(cl, "%p %llx.%llx %llu~%u  dropping cap refs on %s\n",
  2562		      inode, ceph_vinop(inode), pos, (unsigned)count,
  2563		      ceph_cap_string(got));
  2564		ceph_put_cap_refs(ci, got);
  2565	
  2566		if (written == -EOLDSNAPC) {
  2567			doutc(cl, "%p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
  2568			      inode, ceph_vinop(inode), pos, (unsigned)count);
  2569			goto retry_snap;
  2570		}
  2571	
  2572		if (written >= 0) {
> 2573			if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
  2574			    ((map_flags & CEPH_OSDMAP_NEARFULL) ||
  2575			     (pool_flags & CEPH_POOL_FLAG_NEARFULL)))
  2576				iocb->ki_flags |= IOCB_DSYNC;
  2577			written = generic_write_sync(iocb, written);
  2578		}
  2579	
  2580		goto out_unlocked;
  2581	out_caps:
  2582		ceph_put_cap_refs(ci, got);
  2583	out:
  2584		if (direct_lock)
  2585			ceph_end_io_direct(inode);
  2586		else
  2587			ceph_end_io_write(inode);
  2588	out_unlocked:
  2589		ceph_free_cap_flush(prealloc_cf);
  2590		return written ? written : err;
  2591	}
  2592	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
