From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [ceph-client:testing 3/5] fs/ceph/mds_client.c:2921:9-15: ERROR:
 reference preceded by free on line 2915 (fwd)
Date: Mon, 11 Sep 2017 15:09:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709111509060.28604@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:5780 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbdIKNK1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Sep 2017 09:10:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, kbuild-all@01.org

Hello,

Is an execution path possible from line 2915 to line 2921?

julia

---------- Forwarded message ----------
Date: Mon, 11 Sep 2017 21:06:00 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [ceph-client:testing 3/5] fs/ceph/mds_client.c:2921:9-15: ERROR:
    reference preceded by free on line 2915

CC: kbuild-all@01.org
CC: ceph-devel@vger.kernel.org
TO: "Yan, Zheng" <zyan@redhat.com>

tree:   https://github.com/ceph/ceph-client.git testing
head:   f127eb48b967ff7ce1723da3934bb5c36cd45cbb
commit: 949d09c2e0d789ab126f3685fe7693a242b793f9 [3/5] ceph: optimize flock encoding during reconnect
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago

>> fs/ceph/mds_client.c:2921:9-15: ERROR: reference preceded by free on line 2915

# https://github.com/ceph/ceph-client/commit/949d09c2e0d789ab126f3685fe7693a242b793f9
git remote add ceph-client https://github.com/ceph/ceph-client.git
git remote update ceph-client
git checkout 949d09c2e0d789ab126f3685fe7693a242b793f9
vim +2921 fs/ceph/mds_client.c

