From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 21 Jun 2017 21:27:02 -0700
Message-ID: <594b471650911_6605116f32c8989d@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:16853 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbdFVE1E (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 00:27:04 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id KnCigpE6RRqiTI4qzE9yfw
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 04:27:02.363 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
452 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1412976:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()


________________________________________________________________________________________________________
*** CID 1412976:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()
5524     	EXPECT_TRUE(lock_owner);
5525     	std::cout << m_id << ": exclusive lock acquired" << std::endl;
5526     	{
5527     	  lock_guard<mutex> locker(lock);
5528     	  owner_id = m_id;
5529     	}
>>>     CID 1412976:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
5530     	usleep(rand() % 50000);
5531           }
5532     
5533           lock_guard<mutex> locker(lock);
5534           if (owner_id == m_id) {
5535     	EXPECT_EQ(0, rbd_lock_release(m_image));

** CID 1412977:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2027 in BlueStore::ExtentMap::allocate_spanning_blob_id()()


________________________________________________________________________________________________________
*** CID 1412977:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.cc: 2027 in BlueStore::ExtentMap::allocate_spanning_blob_id()()
2021         return 0;
2022       bid_t bid = spanning_blob_map.rbegin()->first + 1;
2023       // bid is valid and available.
2024       if (bid >= 0)
2025         return bid;
2026       // Find next unused bid;
>>>     CID 1412977:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2027       bid = rand() % (numeric_limits<bid_t>::max() + 1);
2028       const auto begin_bid = bid;
2029       do {
2030         if (!spanning_blob_map.count(bid))
2031           return bid;
2032         else {

** CID 1412978:    (SLEEP)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()


________________________________________________________________________________________________________
*** CID 1412978:    (SLEEP)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()
5524     	EXPECT_TRUE(lock_owner);
5525     	std::cout << m_id << ": exclusive lock acquired" << std::endl;
5526     	{
5527     	  lock_guard<mutex> locker(lock);
5528     	  owner_id = m_id;
5529     	}
>>>     CID 1412978:    (SLEEP)
>>>     Call to "usleep" might sleep while holding lock "this->lock".
5530     	usleep(rand() % 50000);
5531           }
5532     
5533           lock_guard<mutex> locker(lock);
5534           if (owner_id == m_id) {
5535     	EXPECT_EQ(0, rbd_lock_release(m_image));
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 5530 in TestLibRBD_ExclusiveLock_Test::TestBody()::[lambda(int, void *&) (instance 1)]::operator ()(int, void *&) const()
5524     	EXPECT_TRUE(lock_owner);
5525     	std::cout << m_id << ": exclusive lock acquired" << std::endl;
5526     	{
5527     	  lock_guard<mutex> locker(lock);
5528     	  owner_id = m_id;
5529     	}
>>>     CID 1412978:    (SLEEP)
>>>     Call to "usleep" might sleep while holding lock "this->lock".
5530     	usleep(rand() % 50000);
5531           }
5532     
5533           lock_guard<mutex> locker(lock);
5534           if (owner_id == m_id) {
5535     	EXPECT_EQ(0, rbd_lock_release(m_image));

** CID 1412979:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_lc.h: 81 in LCRule::LCRule()()


________________________________________________________________________________________________________
*** CID 1412979:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_lc.h: 81 in LCRule::LCRule()()
75       LCExpiration noncur_expiration;
76       LCExpiration mp_expiration;
77       bool dm_expiration;
78     
79     public:
80     
>>>     CID 1412979:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "dm_expiration" is not initialized in this constructor nor in any functions that it calls.
81       LCRule(){};
82       ~LCRule(){};
83     
84       bool get_id(string& _id) {
85           _id = id;
86           return true;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Hdr6h-2FwNY-2BPNl-2FhRJsMeMY8yymIcYqeyx8I3yhnIuuNXhTLvZvv-2B2vp6eYcBQUaGjiTdUH-2FKWqdHEACF-2FvC4vDL5J9VzCCwDkbrOC7-2FUBv2txEyPUyeQJ-2FMyLiWTzCCahjhOYO-2FWGq3tgUd9nPissGlkgFgepCfSwkrOhRPM0g66-2Fm0yJ2ZE5Rm5CxN3vF9OU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Hdr6h-2FwNY-2BPNl-2FhRJsMeMY8yymIcYqeyx8I3yhnIuuNfq2DsgbC22CplMb1dqqY7yL-2BkFwVLkKiGMREPzHvy-2BrqqyulPg4I4WrUxx-2FW-2F-2BhvXpNpR9gvo7B6GUb7iNz4Idkfu18bmQY8kDFWh0e01UR-2BzTealqAB7YPDtwdxN4D5BHjkk8tiliYISXCkqo3ke8-3D

