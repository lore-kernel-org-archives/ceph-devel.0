From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 12 Mar 2016 10:04:51 -0800
Message-ID: <56e45a4378cef_92cabd3309444b@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:51638 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcCLSFB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Mar 2016 13:05:01 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 751A21E1E6C
	for <ceph-devel@vger.kernel.org>; Sat, 12 Mar 2016 19:04:52 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

15 new defect(s) introduced to ceph found with Coverity Scan.
9 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 15 of 15 defect(s)


** CID 1355567:  Error handling issues  (CHECKED_RETURN)
/os/filestore/FileStore.cc: 3249 in FileStore::_write(const coll_t &, const ghobject_t &, unsigned long, unsigned long, const ceph::buffer::list &, unsigned int)()


________________________________________________________________________________________________________
*** CID 1355567:  Error handling issues  (CHECKED_RETURN)
/os/filestore/FileStore.cc: 3249 in FileStore::_write(const coll_t &, const ghobject_t &, unsigned long, unsigned long, const ceph::buffer::list &, unsigned int)()
3243         int rc = backend->_crc_update_write(**fd, offset, len, bl);
3244         assert(rc >= 0);
3245       }
3246      
3247       if (replaying || m_disable_wbthrottle) {
3248         if (fadvise_flags & CEPH_OSD_OP_FLAG_FADVISE_DONTNEED) {
>>>     CID 1355567:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(**fd, 0L, 0L, 4)" without checking return value. This library function may fail and return an error code.
3249             posix_fadvise(**fd, 0, 0, POSIX_FADV_DONTNEED);
3250         }
3251       } else {
3252         wbthrottle.queue_wb(fd, oid, offset, len,
3253             fadvise_flags & CEPH_OSD_OP_FLAG_FADVISE_DONTNEED);
3254       }

** CID 1355568:  Error handling issues  (CHECKED_RETURN)
/global/global_init.cc: 186 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *, bool)()