2f2dc05340 Sage Weil    2009-10-06  2820
2f2dc05340 Sage Weil    2009-10-06  2821  /*
2f2dc05340 Sage Weil    2009-10-06  2822   * Encode information about a cap for a reconnect with the MDS.
2f2dc05340 Sage Weil    2009-10-06  2823   */
2f2dc05340 Sage Weil    2009-10-06  2824  static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
2f2dc05340 Sage Weil    2009-10-06  2825  			  void *arg)
2f2dc05340 Sage Weil    2009-10-06  2826  {
20cb34ae9e Sage Weil    2010-05-12  2827  	union {
20cb34ae9e Sage Weil    2010-05-12  2828  		struct ceph_mds_cap_reconnect v2;
20cb34ae9e Sage Weil    2010-05-12  2829  		struct ceph_mds_cap_reconnect_v1 v1;
20cb34ae9e Sage Weil    2010-05-12  2830  	} rec;
2f2dc05340 Sage Weil    2009-10-06  2831  	struct ceph_inode_info *ci;
20cb34ae9e Sage Weil    2010-05-12  2832  	struct ceph_reconnect_state *recon_state = arg;
20cb34ae9e Sage Weil    2010-05-12  2833  	struct ceph_pagelist *pagelist = recon_state->pagelist;
2f2dc05340 Sage Weil    2009-10-06  2834  	char *path;
2f2dc05340 Sage Weil    2009-10-06  2835  	int pathlen, err;
2f2dc05340 Sage Weil    2009-10-06  2836  	u64 pathbase;
3469ed0d14 Yan, Zheng   2016-07-05  2837  	u64 snap_follows;
2f2dc05340 Sage Weil    2009-10-06  2838  	struct dentry *dentry;
2f2dc05340 Sage Weil    2009-10-06  2839
2f2dc05340 Sage Weil    2009-10-06  2840  	ci = cap->ci;
2f2dc05340 Sage Weil    2009-10-06  2841
2f2dc05340 Sage Weil    2009-10-06  2842  	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
2f2dc05340 Sage Weil    2009-10-06  2843  	     inode, ceph_vinop(inode), cap, cap->cap_id,
2f2dc05340 Sage Weil    2009-10-06  2844  	     ceph_cap_string(cap->issued));
93cea5bebf Sage Weil    2009-12-23  2845  	err = ceph_pagelist_encode_64(pagelist, ceph_ino(inode));
93cea5bebf Sage Weil    2009-12-23  2846  	if (err)
93cea5bebf Sage Weil    2009-12-23  2847  		return err;
2f2dc05340 Sage Weil    2009-10-06  2848
2f2dc05340 Sage Weil    2009-10-06  2849  	dentry = d_find_alias(inode);
2f2dc05340 Sage Weil    2009-10-06  2850  	if (dentry) {
2f2dc05340 Sage Weil    2009-10-06  2851  		path = ceph_mdsc_build_path(dentry, &pathlen, &pathbase, 0);
2f2dc05340 Sage Weil    2009-10-06  2852  		if (IS_ERR(path)) {
2f2dc05340 Sage Weil    2009-10-06  2853  			err = PTR_ERR(path);
e072f8aa35 Sage Weil    2010-08-26  2854  			goto out_dput;
2f2dc05340 Sage Weil    2009-10-06  2855  		}
2f2dc05340 Sage Weil    2009-10-06  2856  	} else {
2f2dc05340 Sage Weil    2009-10-06  2857  		path = NULL;
2f2dc05340 Sage Weil    2009-10-06  2858  		pathlen = 0;
4eacd4cb3a Ilya Dryomov 2016-08-09  2859  		pathbase = 0;
2f2dc05340 Sage Weil    2009-10-06  2860  	}
2f2dc05340 Sage Weil    2009-10-06  2861
be655596b3 Sage Weil    2011-11-30  2862  	spin_lock(&ci->i_ceph_lock);
2f2dc05340 Sage Weil    2009-10-06  2863  	cap->seq = 0;        /* reset cap seq */
2f2dc05340 Sage Weil    2009-10-06  2864  	cap->issue_seq = 0;  /* and issue_seq */
667ca05cd9 Yan, Zheng   2013-05-31  2865  	cap->mseq = 0;       /* and migrate_seq */
99a9c273b9 Yan, Zheng   2013-09-22  2866  	cap->cap_gen = cap->session->s_cap_gen;
20cb34ae9e Sage Weil    2010-05-12  2867
121f22a19a Yan, Zheng   2016-07-04  2868  	if (recon_state->msg_version >= 2) {
20cb34ae9e Sage Weil    2010-05-12  2869  		rec.v2.cap_id = cpu_to_le64(cap->cap_id);
20cb34ae9e Sage Weil    2010-05-12  2870  		rec.v2.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
20cb34ae9e Sage Weil    2010-05-12  2871  		rec.v2.issued = cpu_to_le32(cap->issued);
20cb34ae9e Sage Weil    2010-05-12  2872  		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
20cb34ae9e Sage Weil    2010-05-12  2873  		rec.v2.pathbase = cpu_to_le64(pathbase);
20cb34ae9e Sage Weil    2010-05-12  2874  		rec.v2.flock_len = 0;
20cb34ae9e Sage Weil    2010-05-12  2875  	} else {
20cb34ae9e Sage Weil    2010-05-12  2876  		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
20cb34ae9e Sage Weil    2010-05-12  2877  		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
20cb34ae9e Sage Weil    2010-05-12  2878  		rec.v1.issued = cpu_to_le32(cap->issued);
20cb34ae9e Sage Weil    2010-05-12  2879  		rec.v1.size = cpu_to_le64(inode->i_size);
20cb34ae9e Sage Weil    2010-05-12  2880  		ceph_encode_timespec(&rec.v1.mtime, &inode->i_mtime);
20cb34ae9e Sage Weil    2010-05-12  2881  		ceph_encode_timespec(&rec.v1.atime, &inode->i_atime);
20cb34ae9e Sage Weil    2010-05-12  2882  		rec.v1.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
20cb34ae9e Sage Weil    2010-05-12  2883  		rec.v1.pathbase = cpu_to_le64(pathbase);
20cb34ae9e Sage Weil    2010-05-12  2884  	}
3469ed0d14 Yan, Zheng   2016-07-05  2885
3469ed0d14 Yan, Zheng   2016-07-05  2886  	if (list_empty(&ci->i_cap_snaps)) {
92776fd2c2 Yan, Zheng   2017-08-16  2887  		snap_follows = ci->i_head_snapc ? ci->i_head_snapc->seq : 0;
3469ed0d14 Yan, Zheng   2016-07-05  2888  	} else {
3469ed0d14 Yan, Zheng   2016-07-05  2889  		struct ceph_cap_snap *capsnap =
3469ed0d14 Yan, Zheng   2016-07-05  2890  			list_first_entry(&ci->i_cap_snaps,
3469ed0d14 Yan, Zheng   2016-07-05  2891  					 struct ceph_cap_snap, ci_item);
3469ed0d14 Yan, Zheng   2016-07-05  2892  		snap_follows = capsnap->follows;
20cb34ae9e Sage Weil    2010-05-12  2893  	}
be655596b3 Sage Weil    2011-11-30  2894  	spin_unlock(&ci->i_ceph_lock);
2f2dc05340 Sage Weil    2009-10-06  2895
121f22a19a Yan, Zheng   2016-07-04  2896  	if (recon_state->msg_version >= 2) {
40819f6fb2 Greg Farnum  2010-08-02  2897  		int num_fcntl_locks, num_flock_locks;
949d09c2e0 Yan, Zheng   2017-09-11  2898  		struct ceph_filelock *flocks = NULL;
121f22a19a Yan, Zheng   2016-07-04  2899  		size_t struct_len, total_len = 0;
121f22a19a Yan, Zheng   2016-07-04  2900  		u8 struct_v = 0;
40819f6fb2 Greg Farnum  2010-08-02  2901
39be95e9c8 Jim Schutt   2013-05-15  2902  encode_again:
39be95e9c8 Jim Schutt   2013-05-15  2903  		ceph_count_locks(inode, &num_fcntl_locks, &num_flock_locks);
949d09c2e0 Yan, Zheng   2017-09-11  2904  		if (num_fcntl_locks + num_flock_locks > 0) {
39be95e9c8 Jim Schutt   2013-05-15  2905  			flocks = kmalloc((num_fcntl_locks + num_flock_locks) *
39be95e9c8 Jim Schutt   2013-05-15  2906  					 sizeof(struct ceph_filelock), GFP_NOFS);
39be95e9c8 Jim Schutt   2013-05-15  2907  			if (!flocks) {
39be95e9c8 Jim Schutt   2013-05-15  2908  				err = -ENOMEM;
39be95e9c8 Jim Schutt   2013-05-15  2909  				goto out_free;
39be95e9c8 Jim Schutt   2013-05-15  2910  			}
39be95e9c8 Jim Schutt   2013-05-15  2911  			err = ceph_encode_locks_to_buffer(inode, flocks,
39be95e9c8 Jim Schutt   2013-05-15  2912  							  num_fcntl_locks,
39be95e9c8 Jim Schutt   2013-05-15  2913  							  num_flock_locks);
39be95e9c8 Jim Schutt   2013-05-15  2914  			if (err) {
39be95e9c8 Jim Schutt   2013-05-15 @2915  				kfree(flocks);
39be95e9c8 Jim Schutt   2013-05-15  2916  				if (err == -ENOSPC)
39be95e9c8 Jim Schutt   2013-05-15  2917  					goto encode_again;
39be95e9c8 Jim Schutt   2013-05-15  2918  				goto out_free;
39be95e9c8 Jim Schutt   2013-05-15  2919  			}
949d09c2e0 Yan, Zheng   2017-09-11  2920  		} else {
949d09c2e0 Yan, Zheng   2017-09-11 @2921  			kfree(flocks);
949d09c2e0 Yan, Zheng   2017-09-11  2922  			flocks = NULL;
949d09c2e0 Yan, Zheng   2017-09-11  2923  		}
121f22a19a Yan, Zheng   2016-07-04  2924
121f22a19a Yan, Zheng   2016-07-04  2925  		if (recon_state->msg_version >= 3) {
121f22a19a Yan, Zheng   2016-07-04  2926  			/* version, compat_version and struct_len */
121f22a19a Yan, Zheng   2016-07-04  2927  			total_len = 2 * sizeof(u8) + sizeof(u32);
3469ed0d14 Yan, Zheng   2016-07-05  2928  			struct_v = 2;
121f22a19a Yan, Zheng   2016-07-04  2929  		}
39be95e9c8 Jim Schutt   2013-05-15  2930  		/*
39be95e9c8 Jim Schutt   2013-05-15  2931  		 * number of encoded locks is stable, so copy to pagelist
39be95e9c8 Jim Schutt   2013-05-15  2932  		 */
121f22a19a Yan, Zheng   2016-07-04  2933  		struct_len = 2 * sizeof(u32) +
40819f6fb2 Greg Farnum  2010-08-02  2934  			    (num_fcntl_locks + num_flock_locks) *
121f22a19a Yan, Zheng   2016-07-04  2935  			    sizeof(struct ceph_filelock);
121f22a19a Yan, Zheng   2016-07-04  2936  		rec.v2.flock_len = cpu_to_le32(struct_len);
121f22a19a Yan, Zheng   2016-07-04  2937
121f22a19a Yan, Zheng   2016-07-04  2938  		struct_len += sizeof(rec.v2);
121f22a19a Yan, Zheng   2016-07-04  2939  		struct_len += sizeof(u32) + pathlen;
121f22a19a Yan, Zheng   2016-07-04  2940
3469ed0d14 Yan, Zheng   2016-07-05  2941  		if (struct_v >= 2)
3469ed0d14 Yan, Zheng   2016-07-05  2942  			struct_len += sizeof(u64); /* snap_follows */
3469ed0d14 Yan, Zheng   2016-07-05  2943
121f22a19a Yan, Zheng   2016-07-04  2944  		total_len += struct_len;
121f22a19a Yan, Zheng   2016-07-04  2945  		err = ceph_pagelist_reserve(pagelist, total_len);
121f22a19a Yan, Zheng   2016-07-04  2946
121f22a19a Yan, Zheng   2016-07-04  2947  		if (!err) {
121f22a19a Yan, Zheng   2016-07-04  2948  			if (recon_state->msg_version >= 3) {
121f22a19a Yan, Zheng   2016-07-04  2949  				ceph_pagelist_encode_8(pagelist, struct_v);
121f22a19a Yan, Zheng   2016-07-04  2950  				ceph_pagelist_encode_8(pagelist, 1);
121f22a19a Yan, Zheng   2016-07-04  2951  				ceph_pagelist_encode_32(pagelist, struct_len);
121f22a19a Yan, Zheng   2016-07-04  2952  			}
121f22a19a Yan, Zheng   2016-07-04  2953  			ceph_pagelist_encode_string(pagelist, path, pathlen);
121f22a19a Yan, Zheng   2016-07-04  2954  			ceph_pagelist_append(pagelist, &rec, sizeof(rec.v2));
121f22a19a Yan, Zheng   2016-07-04  2955  			ceph_locks_to_pagelist(flocks, pagelist,
40819f6fb2 Greg Farnum  2010-08-02  2956  					       num_fcntl_locks,
40819f6fb2 Greg Farnum  2010-08-02  2957  					       num_flock_locks);
3469ed0d14 Yan, Zheng   2016-07-05  2958  			if (struct_v >= 2)
3469ed0d14 Yan, Zheng   2016-07-05  2959  				ceph_pagelist_encode_64(pagelist, snap_follows);
121f22a19a Yan, Zheng   2016-07-04  2960  		}
39be95e9c8 Jim Schutt   2013-05-15  2961  		kfree(flocks);
3612abbd5d Sage Weil    2010-09-07  2962  	} else {
121f22a19a Yan, Zheng   2016-07-04  2963  		size_t size = sizeof(u32) + pathlen + sizeof(rec.v1);
121f22a19a Yan, Zheng   2016-07-04  2964  		err = ceph_pagelist_reserve(pagelist, size);
121f22a19a Yan, Zheng   2016-07-04  2965  		if (!err) {
121f22a19a Yan, Zheng   2016-07-04  2966  			ceph_pagelist_encode_string(pagelist, path, pathlen);
121f22a19a Yan, Zheng   2016-07-04  2967  			ceph_pagelist_append(pagelist, &rec, sizeof(rec.v1));
121f22a19a Yan, Zheng   2016-07-04  2968  		}
40819f6fb2 Greg Farnum  2010-08-02  2969  	}
44c99757fa Yan, Zheng   2013-09-22  2970
44c99757fa Yan, Zheng   2013-09-22  2971  	recon_state->nr_caps++;
e072f8aa35 Sage Weil    2010-08-26  2972  out_free:
2f2dc05340 Sage Weil    2009-10-06  2973  	kfree(path);
e072f8aa35 Sage Weil    2010-08-26  2974  out_dput:
2f2dc05340 Sage Weil    2009-10-06  2975  	dput(dentry);
93cea5bebf Sage Weil    2009-12-23  2976  	return err;
2f2dc05340 Sage Weil    2009-10-06  2977  }
2f2dc05340 Sage Weil    2009-10-06  2978

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
