From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [ceph:for-linus 11/40] fs/ceph/mds_client.c:2865:1-10: second
 lock on line 2904
Date: Thu, 2 Jul 2015 22:52:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1507022251350.2124@localhost6.localdomain6>
References: <201507030213.PgivXmRP%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63166
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753624AbbGBUw0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jul 2015 16:52:26 -0400
In-Reply-To: <201507030213.PgivXmRP%fengguang.wu@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: kbuild@01.org

I haven't looked at all the called functions, to see if any of them drops 
the lock, but it could be worth a check.

julia

On Fri, 3 Jul 2015, kbuild test robot wrote:

> TO: "Yan, Zheng" <zyan@redhat.com>
> CC: Ilya Dryomov <idryomov@gmail.com>
> CC: ceph-devel@vger.kernel.org
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
> head:   5a60e87603c4c533492c515b7f62578189b03c9c
> commit: 745a8e3bccbc6adae69a98ddc525e529aa44636e [11/40] ceph: don't pre-allocate space for cap release messages
> :::::: branch date: 2 days ago
> :::::: commit date: 7 days ago
> 
> >> fs/ceph/mds_client.c:2865:1-10: second lock on line 2904
> --
> >> fs/ceph/mds_client.c:2961:1-7: preceding lock on line 2865
> 
> git remote add ceph git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
> git remote update ceph
> git checkout 745a8e3bccbc6adae69a98ddc525e529aa44636e
> vim +2865 fs/ceph/mds_client.c
> 
> a687ecaf John Spray 2014-09-19  2859  	     ceph_session_state_name(session->s_state));
> 2f2dc053 Sage Weil  2009-10-06  2860  
> 99a9c273 Yan, Zheng 2013-09-22  2861  	spin_lock(&session->s_gen_ttl_lock);
> 99a9c273 Yan, Zheng 2013-09-22  2862  	session->s_cap_gen++;
> 99a9c273 Yan, Zheng 2013-09-22  2863  	spin_unlock(&session->s_gen_ttl_lock);
> 99a9c273 Yan, Zheng 2013-09-22  2864  
> 99a9c273 Yan, Zheng 2013-09-22 @2865  	spin_lock(&session->s_cap_lock);
> 03f4fcb0 Yan, Zheng 2015-01-05  2866  	/* don't know if session is readonly */
> 03f4fcb0 Yan, Zheng 2015-01-05  2867  	session->s_readonly = 0;
> 99a9c273 Yan, Zheng 2013-09-22  2868  	/*
> 99a9c273 Yan, Zheng 2013-09-22  2869  	 * notify __ceph_remove_cap() that we are composing cap reconnect.
> 99a9c273 Yan, Zheng 2013-09-22  2870  	 * If a cap get released before being added to the cap reconnect,
> 99a9c273 Yan, Zheng 2013-09-22  2871  	 * __ceph_remove_cap() should skip queuing cap release.
> 99a9c273 Yan, Zheng 2013-09-22  2872  	 */
> 99a9c273 Yan, Zheng 2013-09-22  2873  	session->s_cap_reconnect = 1;
> e01a5946 Sage Weil  2010-05-10  2874  	/* drop old cap expires; we're about to reestablish that state */
> 745a8e3b Yan, Zheng 2015-05-14  2875  	cleanup_cap_releases(mdsc, session);
> e01a5946 Sage Weil  2010-05-10  2876  
> 5d23371f Yan, Zheng 2014-09-10  2877  	/* trim unused caps to reduce MDS's cache rejoin time */
> c0bd50e2 Yan, Zheng 2015-04-07  2878  	if (mdsc->fsc->sb->s_root)
> 5d23371f Yan, Zheng 2014-09-10  2879  		shrink_dcache_parent(mdsc->fsc->sb->s_root);
> 5d23371f Yan, Zheng 2014-09-10  2880  
> 5d23371f Yan, Zheng 2014-09-10  2881  	ceph_con_close(&session->s_con);
> 5d23371f Yan, Zheng 2014-09-10  2882  	ceph_con_open(&session->s_con,
> 5d23371f Yan, Zheng 2014-09-10  2883  		      CEPH_ENTITY_TYPE_MDS, mds,
> 5d23371f Yan, Zheng 2014-09-10  2884  		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
> 5d23371f Yan, Zheng 2014-09-10  2885  
> 5d23371f Yan, Zheng 2014-09-10  2886  	/* replay unsafe requests */
> 5d23371f Yan, Zheng 2014-09-10  2887  	replay_unsafe_requests(mdsc, session);
> 5d23371f Yan, Zheng 2014-09-10  2888  
> 5d23371f Yan, Zheng 2014-09-10  2889  	down_read(&mdsc->snap_rwsem);
> 5d23371f Yan, Zheng 2014-09-10  2890  
> 2f2dc053 Sage Weil  2009-10-06  2891  	/* traverse this session's caps */
> 44c99757 Yan, Zheng 2013-09-22  2892  	s_nr_caps = session->s_nr_caps;
> 44c99757 Yan, Zheng 2013-09-22  2893  	err = ceph_pagelist_encode_32(pagelist, s_nr_caps);
> 93cea5be Sage Weil  2009-12-23  2894  	if (err)
> 93cea5be Sage Weil  2009-12-23  2895  		goto fail;
> 20cb34ae Sage Weil  2010-05-12  2896  
> 44c99757 Yan, Zheng 2013-09-22  2897  	recon_state.nr_caps = 0;
> 20cb34ae Sage Weil  2010-05-12  2898  	recon_state.pagelist = pagelist;
> 20cb34ae Sage Weil  2010-05-12  2899  	recon_state.flock = session->s_con.peer_features & CEPH_FEATURE_FLOCK;
> 20cb34ae Sage Weil  2010-05-12  2900  	err = iterate_session_caps(session, encode_caps_cb, &recon_state);
> 2f2dc053 Sage Weil  2009-10-06  2901  	if (err < 0)
> 9abf82b8 Sage Weil  2010-05-10  2902  		goto fail;
> 2f2dc053 Sage Weil  2009-10-06  2903  
> 99a9c273 Yan, Zheng 2013-09-22 @2904  	spin_lock(&session->s_cap_lock);
> 99a9c273 Yan, Zheng 2013-09-22  2905  	session->s_cap_reconnect = 0;
> 99a9c273 Yan, Zheng 2013-09-22  2906  	spin_unlock(&session->s_cap_lock);
> 99a9c273 Yan, Zheng 2013-09-22  2907  
> 2f2dc053 Sage Weil  2009-10-06  2908  	/*
> 2f2dc053 Sage Weil  2009-10-06  2909  	 * snaprealms.  we provide mds with the ino, seq (version), and
> 2f2dc053 Sage Weil  2009-10-06  2910  	 * parent for all of our realms.  If the mds has any newer info,
> 2f2dc053 Sage Weil  2009-10-06  2911  	 * it will tell us.
> 2f2dc053 Sage Weil  2009-10-06  2912  	 */
> a105f00c Sage Weil  2010-02-15  2913  	for (p = rb_first(&mdsc->snap_realms); p; p = rb_next(p)) {
> a105f00c Sage Weil  2010-02-15  2914  		struct ceph_snap_realm *realm =
> a105f00c Sage Weil  2010-02-15  2915  			rb_entry(p, struct ceph_snap_realm, node);
> 93cea5be Sage Weil  2009-12-23  2916  		struct ceph_mds_snaprealm_reconnect sr_rec;
> 2f2dc053 Sage Weil  2009-10-06  2917  
> 2f2dc053 Sage Weil  2009-10-06  2918  		dout(" adding snap realm %llx seq %lld parent %llx\n",
> 2f2dc053 Sage Weil  2009-10-06  2919  		     realm->ino, realm->seq, realm->parent_ino);
> 93cea5be Sage Weil  2009-12-23  2920  		sr_rec.ino = cpu_to_le64(realm->ino);
> 93cea5be Sage Weil  2009-12-23  2921  		sr_rec.seq = cpu_to_le64(realm->seq);
> 93cea5be Sage Weil  2009-12-23  2922  		sr_rec.parent = cpu_to_le64(realm->parent_ino);
> 93cea5be Sage Weil  2009-12-23  2923  		err = ceph_pagelist_append(pagelist, &sr_rec, sizeof(sr_rec));
> 93cea5be Sage Weil  2009-12-23  2924  		if (err)
> 93cea5be Sage Weil  2009-12-23  2925  			goto fail;
> 2f2dc053 Sage Weil  2009-10-06  2926  	}
> 2f2dc053 Sage Weil  2009-10-06  2927  
> 20cb34ae Sage Weil  2010-05-12  2928  	if (recon_state.flock)
> 20cb34ae Sage Weil  2010-05-12  2929  		reply->hdr.version = cpu_to_le16(2);
> 44c99757 Yan, Zheng 2013-09-22  2930  
> 44c99757 Yan, Zheng 2013-09-22  2931  	/* raced with cap release? */
> 44c99757 Yan, Zheng 2013-09-22  2932  	if (s_nr_caps != recon_state.nr_caps) {
> 44c99757 Yan, Zheng 2013-09-22  2933  		struct page *page = list_first_entry(&pagelist->head,
> 44c99757 Yan, Zheng 2013-09-22  2934  						     struct page, lru);
> 44c99757 Yan, Zheng 2013-09-22  2935  		__le32 *addr = kmap_atomic(page);
> 44c99757 Yan, Zheng 2013-09-22  2936  		*addr = cpu_to_le32(recon_state.nr_caps);
> 44c99757 Yan, Zheng 2013-09-22  2937  		kunmap_atomic(addr);
> 44c99757 Yan, Zheng 2013-09-22  2938  	}
> 44c99757 Yan, Zheng 2013-09-22  2939  
> 93cea5be Sage Weil  2009-12-23  2940  	reply->hdr.data_len = cpu_to_le32(pagelist->length);
> 90af3602 Alex Elder 2013-04-05  2941  	ceph_msg_data_add_pagelist(reply, pagelist);
> 2f2dc053 Sage Weil  2009-10-06  2942  	ceph_con_send(&session->s_con, reply);
> 2f2dc053 Sage Weil  2009-10-06  2943  
> 9abf82b8 Sage Weil  2010-05-10  2944  	mutex_unlock(&session->s_mutex);
> 9abf82b8 Sage Weil  2010-05-10  2945  
> 9abf82b8 Sage Weil  2010-05-10  2946  	mutex_lock(&mdsc->mutex);
> 2f2dc053 Sage Weil  2009-10-06  2947  	__wake_requests(mdsc, &session->s_waiting);
> 9abf82b8 Sage Weil  2010-05-10  2948  	mutex_unlock(&mdsc->mutex);
> 2f2dc053 Sage Weil  2009-10-06  2949  
> 9abf82b8 Sage Weil  2010-05-10  2950  	up_read(&mdsc->snap_rwsem);
> 2f2dc053 Sage Weil  2009-10-06  2951  	return;
> 2f2dc053 Sage Weil  2009-10-06  2952  
> 93cea5be Sage Weil  2009-12-23  2953  fail:
> 2f2dc053 Sage Weil  2009-10-06  2954  	ceph_msg_put(reply);
> 9abf82b8 Sage Weil  2010-05-10  2955  	up_read(&mdsc->snap_rwsem);
> 9abf82b8 Sage Weil  2010-05-10  2956  	mutex_unlock(&session->s_mutex);
> 93cea5be Sage Weil  2009-12-23  2957  fail_nomsg:
> 93cea5be Sage Weil  2009-12-23  2958  	ceph_pagelist_release(pagelist);
> 93cea5be Sage Weil  2009-12-23  2959  fail_nopagelist:
> 9abf82b8 Sage Weil  2010-05-10  2960  	pr_err("error %d preparing reconnect for mds%d\n", err, mds);
> 9abf82b8 Sage Weil  2010-05-10 @2961  	return;
> 2f2dc053 Sage Weil  2009-10-06  2962  }
> 2f2dc053 Sage Weil  2009-10-06  2963  
> 2f2dc053 Sage Weil  2009-10-06  2964  
> 
> :::::: The code at line 2865 was first introduced by commit
> :::::: 99a9c273b94a087f8feaec6c5ffbe3205a2dbe51 ceph: handle race between cap reconnect and cap release
> 
> :::::: TO: Yan, Zheng <zheng.z.yan@intel.com>
> :::::: CC: Sage Weil <sage@inktank.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