________________________________________________________________________________________________________
*** CID 1355568:  Error handling issues  (CHECKED_RETURN)
/global/global_init.cc: 186 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *, bool)()
180         if (g_conf->setgroup.length() > 0) {
181           gid = atoi(g_conf->setgroup.c_str());
182           if (!gid) {
183     	char buf[4096];
184     	struct group gr;
185     	struct group *g = 0;
>>>     CID 1355568:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "getgrnam_r(g_conf->setgroup.c_str(), &gr, buf, 4096UL, &g)" without checking return value. This library function may fail and return an error code.
186     	getgrnam_r(g_conf->setgroup.c_str(), &gr, buf, sizeof(buf), &g);
187     	if (!g) {
188     	  cerr << "unable to look up group '" << g_conf->setgroup << "'"
189     	       << std::endl;
190     	  exit(1);
191     	}

** CID 1355569:  Incorrect expression  (COPY_PASTE_ERROR)
/osd/OSDMap.cc: 3021 in OSDMap::summarize_mapping_stats(OSDMap*, const std::set<long, std::less<long>, std::allocator<long>> *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, ceph::Formatter *) const()


________________________________________________________________________________________________________
*** CID 1355569:  Incorrect expression  (COPY_PASTE_ERROR)
/osd/OSDMap.cc: 3021 in OSDMap::summarize_mapping_stats(OSDMap*, const std::set<long, std::less<long>, std::allocator<long>> *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, ceph::Formatter *) const()
3015         if (f) {
3016           f->dump_unsigned("max_osd", max);
3017           f->dump_unsigned("max_osd_pgs", max_base_pg);
3018           if (newmap)
3019     	f->dump_unsigned("new_max_osd_pgs", max_new_pg);
3020         } else {
>>>     CID 1355569:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "min" in "(ss << "max osd.") << min" looks like a copy-paste error.
3021           ss << "max osd." << min << " with " << max_base_pg;
3022           if (newmap)
3023     	ss << " -> " << max_new_pg;
3024           ss << " pgs (" << (float)max_base_pg / avg_pg;
3025           if (newmap)
3026     	ss << " -> " << (float)max_new_pg / avg_pg;

** CID 1355570:  Security best practices violations  (DC.WEAK_CRYPTO)
/osd/OSD.h: 793 in OSDService::promote_throttle()()


________________________________________________________________________________________________________
*** CID 1355570:  Security best practices violations  (DC.WEAK_CRYPTO)
/osd/OSD.h: 793 in OSDService::promote_throttle()()
787       utime_t last_recalibrate;
788       unsigned long promote_max_objects, promote_max_bytes;
789     
790       bool promote_throttle() {
791         // NOTE: lockless!  we rely on the probability being a single word.
792         promote_counter.attempt();
>>>     CID 1355570:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
793         if ((unsigned)rand() % 1000 > promote_probability_millis.read())
794           return true;  // yes throttle (no promote)
795         if (promote_max_objects &&
796     	promote_counter.objects.read() > promote_max_objects)
797           return true;  // yes throttle
798         if (promote_max_bytes &&

** CID 1355571:  Control flow issues  (DEADCODE)
/mon/MDSMonitor.cc: 618 in MDSMonitor::prepare_beacon(std::shared_ptr<MonOpRequest>)()


________________________________________________________________________________________________________
*** CID 1355571:  Control flow issues  (DEADCODE)
/mon/MDSMonitor.cc: 618 in MDSMonitor::prepare_beacon(std::shared_ptr<MonOpRequest>)()
612           } else if (m->get_standby_for_rank() >= 0) {
613             // TODO get this from MDS message
614             // >>
615             fs_cluster_id_t target_ns = FS_CLUSTER_ID_NONE;
616             // <<
617     
>>>     CID 1355571:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "info.standby_for_ns" inside this statement: "target_role.mds_role_t(((ta...".
618             mds_role_t target_role = {
619               target_ns == FS_CLUSTER_ID_NONE ?
620                 pending_fsmap.legacy_client_fscid : info.standby_for_ns,
621               m->get_standby_for_rank()};
622     
623             if (target_role.fscid != FS_CLUSTER_ID_NONE) {

** CID 1355572:    (INFINITE_LOOP)
/tools/cephfs/Resetter.cc: 57 in Resetter::reset(mds_role_t)()
/tools/cephfs/Resetter.cc: 95 in Resetter::reset(mds_role_t)()


________________________________________________________________________________________________________
*** CID 1355572:    (INFINITE_LOOP)
/tools/cephfs/Resetter.cc: 57 in Resetter::reset(mds_role_t)()
51     
52       lock.Lock();
53       journaler.recover(new C_SafeCond(&mylock, &cond, &done, &r));
54       lock.Unlock();
55     
56       mylock.Lock();
>>>     CID 1355572:    (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
57       while (!done)
58         cond.Wait(mylock);
59       mylock.Unlock();
60     
61       if (r != 0) {
62         if (r == -ENOENT) {
/tools/cephfs/Resetter.cc: 95 in Resetter::reset(mds_role_t)()
89     
90       cout << "writing journal head" << std::endl;
91       journaler.write_head(new C_SafeCond(&mylock, &cond, &done, &r));
92       lock.Unlock();
93     
94       mylock.Lock();
>>>     CID 1355572:    (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
95       while (!done)
96         cond.Wait(mylock);
97       mylock.Unlock();
98         
99       lock.Lock();
100       if (r != 0) {

** CID 1355573:  Concurrent data access violations  (MISSING_LOCK)
/tools/cephfs/MDSUtility.cc: 150 in MDSUtility::handle_mds_map(MFSMap *)()


________________________________________________________________________________________________________
*** CID 1355573:  Concurrent data access violations  (MISSING_LOCK)
/tools/cephfs/MDSUtility.cc: 150 in MDSUtility::handle_mds_map(MFSMap *)()
144     
145     void MDSUtility::handle_mds_map(MFSMap* m)
146     {
147       fsmap->decode(m->get_encoded());
148       if (waiting_for_mds_map) {
149         waiting_for_mds_map->complete(0);
>>>     CID 1355573:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->waiting_for_mds_map" without holding lock "Mutex._m". Elsewhere, "MDSUtility.waiting_for_mds_map" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
150         waiting_for_mds_map = NULL;
151       }
152     }
153     
154     
155     bool MDSUtility::ms_get_authorizer(int dest_type, AuthAuthorizer **authorizer,

** CID 1355574:  Error handling issues  (NEGATIVE_RETURNS)
/log/Log.cc: 144 in ceph::log::Log::reopen_log_file()()


________________________________________________________________________________________________________
*** CID 1355574:  Error handling issues  (NEGATIVE_RETURNS)
/log/Log.cc: 144 in ceph::log::Log::reopen_log_file()()
138       m_flush_mutex_holder = pthread_self();
139       if (m_fd >= 0)
140         VOID_TEMP_FAILURE_RETRY(::close(m_fd));
141       if (m_log_file.length()) {
142         m_fd = ::open(m_log_file.c_str(), O_CREAT|O_WRONLY|O_APPEND, 0644);
143         if (m_uid || m_gid) {
>>>     CID 1355574:  Error handling issues  (NEGATIVE_RETURNS)
>>>     "this->m_fd" is passed to a parameter that cannot be negative.
144           int r = ::fchown(m_fd, m_uid, m_gid);
145           if (r < 0) {
146     	r = -errno;
147     	cerr << "failed to chown " << m_log_file << ": " << cpp_strerror(r)
148     	     << std::endl;
149           }

** CID 1355575:  Null pointer dereferences  (NULL_RETURNS)
/mds/ScrubStack.cc: 148 in ScrubStack::scrub_dir_inode(CInode *, bool *, bool *, bool *)()


________________________________________________________________________________________________________
*** CID 1355575:  Null pointer dereferences  (NULL_RETURNS)
/mds/ScrubStack.cc: 148 in ScrubStack::scrub_dir_inode(CInode *, bool *, bool *, bool *)()
142         dout(20) << __func__ << " iterating over " << scrubbing_frags.size()
143           << " scrubbing frags" << dendl;
144         for (list<frag_t>::iterator i = scrubbing_frags.begin();
145     	i != scrubbing_frags.end();
146     	++i) {
147           // turn frags into CDir *
>>>     CID 1355575:  Null pointer dereferences  (NULL_RETURNS)
>>>     Assigning: "dir" = null return value from "get_dirfrag".
148           CDir *dir = in->get_dirfrag(*i);
149           scrubbing_cdirs.push_back(dir);
150           dout(25) << __func__ << " got CDir " << *dir << " presently scrubbing" << dendl;
151         }
152     
153     

** CID 1355576:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1355576:  Memory - corruptions  (OVERRUN)
/mds/FSMap.cc: 216 in FSMap::encode(ceph::buffer::list &, unsigned long) const()
210         fs->mds_map.get_health(summary, detail);
211       }
212     }
213     
214     void FSMap::encode(bufferlist& bl, uint64_t features) const
215     {
>>>     CID 1355576:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
216       ENCODE_START(6, 6, bl);
217       ::encode(epoch, bl);
218       ::encode(next_filesystem_id, bl);
219       ::encode(legacy_client_fscid, bl);
220       ::encode(compat, bl);
221       ::encode(enable_multiple, bl);

** CID 1355577:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1355577:  Memory - corruptions  (OVERRUN)
/mds/FSMap.cc: 363 in Filesystem::encode(ceph::buffer::list &) const()
357       DECODE_FINISH(p);
358     }
359     
360     
361     void Filesystem::encode(bufferlist& bl) const
362     {
>>>     CID 1355577:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
363       ENCODE_START(1, 1, bl);
364       ::encode(fscid, bl);
365       bufferlist mdsmap_bl;
366       mds_map.encode(mdsmap_bl, CEPH_FEATURE_PGID64 | CEPH_FEATURE_MDSENC);
367       ::encode(mdsmap_bl, bl);
368       ENCODE_FINISH(bl);

** CID 1355578:  Performance inefficiencies  (PASS_BY_VALUE)
/mds/FSMap.h: 339 in FSMap::update_compat(CompatSet)()


________________________________________________________________________________________________________
*** CID 1355578:  Performance inefficiencies  (PASS_BY_VALUE)
/mds/FSMap.h: 339 in FSMap::update_compat(CompatSet)()
333     
334       /**
335        * A daemon has told us it's compat, and it's too new
336        * for the one we had previously.  Impose the new one
337        * on all filesystems.
338        */
>>>     CID 1355578:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter c of type "CompatSet" (size 168 bytes) by value.
339       void update_compat(CompatSet c)
340       {
341         // We could do something more complicated here to enable
342         // different filesystems to be served by different MDS versions,
343         // but this is a lot simpler because it doesn't require us to
344         // track the compat versions for standby daemons.

** CID 1355579:    (RESOURCE_LEAK)
/test/libcephfs/test.cc: 1342 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1338 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1335 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1330 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1329 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1328 in LibCephFS_OpenNoClose_Test::TestBody()()
/test/libcephfs/test.cc: 1327 in LibCephFS_OpenNoClose_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1355579:    (RESOURCE_LEAK)
/test/libcephfs/test.cc: 1342 in LibCephFS_OpenNoClose_Test::TestBody()()
1336     
1337       struct ceph_dir_result *ls_dir = NULL;
1338       ASSERT_EQ(ceph_opendir(cmount, str_buf, &ls_dir), 0);
1339     
1340       sprintf(str_buf, "open_no_close_file%d", mypid);
1341       int fd = ceph_open(cmount, str_buf, O_RDONLY|O_CREAT, 0666);
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1342       ASSERT_LT(0, fd);
1343     
1344       // shutdown should force close opened file/dir
1345       ceph_shutdown(cmount);
/test/libcephfs/test.cc: 1338 in LibCephFS_OpenNoClose_Test::TestBody()()
1332       pid_t mypid = getpid();
1333       char str_buf[256];
1334       sprintf(str_buf, "open_no_close_dir%d", mypid);
1335       ASSERT_EQ(0, ceph_mkdirs(cmount, str_buf, 0777));
1336     
1337       struct ceph_dir_result *ls_dir = NULL;
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1338       ASSERT_EQ(ceph_opendir(cmount, str_buf, &ls_dir), 0);
1339     
1340       sprintf(str_buf, "open_no_close_file%d", mypid);
1341       int fd = ceph_open(cmount, str_buf, O_RDONLY|O_CREAT, 0666);
1342       ASSERT_LT(0, fd);
1343     
1344       // shutdown should force close opened file/dir
1345       ceph_shutdown(cmount);
/test/libcephfs/test.cc: 1335 in LibCephFS_OpenNoClose_Test::TestBody()()
1329       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1330       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1331     
1332       pid_t mypid = getpid();
1333       char str_buf[256];
1334       sprintf(str_buf, "open_no_close_dir%d", mypid);
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1335       ASSERT_EQ(0, ceph_mkdirs(cmount, str_buf, 0777));
1336     
1337       struct ceph_dir_result *ls_dir = NULL;
1338       ASSERT_EQ(ceph_opendir(cmount, str_buf, &ls_dir), 0);
1339     
1340       sprintf(str_buf, "open_no_close_file%d", mypid);
/test/libcephfs/test.cc: 1330 in LibCephFS_OpenNoClose_Test::TestBody()()
1324     
1325     TEST(LibCephFS, OpenNoClose) {
1326       struct ceph_mount_info *cmount;
1327       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1328       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1329       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1330       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1331     
1332       pid_t mypid = getpid();
1333       char str_buf[256];
1334       sprintf(str_buf, "open_no_close_dir%d", mypid);
1335       ASSERT_EQ(0, ceph_mkdirs(cmount, str_buf, 0777));
/test/libcephfs/test.cc: 1329 in LibCephFS_OpenNoClose_Test::TestBody()()
1323     }
1324     
1325     TEST(LibCephFS, OpenNoClose) {
1326       struct ceph_mount_info *cmount;
1327       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1328       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1329       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1330       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1331     
1332       pid_t mypid = getpid();
1333       char str_buf[256];
1334       sprintf(str_buf, "open_no_close_dir%d", mypid);
/test/libcephfs/test.cc: 1328 in LibCephFS_OpenNoClose_Test::TestBody()()
1322       ceph_shutdown(cmount);
1323     }
1324     
1325     TEST(LibCephFS, OpenNoClose) {
1326       struct ceph_mount_info *cmount;
1327       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1328       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1329       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1330       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1331     
1332       pid_t mypid = getpid();
1333       char str_buf[256];
/test/libcephfs/test.cc: 1327 in LibCephFS_OpenNoClose_Test::TestBody()()
1321     
1322       ceph_shutdown(cmount);
1323     }
1324     
1325     TEST(LibCephFS, OpenNoClose) {
1326       struct ceph_mount_info *cmount;
>>>     CID 1355579:    (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
1327       ASSERT_EQ(ceph_create(&cmount, NULL), 0);
1328       ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
1329       ASSERT_EQ(0, ceph_conf_parse_env(cmount, NULL));
1330       ASSERT_EQ(ceph_mount(cmount, "/"), 0);
1331     
1332       pid_t mypid = getpid();

** CID 1355580:  Resource leaks  (RESOURCE_LEAK)
/global/global_init.cc: 286 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *, bool)()


________________________________________________________________________________________________________
*** CID 1355580:  Resource leaks  (RESOURCE_LEAK)
/global/global_init.cc: 286 in global_init(std::vector<const char *, std::allocator<const char *>> *, std::vector<const char *, std::allocator<const char *>> &, unsigned int, code_environment_t, int, const char *, bool)()
280       // test leak checking
281       if (g_conf->debug_deliberately_leak_memory) {
282         derr << "deliberately leaking some memory" << dendl;
283         char *s = new char[1234567];
284         (void)s;
285         // cppcheck-suppress memleak
>>>     CID 1355580:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "s" going out of scope leaks the storage it points to.
286       }
287     
288       if (code_env == CODE_ENVIRONMENT_DAEMON && !(flags & CINIT_FLAG_NO_DAEMON_ACTIONS))
289         output_ceph_version();
290     }
291     

** CID 1355581:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_sync.h: 433 in RGWShardCollectCR::RGWShardCollectCR(CephContext *, int)()


________________________________________________________________________________________________________
*** CID 1355581:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_sync.h: 433 in RGWShardCollectCR::RGWShardCollectCR(CephContext *, int)()
427       int status;
428     
429     public:
430       RGWShardCollectCR(CephContext *_cct, int _max_concurrent) : RGWCoroutine(_cct),
431                                                                  current_running(0),
432                                                                  max_concurrent(_max_concurrent),
>>>     CID 1355581:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cur_shard" is not initialized in this constructor nor in any functions that it calls.
433                                                                  status(0) {}
434     
435       virtual bool spawn_next() = 0;
436       int operate();
437     };
438     
439     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

