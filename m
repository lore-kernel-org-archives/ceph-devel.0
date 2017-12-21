From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 21 Dec 2017 01:54:26 +0000 (UTC)
Message-ID: <5a3b1452921a0_20dd327328244d2@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:12039 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755834AbdLUBy1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 20 Dec 2017 20:54:27 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0014p1las1.sendgrid.net (SG) with ESMTP id Rd5i0Hb5TuilOqhpH_Eb8Q
        for <ceph-devel@vger.kernel.org>; Thu, 21 Dec 2017 01:54:26.861 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

3 new defect(s) introduced to ceph found with Coverity Scan.
11 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in MDBalancer::dump_loads(ceph::Formatter *)()


________________________________________________________________________________________________________
*** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in MDBalancer::dump_loads(ceph::Formatter *)()
1264     
1265       f->open_array_section("dirfrags");
1266       while (!dfs.empty()) {
1267         CDir *dir = dfs.front();
1268         dfs.pop_front();
1269     
>>>     CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "f" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
1270         if (f) {
1271           f->open_object_section("dir");
1272           dir->dump_load(f, now, decayrate);
1273           f->close_section();
1274         }
1275     

** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in MDBalancer::dump_loads(ceph::Formatter *)()


________________________________________________________________________________________________________
*** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in MDBalancer::dump_loads(ceph::Formatter *)()
1284     	if (subdir->pop_nested.meta_load() < .001)
1285     	  continue;
1286     	dfs.push_back(subdir);
1287           }
1288         }
1289       }
>>>     CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "f" to "close_section", which dereferences it. (The dereference happens because this is a virtual function call.)
1290       f->close_section();  // dirfrags array
1291     
1292       f->open_object_section("mds_load");
1293       {
1294     
1295         auto dump_mds_load = [this, f, now](mds_load_t& load) {

** CID 1426748:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/ECBackend.h: 511 in ECBackend::Op::Op()()


________________________________________________________________________________________________________
*** CID 1426748:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/ECBackend.h: 511 in ECBackend::Op::Op()()
505     
506         /// Callbacks
507         Context *on_local_applied_sync = nullptr;
508         Context *on_all_applied = nullptr;
509         Context *on_all_commit = nullptr;
510     
>>>     CID 1426748:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "tid" is not initialized in this constructor nor in any functions that it calls.
511         Op() {}
512         Op(ceph_tid_t t, std::function<void(void)>&& cb)
513           : tid(t), on_write(cb) { }
514         ~Op() {
515           delete on_local_applied_sync;
516           delete on_all_applied;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EZdAaNMzjj2ZRPbkDolmkD-2Bsw3Hr011ofOuYtMXk6reD-2BdSKexT7q2Lt0OAh2jGrzg5SQMuoaqwHui6R1Zr4V9s2n1khNXR-2FUeSt-2FeK-2B8v7UHTFIirasRrOH0JyfLd8WCYYi5sLFX2EAqp5kTELhe3kZHHMhtNJs7ZBbbIoEKfYvFJxz-2FLyjjWgmpPsj9xT30-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EZdAaNMzjj2ZRPbkDolmkD-2Bsw3Hr011ofOuYtMXk6rePtmPVLUO0YE0KkkhvPsamW9f4ux9mKJ6oIQSTiuTnvSysxvaxtXyro961jYTmEV3Oe8sHZyvIhTe43-2FO7AgOe6JpQ6-2BED8iIth7JGE7yjz1-2ByVpjkES0rcqDlDhDaRFpbhpoNxZUgFSCw7hA7ntjrM-3D

