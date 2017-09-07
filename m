From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 07 Sep 2017 05:08:17 +0000 (UTC)
Message-ID: <59b0d441608c_551c4493144596c@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:6557 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750742AbdIGFIx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Sep 2017 01:08:53 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id 5yj_stdyRSyvUxLpsjdtQA
        for <ceph-devel@vger.kernel.org>; Thu, 07 Sep 2017 05:08:17.066 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

9 new defect(s) introduced to ceph found with Coverity Scan.
25 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 9 of 9 defect(s)


** CID 1417472:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1417472:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 377 in LibCephFS_ConcurrentRecordLocking_Test::TestBody()()
371       const pid_t mypid = getpid();
372       struct ceph_mount_info *cmount;
373       STARTUP_CEPH();
374     
375       char c_file[1024];
376       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417472:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
377       Fh *fh = NULL;
378       Inode *root = NULL, *inode = NULL;
379       struct ceph_statx stx;
380       struct flock lock1;
381       int rc;
382       UserPerm *perms = ceph_mount_perms(cmount);

** CID 1417473:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/client/Client.cc: 12684 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, file_layout_t *, unsigned long, unsigned int)()


________________________________________________________________________________________________________
*** CID 1417473:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/client/Client.cc: 12684 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, file_layout_t *, unsigned long, unsigned int)()
12678       fakesnap.seq = snapseq;
12679     
12680       /* lock just in time */
12681       client_lock.Lock();
12682       if (unmounting) {
12683         client_lock.Unlock();
>>>     CID 1417473:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "onsafe" going out of scope leaks the storage it points to.
12684         return -ENOTCONN;
12685       }
12686     
12687       objecter->write(oid,
12688     		  object_locator_t(layout->pool_id),
12689     		  offset,

** CID 1417474:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1417474:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 520 in LibCephFS_ThreesomeRecordLocking_Test::TestBody()()
514       const pid_t mypid = getpid();
515       struct ceph_mount_info *cmount;
516       STARTUP_CEPH();
517     
518       char c_file[1024];
519       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417474:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
520       Fh *fh = NULL;
521       Inode *root = NULL, *inode = NULL;
522       struct ceph_statx stx;
523       struct flock lock1;
524       int rc;
525       UserPerm *perms = ceph_mount_perms(cmount);

** CID 1417475:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1167 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, const std::vector<int, std::allocator<int>> &, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1417475:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1167 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, const std::vector<int, std::allocator<int>> &, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()
1161     	!all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.is_incomplete() &&
1162     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
1163     	auth_log_shard->second.log_tail) {
1164           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
1165           want[i] = acting[i];
1166         } else if (!restrict_to_up_acting) {
>>>     CID 1417475:  Control flow issues  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
1167           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
1168     	   j != all_info_by_shard[shard_id_t(i)].end();
1169     	   ++j) {
1170     	assert(j->shard == i);
1171     	if (!all_info.find(*j)->second.is_incomplete() &&
1172     	    all_info.find(*j)->second.last_update >=

** CID 1417476:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1417476:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 765 in LibCephFS_DISABLED_InterProcessRecordLocking_Test::TestBody()()
759     TEST(LibCephFS, DISABLED_InterProcessRecordLocking) {
760       PROCESS_SLOW_MS();
761       // Process synchronization
762       char c_file[1024];
763       const pid_t mypid = getpid();
764       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417476:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
765       Fh *fh = NULL;
766       Inode *root = NULL, *inode = NULL;
767       struct ceph_statx stx;
768       struct flock lock1;
769       int rc;
770     

** CID 1417477:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()


________________________________________________________________________________________________________
*** CID 1417477:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 284 in thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
278     
279     /* Locking in different threads */
280     
281     // Used by ConcurrentLocking test
282     static void thread_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
283       struct ceph_mount_info *const cmount = s.cmount;
>>>     CID 1417477:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
284       Fh *fh = NULL;
285       Inode *root = NULL, *inode = NULL;
286       struct ceph_statx stx;
287       struct flock lock1;
288       int rc;
289       struct timespec ts;

** CID 1417478:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1417478:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 927 in LibCephFS_DISABLED_ThreesomeInterProcessRecordLocking_Test::TestBody()()
921     TEST(LibCephFS, DISABLED_ThreesomeInterProcessRecordLocking) {
922       PROCESS_SLOW_MS();
923       // Process synchronization
924       char c_file[1024];
925       const pid_t mypid = getpid();
926       sprintf(c_file, "recordlock_test_%d", mypid);
>>>     CID 1417478:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
927       Fh *fh = NULL;
928       Inode *root = NULL, *inode = NULL;
929       struct ceph_statx stx;
930       struct flock lock1;
931       int rc;
932     

** CID 1417479:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()


________________________________________________________________________________________________________
*** CID 1417479:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 673 in process_ConcurrentRecordLocking(str_ConcurrentRecordLocking &)()
667     static void process_ConcurrentRecordLocking(str_ConcurrentRecordLocking& s) {
668       const pid_t mypid = getpid();
669       PROCESS_SLOW_MS();
670     
671       struct ceph_mount_info *cmount = NULL;
672       struct timespec ts;
>>>     CID 1417479:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
673       Fh *fh = NULL;
674       Inode *root = NULL, *inode = NULL;
675       struct ceph_statx stx;
676       int rc;
677       struct flock lock1;
678     

** CID 1417480:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1417480:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);
/home/brad/working/src/ceph/src/test/libcephfs/recordlock.cc: 81 in LibCephFS_BasicRecordLocking_Test::TestBody()()
75     TEST(LibCephFS, BasicRecordLocking) {
76       struct ceph_mount_info *cmount = NULL;
77       STARTUP_CEPH();
78     
79       char c_file[1024];
80       sprintf(c_file, "recordlock_test_%d", getpid());
>>>     CID 1417480:    (FORWARD_NULL)
>>>     Assigning: "fh" = "NULL".
81       Fh *fh = NULL;
82       Inode *root = NULL, *inode = NULL;
83       struct ceph_statx stx;
84       int rc;
85       struct flock lock1, lock2;
86       UserPerm *perms = ceph_mount_perms(cmount);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HMNw1TEiyfVGuRIB1-2FPbC34TnUzUYP6W8ZSCLjQ5HeNSz4QOW7tMW3EWOoubXLZjfb-2Bi363R5ELhGXJRZ-2F7L6TC64oLs3PHhIS1KdsttJ-2BXkwQJrfHjChN9l4dWVcryKQFuUDS4wN8bUnkHaVRDjEth7QoHQ9LMIcCsG56MPIkSU6Si8CxNxUN4f9aW5OwdYA-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HMNw1TEiyfVGuRIB1-2FPbC34TnUzUYP6W8ZSCLjQ5HeNWoFiQRDrLN-2FFeOj0eSX6bcowlQQ9WuvoGlzOmoDsQumdltAggXiQDrp1Mlt4TL-2BVB-2BMmv-2BUsH69veXp4aovB4TPB5U-2FXaooi-2FvxJe-2Fhpa-2F5D3UGzg-2FoP6H5k4cN5e2gnl94oU0m1-2FM-2Bc945zPW2jm0-3D

