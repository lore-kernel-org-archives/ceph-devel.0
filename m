From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Mon, 3 Mar 2014 14:23:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403031423270.17314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-3714084-1393885411=:17314"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34372 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbaCCWXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 17:23:32 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 18F2B8004F
	for <ceph-devel@vger.kernel.org>; Mon,  3 Mar 2014 14:23:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D64518004F
	for <ceph-devel@vger.kernel.org>; Mon,  3 Mar 2014 14:23:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-3714084-1393885411=:17314
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-3714084-1393885411=:17314
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1403031423271.17314@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id E9EF181376
	for <sage@cobra.newdream.net>; Mon,  3 Mar 2014 10:52:15 -0800 (PST)
Received: by destro.newdream.net (Postfix)
	id DBA3C120AD7; Mon,  3 Mar 2014 10:52:15 -0800 (PST)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdccah.dreamhost.com
	[208.97.132.207])
	by destro.newdream.net (Postfix) with ESMTP id D98E5120ACB
	for <sage@newdream.net>; Mon,  3 Mar 2014 10:52:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	34433A0C105
	for <sage@newdream.net>; Mon,  3 Mar 2014 10:52:14 -0800 (PST)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from connor.dreamhost.com ([208.97.132.205])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id H+1k+uDI1FiS for <sage@newdream.net>;
	Mon,  3 Mar 2014 10:52:14 -0800 (PST)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id 655EA2CA800B
	for <sage@newdream.net>; Mon,  3 Mar 2014 10:52:13 -0800 (PST)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Mon, 3 Mar 2014 10:51:33 -0800
Date: Mon, 03 Mar 2014 10:51:03 -0800
From: scan-admin@coverity.com
Message-ID: <5314cf17686c2_5c916390704162e@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2014 18:51:33.0371 (UTC)
	FILETIME=[98BFC4B0:01CF3711]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 15 of 15 defect(s)


** CID 1188299:  Data race condition  (MISSING_LOCK)
/mds/MDSUtility.cc: 142 in MDSUtility::handle_mds_map(MMDSMap *)()

** CID 717359:  Uninitialized scalar field  (UNINIT_CTOR)
/rgw/rgw_common.cc: 161 in req_state::req_state(CephContext *, RGWEnv *)()

** CID 1188131:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/common/histogram.h: 97 in pow2_hist_t::get_position_micro(int, unsigned long *, unsigned long *)()

** CID 716921:  Dereference after null check  (FORWARD_NULL)
/mds/MDCache.cc: 6950 in MDCache::handle_cache_expire(MCacheExpire *)()

** CID 1188134:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ReplicatedBackend.cc: 428 in RPGTransaction::append(PGBackend::PGTransaction *)()

** CID 1188135:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ReplicatedBackend.cc: 494 in ReplicatedBackend::submit_transaction(const hobject_t &, const eversion_t &, PGBackend::PGTransaction *, const eversion_t &, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t>> &, Context *, Context *, Context *, unsigned long, osd_reqid_t, std::tr1::shared_ptr<OpRequest>)()

** CID 716990:  Dereference null return value  (NULL_RETURNS)
/mds/MDCache.cc: 10098 in MDCache::handle_discover(MDiscover *)()

** CID 1135931:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()

** CID 1135933:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()

** CID 1188126:  Unchecked return value  (CHECKED_RETURN)
/test/objectstore/store_test.cc: 564 in SyntheticWorkloadState::stat()()

** CID 1188145:  Resource leak  (RESOURCE_LEAK)
/osd/ReplicatedPG.cc: 5231 in ReplicatedPG::fill_in_copy_get(ReplicatedPG::OpContext *, ceph::buffer::list::iterator &, OSDOp &, std::tr1::shared_ptr<ObjectContext> &, bool)()

