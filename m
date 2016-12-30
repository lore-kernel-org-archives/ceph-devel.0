From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 30 Dec 2016 00:33:50 -0800
Message-ID: <58661bee7a734_604cde333479520@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:18294 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751653AbcL3Idw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Dec 2016 03:33:52 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id rgi8WjZjT7CS-OMW77y8wQ
        for <ceph-devel@vger.kernel.org>; Fri, 30 Dec 2016 08:33:50.542 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

16 new defect(s) introduced to ceph found with Coverity Scan.
12 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 16 of 16 defect(s)


** CID 1213584:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1213584:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 9042 in C_CompleteSplits::finish(int)()
9036           return;
9037         PG::RecoveryCtx rctx = osd->create_context();
9038         for (set<boost::intrusive_ptr<PG> >::iterator i = pgs.begin();
9039     	 i != pgs.end();
9040     	 ++i) {
9041           osd->pg_map_lock.get_write();
>>>     CID 1213584:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "lock" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
9042           (*i)->lock();
9043           osd->add_newly_split_pg(&**i, &rctx);
9044           if (!((*i)->deleting)) {
9045             set<spg_t> to_complete;
9046             to_complete.insert((*i)->info.pgid);
9047             osd->service.complete_split(to_complete);

** CID 1351530:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1351530:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 5117 in OSD::queue_want_up_thru(unsigned int)()
5111     }
5112     
5113     void OSD::queue_want_up_thru(epoch_t want)
5114     {
5115       map_lock.get_read();
5116       epoch_t cur = osdmap->get_up_thru(whoami);
>>>     CID 1351530:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "Locker" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
5117       Mutex::Locker l(mon_report_lock);
5118       if (want > up_thru_wanted) {
5119         dout(10) << "queue_want_up_thru now " << want << " (was " << up_thru_wanted << ")"
5120     	     << ", currently " << cur
5121     	     << dendl;
5122         up_thru_wanted = want;

** CID 1351531:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1351531:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 4820 in OSD::ms_handle_connect(Connection *)()
4814         if (is_preboot()) {
4815           start_boot();
4816         } else if (is_booting()) {
4817           _send_boot();       // resend boot message
4818         } else {
4819           map_lock.get_read();
>>>     CID 1351531:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "Locker" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
4820           Mutex::Locker l2(mon_report_lock);
4821     
4822           utime_t now = ceph_clock_now();
4823           last_mon_report = now;
4824     
4825           // resend everything, it's a new session

** CID 1351532:    (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1351532:    (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 4411 in OSD::tick_without_osd_lock()()
4405       if (is_active() || is_waiting_for_healthy()) {
4406         heartbeat_lock.Lock();
4407         heartbeat_check();
4408         heartbeat_lock.Unlock();
4409     
4410         map_lock.get_read();
>>>     CID 1351532:    (ORDER_REVERSAL)
>>>     Calling "Locker" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
4411         Mutex::Locker l(mon_report_lock);
4412     
4413         // mon report?
4414         bool reset = false;
4415         bool report = false;
4416         utime_t now = ceph_clock_now();
/home/brad/working/src/ceph/src/osd/OSD.cc: 4417 in OSD::tick_without_osd_lock()()
4411         Mutex::Locker l(mon_report_lock);
4412     
4413         // mon report?
4414         bool reset = false;
4415         bool report = false;
4416         utime_t now = ceph_clock_now();
>>>     CID 1351532:    (ORDER_REVERSAL)
>>>     Calling "Lock" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
4417         pg_stat_queue_lock.Lock();
4418         double backoff = stats_ack_timeout / cct->_conf->osd_mon_ack_timeout;
4419         double adjusted_min = cct->_conf->osd_mon_report_interval_min * backoff;
4420         // note: we shouldn't adjust max because it must remain < the
4421         // mon's mon_osd_report_timeout (which defaults to 1.5x our
4422         // value).

** CID 1398195:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.cc: 798 in BitMapAreaIN::BitMapAreaIN(CephContext *, long, long)()


________________________________________________________________________________________________________
*** CID 1398195:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.cc: 798 in BitMapAreaIN::BitMapAreaIN(CephContext *, long, long)()
792     }
793     
794     BitMapAreaIN::BitMapAreaIN(CephContext* cct,int64_t total_blocks,
795     			   int64_t area_idx)
796       : BitMapArea(cct)
797     {
>>>     CID 1398195:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "m_child_list" of "BitMapAreaIN" but the destructor and whatever functions it calls do not free it.
798       init(total_blocks, area_idx, false);
799     }
800     
801     BitMapAreaIN::BitMapAreaIN(CephContext* cct, int64_t total_blocks,
802     			   int64_t area_idx, bool def)
803       : BitMapArea(cct)

** CID 1398196:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.cc: 6537 in OSDService::ScrubJob::ScrubJob(CephContext *, const spg_t &, const utime_t &, double, double, bool)()


________________________________________________________________________________________________________
*** CID 1398196:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.cc: 6537 in OSDService::ScrubJob::ScrubJob(CephContext *, const spg_t &, const utime_t &, double, double, bool)()
6531         double scrub_min_interval = pool_scrub_min_interval > 0 ?
6532           pool_scrub_min_interval : cct->_conf->osd_scrub_min_interval;
6533         double scrub_max_interval = pool_scrub_max_interval > 0 ?
6534           pool_scrub_max_interval : cct->_conf->osd_scrub_max_interval;
6535     
6536         sched_time += scrub_min_interval;
>>>     CID 1398196:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
6537         double r = rand() / (double)RAND_MAX;
6538         sched_time +=
6539           scrub_min_interval * cct->_conf->osd_scrub_interval_randomize_ratio * r;
6540         deadline += scrub_max_interval;
6541       }
6542     }

** CID 1398197:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1398197:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/osd/OSD.cc: 7035 in OSD::_committed_osd_maps(unsigned int, unsigned int, MOSDMap *)()
7029     	  osdmap->is_up(*p) && // in old map
7030     	  newmap->is_down(*p)) {    // but not the new one
7031             if (!waited_for_reservations) {
7032               service.await_reserved_maps();
7033               waited_for_reservations = true;
7034             }
>>>     CID 1398197:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "note_down_osd" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 11).
7035     	note_down_osd(*p);
7036           } else if (*p != whoami &&
7037                     osdmap->is_down(*p) &&
7038                     newmap->is_up(*p)) {
7039             note_up_osd(*p);
7040           }

** CID 1398198:    (TAINTED_SCALAR)


________________________________________________________________________________________________________
*** CID 1398198:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/os/kstore/KStore.cc: 295 in get_object_key(CephContext *, const ghobject_t &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()
289       // sanity check
290       if (true) {
291         ghobject_t t;
292         int r = get_key_object(*key, &t);
293         if (r || t != oid) {
294           derr << "  r " << r << dendl;
>>>     CID 1398198:    (TAINTED_SCALAR)
>>>     Passing tainted variable "key" to a tainted sink.
295           derr << "key " << pretty_binary_string(*key) << dendl;
296           derr << "oid " << oid << dendl;
297           derr << "  t " << t << dendl;
298           assert(t == oid);
299         }
300       }
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 328 in get_object_key(CephContext *, const ghobject_t &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()
322       // sanity check
323       if (true) {
324         ghobject_t t;
325         int r = get_key_object(*key, &t);
326         if (r || t != oid) {
327           derr << "  r " << r << dendl;
>>>     CID 1398198:    (TAINTED_SCALAR)
>>>     Passing tainted variable "key" to a tainted sink.
328           derr << "key " << pretty_binary_string(*key) << dendl;
329           derr << "oid " << oid << dendl;
330           derr << "  t " << t << dendl;
331           assert(r == 0 && t == oid);
332         }
333       }

** CID 1398199:  Insecure data handling  (TAINTED_STRING)
/home/brad/working/src/ceph/src/test/admin_socket.cc: 113 in AdminSocket_SendTooLongRequest_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1398199:  Insecure data handling  (TAINTED_STRING)
/home/brad/working/src/ceph/src/test/admin_socket.cc: 113 in AdminSocket_SendTooLongRequest_Test::TestBody()()
107     
108     TEST(AdminSocket, SendTooLongRequest) {
109       std::unique_ptr<AdminSocket>
110           asokc(new AdminSocket(g_ceph_context));
111       AdminSocketTest asoct(asokc.get());
112       ASSERT_EQ(true, asoct.shutdown());
>>>     CID 1398199:  Insecure data handling  (TAINTED_STRING)
>>>     Call to function "basic_string" with tainted argument "get_rand_socket_path()" transitively taints "<temporary>". [Note: The source code implementation of the function has been overridden by a builtin model.]
113       ASSERT_EQ(true, asoct.init(get_rand_socket_path()));
114       AdminSocketClient client(get_rand_socket_path());
115       string version;
116       string request(16384, 'a');
117       //if admin_socket cannot handle it, segfault will happened.
118       ASSERT_NE("", client.do_request(request, &version));

** CID 1398200:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/kstore/KStore.h: 87 in KStore::Onode::Onode(CephContext *, const ghobject_t &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1398200:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/kstore/KStore.h: 87 in KStore::Onode::Onode(CephContext *, const ghobject_t &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
81           : cct(cct),
82     	nref(0),
83     	oid(o),
84     	key(k),
85     	dirty(false),
86     	exists(false) {
>>>     CID 1398200:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "tail_offset" is not initialized in this constructor nor in any functions that it calls.
87         }
88     
89         void flush();
90         void get() {
91           ++nref;
92         }

** CID 1398201:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 78 in PGLSFilter::PGLSFilter()()


________________________________________________________________________________________________________
*** CID 1398201:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 78 in PGLSFilter::PGLSFilter()()
72     #include <errno.h>
73     
74     MEMPOOL_DEFINE_OBJECT_FACTORY(PrimaryLogPG, replicatedpg, osd);
75     
76     PGLSFilter::PGLSFilter()
77     {
>>>     CID 1398201:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cct" is not initialized in this constructor nor in any functions that it calls.
78     }
79     
80     PGLSFilter::~PGLSFilter()
81     {
82     }
83     

** CID 1398202:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.h: 846 in BlueStore::Cache::Cache(CephContext *)()


________________________________________________________________________________________________________
*** CID 1398202:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.h: 846 in BlueStore::Cache::Cache(CephContext *)()
840         std::atomic<uint64_t> num_blobs = {0};
841     
842         size_t last_trim_seq = 0;
843     
844         static Cache *create(CephContext* cct, string type, PerfCounters *logger);
845     
>>>     CID 1398202:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "logger" is not initialized in this constructor nor in any functions that it calls.
846         Cache(CephContext* cct) : cct(cct) {}
847         virtual ~Cache() {}
848     
849         virtual void _add_onode(OnodeRef& o, int level) = 0;
850         virtual void _rm_onode(OnodeRef& o) = 0;
851         virtual void _touch_onode(OnodeRef& o) = 0;

** CID 1398203:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/OSD.h: 641 in OSDService::ScrubJob::ScrubJob()()


________________________________________________________________________________________________________
*** CID 1398203:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/OSD.h: 641 in OSDService::ScrubJob::ScrubJob()()
635         spg_t pgid;
636         /// a time scheduled for scrub. but the scrub could be delayed if system
637         /// load is too high or it fails to fall in the scrub hours
638         utime_t sched_time;
639         /// the hard upper bound of scrub time
640         utime_t deadline;
>>>     CID 1398203:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cct" is not initialized in this constructor nor in any functions that it calls.
641         ScrubJob() {}
642         explicit ScrubJob(CephContext* cct, const spg_t& pg,
643     		      const utime_t& timestamp,
644     		      double pool_scrub_min_interval = 0,
645     		      double pool_scrub_max_interval = 0, bool must = true);
646         /// order the jobs by sched_time

** CID 1398204:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.cc: 746 in BitMapAreaIN::BitMapAreaIN(CephContext *)()


________________________________________________________________________________________________________
*** CID 1398204:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.cc: 746 in BitMapAreaIN::BitMapAreaIN(CephContext *)()
740      * BitMapArea Leaf and Internal
741      */
742     BitMapAreaIN::BitMapAreaIN(CephContext* cct)
743       : BitMapArea(cct)
744     {
745       // nothing
>>>     CID 1398204:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_child_list" is not initialized in this constructor nor in any functions that it calls.
746     }
747     
748     void BitMapAreaIN::init_common(int64_t total_blocks, int64_t area_idx, bool def)
749     {
750       m_area_index = area_idx;
751       m_total_blocks = total_blocks;

** CID 1398205:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitmapFreelistManager.cc: 58 in BitmapFreelistManager::BitmapFreelistManager(CephContext *, KeyValueDB *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>)()


________________________________________________________________________________________________________
*** CID 1398205:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitmapFreelistManager.cc: 58 in BitmapFreelistManager::BitmapFreelistManager(CephContext *, KeyValueDB *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
52     					     string bitmap_prefix)
53       : FreelistManager(cct),
54         meta_prefix(meta_prefix),
55         bitmap_prefix(bitmap_prefix),
56         kvdb(db)
57     {
>>>     CID 1398205:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "enumerate_bl_pos" is not initialized in this constructor nor in any functions that it calls.
58     }
59     
60     int BitmapFreelistManager::create(uint64_t new_size, KeyValueDB::Transaction txn)
61     {
62       bytes_per_block = cct->_conf->bdev_block_size;
63       assert(ISP2(bytes_per_block));

** CID 1398206:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.h: 266 in BitMapArea::BitMapArea(CephContext *)()


________________________________________________________________________________________________________
*** CID 1398206:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BitAllocator.h: 266 in BitMapArea::BitMapArea(CephContext *)()
260     
261       int64_t child_count();
262       int64_t get_index();
263       int64_t get_level();
264       bmap_area_type_t get_type();
265       virtual void dump_state(int& count) = 0;
>>>     CID 1398206:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_type" is not initialized in this constructor nor in any functions that it calls.
266       BitMapArea(CephContext* cct) : cct(cct) {}
267       virtual ~BitMapArea() { }
268     };
269     
270     class BitMapAreaList {
271     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GeYWMm9JqZsVcnFzXBYjl53tnd5pIjk0s2bDmef6l12PA7mZ7O9u5r3WS-2BU3nibfzbSSWxRXF3CZD1O4IZ9CZYtv-2FsavwISp6O0FsgdG8snJ7me-2B4d1eZSdqn9S7HthXiVLJWoX8OsRvQXeAdbQ4m7DDH85yQviZceNEMjx5tcUyh597nVhmeB8FEkQQfeZwA-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GeYWMm9JqZsVcnFzXBYjl53tnd5pIjk0s2bDmef6l12AlBVifsKopcZFxig-2FYB1QcaVQn30ZzwOE-2B-2FOCWPo9qtbNW2ALu-2FHmoJvjmXc1ndtDwk7gPI5BLVislPd0cPn9BQisiica1dsFH8g5Ijtrdge4V2iuP6rtUhoIcfCkbrsbyXZ-2FABfRva5R8z5Gw7vh0-3D

