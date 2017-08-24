From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 24 Aug 2017 23:32:45 +0000 (UTC)
Message-ID: <599f621d26386_2107449314459ab@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:46287 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753203AbdHXXdR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 24 Aug 2017 19:33:17 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id Feb2PTktRAaqOgRHBmvx2Q
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 23:32:45.193 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

6 new defect(s) introduced to ceph found with Coverity Scan.
12 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 6 of 6 defect(s)


** CID 1416843:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_user.cc: 2784 in RGWUserMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()


________________________________________________________________________________________________________
*** CID 1416843:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_user.cc: 2784 in RGWUserMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()
2778     
2779         info->store = store;
2780     
2781         int ret = store->list_raw_objects_init(store->get_zone_params().user_uid_pool, marker,
2782                                                &info->ctx);
2783         if (ret < 0) {
>>>     CID 1416843:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "info" going out of scope leaks the storage it points to.
2784           return ret;
2785         }
2786     
2787         *phandle = (void *)info;
2788     
2789         return 0;

** CID 1416844:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_bucket.cc: 2173 in RGWBucketMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()


________________________________________________________________________________________________________
*** CID 1416844:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_bucket.cc: 2173 in RGWBucketMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()
2167     
2168         info->store = store;
2169     
2170         int ret = store->list_raw_objects_init(store->get_zone_params().domain_root, marker,
2171                                                &info->ctx);
2172         if (ret < 0) {
>>>     CID 1416844:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "info" going out of scope leaks the storage it points to.
2173           return ret;
2174         }
2175         *phandle = (void *)info;
2176     
2177         return 0;
2178       }

** CID 1416845:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1800 in LibCephFS_ClearSetuid_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1416845:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/test/libcephfs/test.cc: 1800 in LibCephFS_ClearSetuid_Test::TestBody()()
1794       gid_t gids[] = {65533,65532};
1795       UserPerm *altcred = ceph_userperm_new(u, g, sizeof gids / sizeof gids[0], gids);
1796       stx.stx_uid = u;
1797       stx.stx_gid = g;
1798       mode_t m = S_ISGID|S_ISUID|S_IRUSR|S_IWUSR;
1799       stx.stx_mode = m;
>>>     CID 1416845:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "altcred" going out of scope leaks the storage it points to.
1800       ASSERT_EQ(ceph_ll_setattr(cmount, in, &stx, CEPH_STATX_MODE|CEPH_SETATTR_UID|CEPH_SETATTR_GID, rootcred), 0);
1801       ASSERT_EQ(ceph_ll_getattr(cmount, in, &stx, CEPH_STATX_MODE, 0, altcred), 0);
1802       ASSERT_EQ(stx.stx_mode&(mode_t)ALLPERMS, m);
1803       /* not dropped without exe bit */
1804       stx.stx_gid = gids[0];
1805       ASSERT_EQ(ceph_ll_setattr(cmount, in, &stx, CEPH_SETATTR_GID, altcred), 0);

** CID 1416846:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1416846:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/rgw/rgw_lc.h: 121 in LCFilter::encode(ceph::buffer::list &) const()
115     
116       bool has_prefix() const {
117         return !prefix.empty();
118       }
119     
120       void encode(bufferlist& bl) const {
>>>     CID 1416846:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
121         ENCODE_START(1, 1, bl);
122         ::encode(prefix, bl);
123         ENCODE_FINISH(bl);
124       }
125       void decode(bufferlist::iterator& bl) {
126         DECODE_START(1, bl);

** CID 1416847:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_bucket.cc: 2372 in RGWBucketInstanceMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()


________________________________________________________________________________________________________
*** CID 1416847:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_bucket.cc: 2372 in RGWBucketInstanceMetadataHandler::list_keys_init(RGWRados *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, void **)()
2366     
2367         info->store = store;
2368     
2369         int ret = store->list_raw_objects_init(store->get_zone_params().domain_root, marker,
2370                                                &info->ctx);
2371         if (ret < 0) {
>>>     CID 1416847:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "info" going out of scope leaks the storage it points to.
2372           return ret;
2373         }
2374         *phandle = (void *)info;
2375     
2376         return 0;
2377       }

** CID 1416848:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1416848:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/cls/rbd/cls_rbd_types.cc: 483 in cls::rbd::MirrorImageMap::encode(ceph::buffer::list &) const()
477       f->dump_string("name", name);
478       f->dump_unsigned("deletion_time", deletion_time);
479       f->dump_unsigned("deferment_end_time", deferment_end_time);
480     }
481     
482     void MirrorImageMap::encode(bufferlist &bl) const {
>>>     CID 1416848:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
483       ENCODE_START(1, 1, bl);
484       ::encode(instance_id, bl);
485       ::encode(data, bl);
486       ENCODE_FINISH(bl);
487     }
488     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EQm6rBqKg8-2FsDqYEpgI93AYqOQn4O6V04lngznPYTIMZ9xBRhpQPyTctZvUpAg8y9GZi1DEQF9Tu8ZRbf4UdcjKz6oZOgPO15wc22nGtImZ2czH5ToVczqo-2B-2F0q0A4BnPKroB6mJErwXesJ9ipOV0UuJNU72riJGvHHJOoXxKFzE5qMHlyptCStlkrN-2BJy4T8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EQm6rBqKg8-2FsDqYEpgI93AYqOQn4O6V04lngznPYTIMWz2wcwl3HkoIfwUBbRRCx-2FgkDxXEgkFcChT9fQJXE-2FSwAgvO-2Bbm-2BFrdV6oik-2FNHro0ZbbPK6DLwURVx9TpPhaoaaJ64E7u9OmhV0NYiCqQX38yUePqVLrF10RTO39hYxUfUx8MBKxA8XG38QAe7AkU-3D