** CID 1188156:  Resource leak  (RESOURCE_LEAK)
/test/librados/c_write_operations.cc: 131 in LibRadosCWriteOps_Exec_Test::TestBody()()
/test/librados/c_write_operations.cc: 134 in LibRadosCWriteOps_Exec_Test::TestBody()()
/test/librados/c_write_operations.cc: 136 in LibRadosCWriteOps_Exec_Test::TestBody()()
/test/librados/c_write_operations.cc: 138 in LibRadosCWriteOps_Exec_Test::TestBody()()
/test/librados/c_write_operations.cc: 139 in LibRadosCWriteOps_Exec_Test::TestBody()()

** CID 1160848:  Uninitialized scalar variable  (UNINIT)
/osdc/Objecter.cc: 1519 in Objecter::recalc_op_target(Objecter::Op *)()

** CID 1030132:  Uninitialized scalar variable  (UNINIT)
/mon/PGMonitor.cc: 1979 in PGMonitor::dump_stuck_pg_stats(std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, ceph::Formatter *, int, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &) const()
/mon/PGMonitor.cc: 1979 in PGMonitor::dump_stuck_pg_stats(std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, ceph::Formatter *, int, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &) const()

** CID 1135932:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()


________________________________________________________________________________________________________
*** CID 1188299:  Data race condition  (MISSING_LOCK)
/mds/MDSUtility.cc: 142 in MDSUtility::handle_mds_map(MMDSMap *)()
136     
137     void MDSUtility::handle_mds_map(MMDSMap* m)
138     {
139       mdsmap->decode(m->get_encoded());
140       if (waiting_for_mds_map) {
141         waiting_for_mds_map->complete(0);
>>>     CID 1188299:  Data race condition  (MISSING_LOCK)
>>>     Accessing "this->waiting_for_mds_map" ("MDSUtility.waiting_for_mds_map") requires the "Mutex._m" lock.
142         waiting_for_mds_map = NULL;
143       }
144     }
145     
146     
147     bool MDSUtility::ms_get_authorizer(int dest_type, AuthAuthorizer **authorizer,

________________________________________________________________________________________________________
*** CID 717359:  Uninitialized scalar field  (UNINIT_CTOR)
/rgw/rgw_common.cc: 161 in req_state::req_state(CephContext *, RGWEnv *)()
155       length = NULL;
156       copy_source = NULL;
157       http_auth = NULL;
158       local_source = false;
159     
160       obj_ctx = NULL;
>>>     CID 717359:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "bucket_exists" is not initialized in this constructor nor in any functions that it calls.
161     }
162     
163     req_state::~req_state() {
164       delete formatter;
165       delete bucket_acl;
166       delete object_acl;

________________________________________________________________________________________________________
*** CID 1188131:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/common/histogram.h: 97 in pow2_hist_t::get_position_micro(int, unsigned long *, unsigned long *)()
91           if (i <= bin)
92     	upper_sum += h[i];
93           if (i < bin)
94     	lower_sum += h[i];
95           total += h[i];
96         }
>>>     CID 1188131:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "lower_sum * 1000000UL / total", division by expression "total" which may be zero has undefined behavior.
97         *lower = lower_sum * 1000000 / total;
98         *upper = upper_sum * 1000000 / total;
99         return 0;
100       }
101     
102       void add(const pow2_hist_t& o) {

________________________________________________________________________________________________________
*** CID 716921:  Dereference after null check  (FORWARD_NULL)
/mds/MDCache.cc: 6950 in MDCache::handle_cache_expire(MCacheExpire *)()
6944           for (map<pair<string,snapid_t>,uint32_t>::iterator p = pd->second.begin();
6945     	   p != pd->second.end();
6946     	   ++p) {
6947     	unsigned nonce = p->second;
6948     	CDentry *dn;
6949     	
>>>     CID 716921:  Dereference after null check  (FORWARD_NULL)
>>>     Comparing "dir" to null implies that "dir" might be null.
6950     	if (dir) {
6951     	  dn = dir->lookup(p->first.first, p->first.second);
6952     	} else {
6953     	  // which dirfrag for this dentry?
6954     	  CDir *dir = diri->get_dirfrag(diri->pick_dirfrag(p->first.first));
6955     	  assert(dir); 

________________________________________________________________________________________________________
*** CID 1188134:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ReplicatedBackend.cc: 428 in RPGTransaction::append(PGBackend::PGTransaction *)()
422       }
423     
424       void append(
425         PGTransaction *_to_append
426         ) {
427         RPGTransaction *to_append = dynamic_cast<RPGTransaction*>(_to_append);
>>>     CID 1188134:  Unchecked dynamic_cast  (FORWARD_NULL)
>>>     Dereferencing null pointer "to_append".
428         t->append(*(to_append->t));
429         for (set<hobject_t>::iterator i = to_append->temp_added.begin();
430     	 i != to_append->temp_added.end();
431     	 ++i) {
432           temp_cleared.erase(*i);
433           temp_added.insert(*i);

________________________________________________________________________________________________________
*** CID 1188135:  Unchecked dynamic_cast  (FORWARD_NULL)
/osd/ReplicatedBackend.cc: 494 in ReplicatedBackend::submit_transaction(const hobject_t &, const eversion_t &, PGBackend::PGTransaction *, const eversion_t &, std::vector<pg_log_entry_t, std::allocator<pg_log_entry_t>> &, Context *, Context *, Context *, unsigned long, osd_reqid_t, std::tr1::shared_ptr<OpRequest>)()
488       Context *on_all_acked,
489       Context *on_all_commit,
490       tid_t tid,
491       osd_reqid_t reqid,
492       OpRequestRef orig_op)
493     {
>>>     CID 1188135:  Unchecked dynamic_cast  (FORWARD_NULL)
>>>     Assigning: "t" = "dynamic_cast <RPGTransaction *>(_t)".
494       RPGTransaction *t = dynamic_cast<RPGTransaction*>(_t);
495       ObjectStore::Transaction *op_t = t->get_transaction();
496     
497       assert(t->get_temp_added().size() <= 1);
498       assert(t->get_temp_cleared().size() <= 1);
499     

________________________________________________________________________________________________________
*** CID 716990:  Dereference null return value  (NULL_RETURNS)
/mds/MDCache.cc: 10098 in MDCache::handle_discover(MDiscover *)()
10092         // wants root
10093         dout(7) << "handle_discover from mds." << from
10094     	    << " wants base + " << dis->get_want().get_path()
10095     	    << " snap " << snapid
10096     	    << dendl;
10097     
>>>     CID 716990:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "cur" = null return value from "MDCache::get_inode(inodeno_t, snapid_t)".
10098         cur = get_inode(dis->get_base_ino());
10099     
10100         // add root
10101         reply->starts_with = MDiscoverReply::INODE;
10102         replicate_inode(cur, from, reply->trace);
10103         dout(10) << "added base " << *cur << dendl;

________________________________________________________________________________________________________
*** CID 1135931:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()
1733       Context *ondisk;
1734       Context *onreadable_sync;
1735       ObjectStore::Transaction::collect_contexts(
1736         tls, &onreadable, &ondisk, &onreadable_sync);
1737       if (g_conf->filestore_blackhole) {
1738         dout(0) << "queue_transactions filestore_blackhole = TRUE, dropping transaction" << dendl;
>>>     CID 1135931:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ondisk" going out of scope leaks the storage it points to.
1739         return 0;
1740       }
1741     
1742       // set up the sequencer
1743       OpSequencer *osr;
1744       if (!posr)

________________________________________________________________________________________________________
*** CID 1135933:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()
1733       Context *ondisk;
1734       Context *onreadable_sync;
1735       ObjectStore::Transaction::collect_contexts(
1736         tls, &onreadable, &ondisk, &onreadable_sync);
1737       if (g_conf->filestore_blackhole) {
1738         dout(0) << "queue_transactions filestore_blackhole = TRUE, dropping transaction" << dendl;
>>>     CID 1135933:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "onreadable_sync" going out of scope leaks the storage it points to.
1739         return 0;
1740       }
1741     
1742       // set up the sequencer
1743       OpSequencer *osr;
1744       if (!posr)

________________________________________________________________________________________________________
*** CID 1188126:  Unchecked return value  (CHECKED_RETURN)
/test/objectstore/store_test.cc: 564 in SyntheticWorkloadState::stat()()
558           hoid = get_uniform_random_object();
559           in_flight_objects.insert(hoid);
560           available_objects.erase(hoid);
561           ++in_flight;
562         }
563         struct stat buf;
>>>     CID 1188126:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "this->store->stat(coll_t(this->cid), hoid, &buf, false)".
564         store->stat(cid, hoid, &buf);
565         ASSERT_TRUE(buf.st_size == contents[hoid].length());
566         {
567           Mutex::Locker locker(lock);
568           --in_flight;
569           cond.Signal();

________________________________________________________________________________________________________
*** CID 1188145:  Resource leak  (RESOURCE_LEAK)
/osd/ReplicatedPG.cc: 5231 in ReplicatedPG::fill_in_copy_get(ReplicatedPG::OpContext *, ceph::buffer::list::iterator &, OSDOp &, std::tr1::shared_ptr<ObjectContext> &, bool)()
5225       if (!cursor.attr_complete) {
5226         result = getattrs_maybe_cache(
5227           ctx->obc,
5228           &out_attrs,
5229           true);
5230         if (result < 0)
>>>     CID 1188145:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cb" going out of scope leaks the storage it points to.
5231           return result;
5232         cursor.attr_complete = true;
5233         dout(20) << " got attrs" << dendl;
5234       }
5235     
5236       int64_t left = out_max - osd_op.outdata.length();

________________________________________________________________________________________________________
*** CID 1188156:  Resource leak  (RESOURCE_LEAK)
/test/librados/c_write_operations.cc: 131 in LibRadosCWriteOps_Exec_Test::TestBody()()
125     
126       int rval = 1;
127       rados_write_op_t op = rados_create_write_op();
128       rados_write_op_exec(op, "hello", "record_hello", "test", 4, &rval);
129       ASSERT_EQ(0, rados_write_op_operate(op, ioctx, "test", NULL, 0));
130       rados_release_write_op(op);
>>>     CID 1188156:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
131       ASSERT_EQ(0, rval);
132     
133       char hi[100];
134       ASSERT_EQ(12, rados_read(ioctx, "test", hi, 100, 0));
135       hi[12] = '\0';
136       ASSERT_EQ(0, strcmp("Hello, test!", hi));
137     
138       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
/test/librados/c_write_operations.cc: 134 in LibRadosCWriteOps_Exec_Test::TestBody()()
128       rados_write_op_exec(op, "hello", "record_hello", "test", 4, &rval);
129       ASSERT_EQ(0, rados_write_op_operate(op, ioctx, "test", NULL, 0));
130       rados_release_write_op(op);
131       ASSERT_EQ(0, rval);
132     
133       char hi[100];
>>>     CID 1188156:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
134       ASSERT_EQ(12, rados_read(ioctx, "test", hi, 100, 0));
135       hi[12] = '\0';
136       ASSERT_EQ(0, strcmp("Hello, test!", hi));
137     
138       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
/test/librados/c_write_operations.cc: 136 in LibRadosCWriteOps_Exec_Test::TestBody()()
130       rados_release_write_op(op);
131       ASSERT_EQ(0, rval);
132     
133       char hi[100];
134       ASSERT_EQ(12, rados_read(ioctx, "test", hi, 100, 0));
135       hi[12] = '\0';
>>>     CID 1188156:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
136       ASSERT_EQ(0, strcmp("Hello, test!", hi));
137     
138       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
/test/librados/c_write_operations.cc: 138 in LibRadosCWriteOps_Exec_Test::TestBody()()
132     
133       char hi[100];
134       ASSERT_EQ(12, rados_read(ioctx, "test", hi, 100, 0));
135       hi[12] = '\0';
136       ASSERT_EQ(0, strcmp("Hello, test!", hi));
137     
>>>     CID 1188156:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
138       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
/test/librados/c_write_operations.cc: 139 in LibRadosCWriteOps_Exec_Test::TestBody()()
133       char hi[100];
134       ASSERT_EQ(12, rados_read(ioctx, "test", hi, 100, 0));
135       hi[12] = '\0';
136       ASSERT_EQ(0, strcmp("Hello, test!", hi));
137     
138       ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
>>>     CID 1188156:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.

________________________________________________________________________________________________________
*** CID 1160848:  Uninitialized scalar variable  (UNINIT)
/osdc/Objecter.cc: 1519 in Objecter::recalc_op_target(Objecter::Op *)()
1513     	    best = i;
1514     	    best_locality = locality;
1515     	    if (i)
1516     	      op->used_replica = true;
1517     	  }
1518     	}
>>>     CID 1160848:  Uninitialized scalar variable  (UNINIT)
>>>     Using uninitialized value "best".
1519     	assert(best >= 0);
1520     	osd = acting[best];
1521           } else {
1522     	osd = primary;
1523           }
1524           s = get_session(osd);

________________________________________________________________________________________________________
*** CID 1030132:  Uninitialized scalar variable  (UNINIT)
/mon/PGMonitor.cc: 1979 in PGMonitor::dump_stuck_pg_stats(std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, ceph::Formatter *, int, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &) const()
1973     
1974     int PGMonitor::dump_stuck_pg_stats(stringstream &ds,
1975     				   Formatter *f,
1976     				   int threshold,
1977     				   vector<string>& args) const
1978     {
>>>     CID 1030132:  Uninitialized scalar variable  (UNINIT)
>>>     Declaring variable "stuck_type" without initializer.
1979       PGMap::StuckPG stuck_type;
1980       string type = args[0];
1981       if (type == "inactive")
1982         stuck_type = PGMap::STUCK_INACTIVE;
1983       if (type == "unclean")
1984         stuck_type = PGMap::STUCK_UNCLEAN;
/mon/PGMonitor.cc: 1979 in PGMonitor::dump_stuck_pg_stats(std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>> &, ceph::Formatter *, int, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &) const()
1973     
1974     int PGMonitor::dump_stuck_pg_stats(stringstream &ds,
1975     				   Formatter *f,
1976     				   int threshold,
1977     				   vector<string>& args) const
1978     {
>>>     CID 1030132:  Uninitialized scalar variable  (UNINIT)
>>>     Declaring variable "stuck_type" without initializer.
1979       PGMap::StuckPG stuck_type;
1980       string type = args[0];
1981       if (type == "inactive")
1982         stuck_type = PGMap::STUCK_INACTIVE;
1983       if (type == "unclean")
1984         stuck_type = PGMap::STUCK_UNCLEAN;

________________________________________________________________________________________________________
*** CID 1135932:  Resource leak  (RESOURCE_LEAK)
/os/FileStore.cc: 1739 in FileStore::queue_transactions(ObjectStore::Sequencer *, std::list<ObjectStore::Transaction *, std::allocator<ObjectStore::Transaction *>> &, std::tr1::shared_ptr<TrackedOp>, ThreadPool::TPHandle *)()
1733       Context *ondisk;
1734       Context *onreadable_sync;
1735       ObjectStore::Transaction::collect_contexts(
1736         tls, &onreadable, &ondisk, &onreadable_sync);
1737       if (g_conf->filestore_blackhole) {
1738         dout(0) << "queue_transactions filestore_blackhole = TRUE, dropping transaction" << dendl;
>>>     CID 1135932:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "onreadable" going out of scope leaks the storage it points to.
1739         return 0;
1740       }
1741     
1742       // set up the sequencer
1743       OpSequencer *osr;
1744       if (!posr)


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=Overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-3714084-1393885411=:17314--
