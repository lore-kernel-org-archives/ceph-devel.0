From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 17 May 2017 18:44:10 -0700
Message-ID: <591cfc6aef5d5_91072f330517b4@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:55283 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754053AbdERBoM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 17 May 2017 21:44:12 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id P6V5sUt2Rsi1Je_mbnPlGA
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 01:44:11.012 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

14 new defect(s) introduced to ceph found with Coverity Scan.
957 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 14 of 14 defect(s)


** CID 1220854:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1165 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1220854:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1165 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()
1159     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
1160     	auth_log_shard->second.log_tail) {
1161           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
1162           want[i] = acting[i];
1163           ++usable;
1164         } else if (!restrict_to_up_acting) {
>>>     CID 1220854:  Control flow issues  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
1165           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
1166     	   j != all_info_by_shard[shard_id_t(i)].end();
1167     	   ++j) {
1168     	assert(j->shard == i);
1169     	if (!all_info.find(*j)->second.is_incomplete() &&
1170     	    all_info.find(*j)->second.last_update >=

** CID 1351454:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 1980 in object_stat_sum_t::decode(ceph::buffer::list::iterator &)()


________________________________________________________________________________________________________
*** CID 1351454:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/osd/osd_types.cc: 1980 in object_stat_sum_t::decode(ceph::buffer::list::iterator &)()
1974         ::decode(num_flush_mode_low, bl);
1975         ::decode(num_evict_mode_some, bl);
1976         ::decode(num_evict_mode_full, bl);
1977         ::decode(num_objects_pinned, bl);
1978         ::decode(num_objects_missing, bl);
1979         if (struct_v >= 16) {
>>>     CID 1351454:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "decode(this->num_legacy_sna...".
1980           ::decode(num_legacy_snapsets, bl);
1981         } else {
1982           num_legacy_snapsets = num_object_clones;  // upper bound
1983         }
1984       }
1985       DECODE_FINISH(bl);

** CID 1409692:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 1876 in BlueStore::OldExtent::create(boost::intrusive_ptr<BlueStore::Collection>, unsigned int, unsigned int, unsigned int, boost::intrusive_ptr<BlueStore::Blob> &)()


________________________________________________________________________________________________________
*** CID 1409692:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 1876 in BlueStore::OldExtent::create(boost::intrusive_ptr<BlueStore::Collection>, unsigned int, unsigned int, unsigned int, boost::intrusive_ptr<BlueStore::Blob> &)()
1870     BlueStore::OldExtent* BlueStore::OldExtent::create(CollectionRef c,
1871     						   uint32_t lo,
1872     						   uint32_t o,
1873     						   uint32_t l,
1874     						   BlobRef& b) {
1875       OldExtent* oe = new OldExtent(lo, o, l, b);
>>>     CID 1409692:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "put_ref" without checking return value (as is done elsewhere 31 out of 38 times).
1876       b->put_ref(c.get(), o, l, &(oe->r));
1877       oe->blob_empty = b->get_referenced_bytes() == 0;
1878       return oe;
1879     }
1880     
1881     // ExtentMap

** CID 1409693:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/Migrator.cc: 833 in Migrator::export_dir(CDir *, int)()


________________________________________________________________________________________________________
*** CID 1409693:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/Migrator.cc: 833 in Migrator::export_dir(CDir *, int)()
827     	CInode *in = dnl->get_inode();
828     	if (in->is_dir())
829     	  in->get_nested_dirfrags(ls);
830           }
831         }
832         if (ls.size() > 0) {
>>>     CID 1409693:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
833           int n = rand() % ls.size();
834           auto p = ls.begin();
835           while (n--) ++p;
836           CDir *bd = *p;
837           if (!(bd->is_frozen() || bd->is_freezing())) {
838     	assert(bd->is_auth());

** CID 1409694:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()


________________________________________________________________________________________________________
*** CID 1409694:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
1630         dout(10) << "request " << *mdr << " was killed" << dendl;
1631         return;
1632       }
1633     
1634       MClientRequest *req = mdr->client_request;
1635     
>>>     CID 1409694:    (FORWARD_NULL)
>>>     Comparing "this->logger" to null implies that "this->logger" might be null.
1636       if (logger) logger->inc(l_mdss_dispatch_client_request);
1637     
1638       dout(7) << "dispatch_client_request " << *req << dendl;
1639     
1640       if (req->may_write()) {
1641         if (mdcache->is_readonly()) {
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
1630         dout(10) << "request " << *mdr << " was killed" << dendl;
1631         return;
1632       }
1633     
1634       MClientRequest *req = mdr->client_request;
1635     
>>>     CID 1409694:    (FORWARD_NULL)
>>>     Comparing "this->logger" to null implies that "this->logger" might be null.
1636       if (logger) logger->inc(l_mdss_dispatch_client_request);
1637     
1638       dout(7) << "dispatch_client_request " << *req << dendl;
1639     
1640       if (req->may_write()) {
1641         if (mdcache->is_readonly()) {
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
1630         dout(10) << "request " << *mdr << " was killed" << dendl;
1631         return;
1632       }
1633     
1634       MClientRequest *req = mdr->client_request;
1635     
>>>     CID 1409694:    (FORWARD_NULL)
>>>     Comparing "this->logger" to null implies that "this->logger" might be null.
1636       if (logger) logger->inc(l_mdss_dispatch_client_request);
1637     
1638       dout(7) << "dispatch_client_request " << *req << dendl;
1639     
1640       if (req->may_write()) {
1641         if (mdcache->is_readonly()) {
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
1630         dout(10) << "request " << *mdr << " was killed" << dendl;
1631         return;
1632       }
1633     
1634       MClientRequest *req = mdr->client_request;
1635     
>>>     CID 1409694:    (FORWARD_NULL)
>>>     Comparing "this->logger" to null implies that "this->logger" might be null.
1636       if (logger) logger->inc(l_mdss_dispatch_client_request);
1637     
1638       dout(7) << "dispatch_client_request " << *req << dendl;
1639     
1640       if (req->may_write()) {
1641         if (mdcache->is_readonly()) {
/home/brad/working/src/ceph/src/mds/Server.cc: 1636 in Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl> &)()
1630         dout(10) << "request " << *mdr << " was killed" << dendl;
1631         return;
1632       }
1633     
1634       MClientRequest *req = mdr->client_request;
1635     
>>>     CID 1409694:    (FORWARD_NULL)
>>>     Comparing "this->logger" to null implies that "this->logger" might be null.
1636       if (logger) logger->inc(l_mdss_dispatch_client_request);
1637     
1638       dout(7) << "dispatch_client_request " << *req << dendl;
1639     
1640       if (req->may_write()) {
1641         if (mdcache->is_readonly()) {

** CID 1409695:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/mds/Server.cc: 1147 in Server::respond_to_request(boost::intrusive_ptr<MDRequestImpl> &, int)()


________________________________________________________________________________________________________
*** CID 1409695:  Control flow issues  (MISSING_BREAK)
/home/brad/working/src/ceph/src/mds/Server.cc: 1147 in Server::respond_to_request(boost::intrusive_ptr<MDRequestImpl> &, int)()
1141           break;
1142         case CEPH_MDS_OP_GETFILELOCK:
1143           logger->inc(l_mdss_req_getfilelock);
1144           break;
1145         case CEPH_MDS_OP_CREATE:
1146           logger->inc(l_mdss_req_create);
>>>     CID 1409695:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
1147         case CEPH_MDS_OP_OPEN:
1148           logger->inc(l_mdss_req_open);
1149           break;
1150         case CEPH_MDS_OP_MKNOD:
1151           logger->inc(l_mdss_req_mknod);
1152           break;

** CID 1409696:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 821 in get_attrs(ObjectStore *, coll_t, ghobject_t, ObjectStore::Transaction *, ceph::buffer::list &, OSDriver &, SnapMapper &, const ghobject_t &, const std::set<ghobject_t, std::less<ghobject_t>, std::allocator<ghobject_t>> &)()


________________________________________________________________________________________________________
*** CID 1409696:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 821 in get_attrs(ObjectStore *, coll_t, ghobject_t, ObjectStore::Transaction *, ceph::buffer::list &, OSDriver &, SnapMapper &, const ghobject_t &, const std::set<ghobject_t, std::less<ghobject_t>, std::allocator<ghobject_t>> &)()
815         cerr << "\tdata: offset " << ds.offset << " len " << ds.len << std::endl;
816       t->write(coll, hoid, ds.offset, ds.len,  ds.databl);
817       return 0;
818     }
819     
820     int get_attrs(
>>>     CID 1409696:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
821       ObjectStore *store, coll_t coll, ghobject_t hoid,
822       ObjectStore::Transaction *t, bufferlist &bl,
823       OSDriver &driver, SnapMapper &snap_mapper,
824       const ghobject_t& last_head,
825       const set<ghobject_t>& last_clones)
826     {

** CID 1409697:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
/home/brad/working/src/ceph/src/rgw/rgw_iam_policy.h: 323 in ()


________________________________________________________________________________________________________
*** CID 1409697:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
/home/brad/working/src/ceph/src/rgw/rgw_iam_policy.h: 323 in ()
317           return false;
318         }
319     
320         try {
321           double d = std::stod(s, &p);
322           if (p == s.length()) {
>>>     CID 1409697:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
>>>     During compilation of file '/home/brad/working/src/ceph/src/rgw/rgw_admin.cc'
323     	return !((d == +0.0) || (d = -0.0) || std::isnan(d));
324           }
325         } catch (const std::logic_error& e) {
326           // Fallthrough
327         }
328     

** CID 1409698:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 87 in RadosTestECNS::RadosTestECNS(bool)()


________________________________________________________________________________________________________
*** CID 1409698:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 87 in RadosTestECNS::RadosTestECNS(bool)()
81       librados::IoCtx ioctx;
82       bool cleanup;
83     };
84     
85     class RadosTestECNS : public RadosTestNS {
86     public:
>>>     CID 1409698:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
87       RadosTestECNS(bool c=false) : cleanup(c) {}
88       ~RadosTestECNS() override {}
89     protected:
90       static void SetUpTestCase();
91       static void TearDownTestCase();
92       static rados_t s_cluster;

** CID 1409699:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 24 in RadosTestNS::RadosTestNS(bool)()


________________________________________________________________________________________________________
*** CID 1409699:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 24 in RadosTestNS::RadosTestNS(bool)()
18      *
19      * Since pool creation and deletion is slow, this allows many tests to
20      * run faster.
21      */
22     class RadosTestNS : public ::testing::Test {
23     public:
>>>     CID 1409699:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "ioctx" is not initialized in this constructor nor in any functions that it calls.
24       RadosTestNS(bool c=false) : cleanup(c) {}
25       ~RadosTestNS() override {}
26     protected:
27       static void SetUpTestCase();
28       static void TearDownTestCase();
29       static void cleanup_all_objects(rados_ioctx_t ioctx);

** CID 1409700:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 109 in RadosTestECPPNS::RadosTestECPPNS(bool)()


________________________________________________________________________________________________________
*** CID 1409700:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 109 in RadosTestECPPNS::RadosTestECPPNS(bool)()
103     struct RadosTestECNSCleanup : public RadosTestECNS {
104       RadosTestECNSCleanup() : RadosTestECNS(true) {}
105     };
106     
107     class RadosTestECPPNS : public RadosTestPPNS {
108     public:
>>>     CID 1409700:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
109       RadosTestECPPNS(bool c=false) : cluster(s_cluster), cleanup(c) {}
110       ~RadosTestECPPNS() override {}
111     protected:
112       static void SetUpTestCase();
113       static void TearDownTestCase();
114       static librados::Rados s_cluster;

** CID 1409701:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 139 in RadosTest::RadosTest(bool)()


________________________________________________________________________________________________________
*** CID 1409701:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 139 in RadosTest::RadosTest(bool)()
133      *
134      * Since pool creation and deletion is slow, this allows many tests to
135      * run faster.
136      */
137     class RadosTest : public ::testing::Test {
138     public:
>>>     CID 1409701:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "ioctx" is not initialized in this constructor nor in any functions that it calls.
139       RadosTest(bool c=false) : cleanup(c) {}
140       ~RadosTest() override {}
141     protected:
142       static void SetUpTestCase();
143       static void TearDownTestCase();
144       static void cleanup_default_namespace(rados_ioctx_t ioctx);

** CID 1409702:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 219 in RadosTestECPP::RadosTestECPP(bool)()


________________________________________________________________________________________________________
*** CID 1409702:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 219 in RadosTestECPP::RadosTestECPP(bool)()
213       std::string nspace;
214       uint64_t alignment;
215     };
216     
217     class RadosTestECPP : public RadosTestPP {
218     public:
>>>     CID 1409702:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
219       RadosTestECPP(bool c=false) : cluster(s_cluster), cleanup(c) {}
220       ~RadosTestECPP() override {}
221     protected:
222       static void SetUpTestCase();
223       static void TearDownTestCase();
224       static librados::Rados s_cluster;

** CID 1409703:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 200 in RadosTestEC::RadosTestEC(bool)()


________________________________________________________________________________________________________
*** CID 1409703:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librados/TestCase.h: 200 in RadosTestEC::RadosTestEC(bool)()
194       bool cleanup;
195       std::string nspace;
196     };
197     
198     class RadosTestEC : public RadosTest {
199     public:
>>>     CID 1409703:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "alignment" is not initialized in this constructor nor in any functions that it calls.
200       RadosTestEC(bool c=false) : cleanup(c) {}
201       ~RadosTestEC() override {}
202     protected:
203       static void SetUpTestCase();
204       static void TearDownTestCase();
205       static rados_t s_cluster;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HMjjwnZWb39VuwjRaMfXFHTPT740cPiEkS-2FSnJ-2FMgmtpSduCsquQuoddloT7fhppnFh3N-2BJw7a79K4uSHJ34cJDZNeqy-2F6aLXObwCtKbuuMVTkoqWbxXQElkKOyN-2BgypV5ljNLkbHL3UhxN2823zFzWzKJEKFrc8Pfw-2FWVzBvavhkOAMOHVNwk5CVlKXYIlr8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HMjjwnZWb39VuwjRaMfXFHTPT740cPiEkS-2FSnJ-2FMgmtmLE7WL9MADAv2U9YvJXPZOVKqgmAJ0Y7OJ5giSDmCRzc-2FaQgSPvVD0hmvGKftuKutvyDFix1k3KH2UN4YeJBQPZd0qe4ai04KpK-2B53k2aPpG9YHV7zkjCKlBmVeq9ttBKSKZnWCn8SaCNHmRSDGKtU-3D

