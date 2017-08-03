From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 03 Aug 2017 04:57:49 +0000 (UTC)
Message-ID: <5982ad4d1155f_4b203c331878254@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:34087 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751010AbdHCE5u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 00:57:50 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1las1.sendgrid.net (SG) with ESMTP id Mq7N3lTuSrOetiAH7a3png
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 04:57:49.315 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
10 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1409825:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_file.cc: 359 in rgw::RGWLibFS::unlink(rgw::RGWFileHandle *, const char *, unsigned int)()


________________________________________________________________________________________________________
*** CID 1409825:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_file.cc: 359 in rgw::RGWLibFS::unlink(rgw::RGWFileHandle *, const char *, unsigned int)()
353     	rc = req.get_ret();
354           }
355         }
356     
357         /* ENOENT when raced with other s3 gateway */
358         if (! rc || rc == -ENOENT) {
>>>     CID 1409825:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "rgw_fh".
359           rgw_fh->flags |= RGWFileHandle::FLAG_DELETED;
360           fh_cache.remove(rgw_fh->fh.fh_hk.object, rgw_fh,
361     		      RGWFileHandle::FHCache::FLAG_LOCK);
362         }
363     
364         if (! rc) {

** CID 1416109:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/rbd/action/MergeDiff.cc: 404 in rbd::action::merge_diff::do_merge_diff(const char *, const char *, const char *, bool)()


________________________________________________________________________________________________________
*** CID 1416109:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/rbd/action/MergeDiff.cc: 404 in rbd::action::merge_diff::do_merge_diff(const char *, const char *, const char *, bool)()
398         pc.fail();
399         if (pd > 2)
400           unlink(path);
401       } else
402         pc.finish();
403     
>>>     CID 1416109:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "sd" going out of scope leaks the handle.
404       return r;
405     }
406     
407     void get_arguments(po::options_description *positional,
408                        po::options_description *options) {
409       positional->add_options()

** CID 1416110:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 5291 in RGWCompleteMultipart::execute()()


________________________________________________________________________________________________________
*** CID 1416110:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 5291 in RGWCompleteMultipart::execute()()
5285       rados::cls::lock::Lock l("RGWCompleteMultipart");
5286       int max_lock_secs_mp = s->cct->_conf->get_val<int64_t>("rgw_mp_lock_max_time");
5287     
5288       op.assert_exists();
5289       store->obj_to_raw((s->bucket_info).placement_rule, meta_obj, &raw_obj);
5290       store->get_obj_data_pool((s->bucket_info).placement_rule,meta_obj,&meta_pool);
>>>     CID 1416110:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "open_pool_ctx" without checking return value (as is done elsewhere 6 out of 7 times).
5291       store->open_pool_ctx(meta_pool, ioctx);
5292     
5293       const string raw_meta_oid = raw_obj.oid;
5294       utime_t time(max_lock_secs_mp, 0);
5295       l.set_duration(time);
5296       l.lock_exclusive(&op);

** CID 1416111:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1416111:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 4130 in pg_log_dup_t::encode(ceph::buffer::list &) const()
4124     {
4125       return "dup_" + version.get_key_name();
4126     }
4127     
4128     void pg_log_dup_t::encode(bufferlist &bl) const
4129     {
>>>     CID 1416111:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
4130       ENCODE_START(1, 1, bl);
4131       ::encode(reqid, bl);
4132       ::encode(version, bl);
4133       ::encode(user_version, bl);
4134       ::encode(return_code, bl);
4135       ENCODE_FINISH(bl);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E2MSMr71IldpKS7gNpK3ScFTMRw9FJdy3YGvm6G8hLT4zuhKQGcsnyxDVRshe2DgPIF99CKytmrLo-2F1QS-2F3YYgfklaQj6t0LQeovcxfqW3ZFL-2FiohxyZ72SVhn2wOCHIWjhJuKOHtI9FQLMHsv-2BAQegGQMjH3-2BNryhIiNPMO7LHbejiKmc4pF1t9UjJ-2BvsORY-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E2MSMr71IldpKS7gNpK3ScFTMRw9FJdy3YGvm6G8hLT62nAU0lLI8alqgdg4Asf1pI2icXa34bjrY5lZSFxNUhv1BBdMv2SlpESAFi1zTA8VlUV9nOsef-2FKBCXevWn0E-2BrgxzEkb7dbWxiIZGJJlSSqDEBt40UAfUvMTNlIuDVeyZQrTjwi4KdfU2lJKj-2BVOQ-3D

