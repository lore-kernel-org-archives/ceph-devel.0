From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 23 Dec 2014 06:37:18 -0800
Message-ID: <54997e1eaaa81_da9feb334584c@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:63091 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbaLWOhT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Dec 2014 09:37:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1260393:  Logically dead code  (DEADCODE)
/osd/osd_types.cc: 3427 in object_copy_data_t::decode(ceph::buffer::list::iterator &)()

** CID 1260394:  Resource leak  (RESOURCE_LEAK)
/test/cls_refcount/test_cls_refcount.cc: 138 in cls_rgw_test_put_snap_Test::TestBody()()

** CID 1260395:  Resource leak  (RESOURCE_LEAK)
/test/librados/snapshots.cc: 160 in LibRadosSnapshotsPP_SnapCreateRemovePP_Test::TestBody()()
/test/librados/snapshots.cc: 164 in LibRadosSnapshotsPP_SnapCreateRemovePP_Test::TestBody()()

** CID 1260396:  Dereference before null check  (REVERSE_INULL)
/librados/RadosClient.cc: 297 in librados::RadosClient::shutdown()()


________________________________________________________________________________________________________
*** CID 1260393:  Logically dead code  (DEADCODE)
/osd/osd_types.cc: 3427 in object_copy_data_t::decode(ceph::buffer::list::iterator &)()
3421         if (struct_v >= 2)
3422           ::decode(omap_header, bl);
3423         if (struct_v >= 3) {
3424           ::decode(snaps, bl);
3425           ::decode(snap_seq, bl);
3426         } else {
>>>     CID 1260393:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "this->snaps.clear();".
3427           snaps.clear();
3428           snap_seq = 0;
3429         }
3430         if (struct_v >= 4) {
3431           ::decode(flags, bl);
3432           ::decode(data_digest, bl);

________________________________________________________________________________________________________
*** CID 1260394:  Resource leak  (RESOURCE_LEAK)
/test/cls_refcount/test_cls_refcount.cc: 138 in cls_rgw_test_put_snap_Test::TestBody()()
132     
133       ASSERT_EQ(0, ioctx.snap_create("snapbar"));
134     
135       librados::ObjectWriteOperation *op = new_op();
136       op->create(false);
137       cls_refcount_put(*op, "notag", true);
>>>     CID 1260394:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
138       ASSERT_EQ(-ENOENT, ioctx.operate("foo", op));
139     
140       EXPECT_EQ(0, ioctx.snap_remove("snapfoo"));
141       EXPECT_EQ(0, ioctx.snap_remove("snapbar"));
142     
143       delete op;

________________________________________________________________________________________________________
*** CID 1260395:  Resource leak  (RESOURCE_LEAK)
/test/librados/snapshots.cc: 160 in LibRadosSnapshotsPP_SnapCreateRemovePP_Test::TestBody()()
154       ASSERT_EQ(0, ioctx.remove("foo"));
155       ASSERT_EQ(0, ioctx.snap_create("snapbar"));
156     
157       librados::ObjectWriteOperation *op = new librados::ObjectWriteOperation();
158       op->create(false);
159       op->remove();
>>>     CID 1260395:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
160       ASSERT_EQ(0, ioctx.operate("foo", op));
161     
162       EXPECT_EQ(0, ioctx.snap_remove("snapfoo"));
163       EXPECT_EQ(0, ioctx.snap_remove("snapbar"));
164     }
165     
/test/librados/snapshots.cc: 164 in LibRadosSnapshotsPP_SnapCreateRemovePP_Test::TestBody()()
158       op->create(false);
159       op->remove();
160       ASSERT_EQ(0, ioctx.operate("foo", op));
161     
162       EXPECT_EQ(0, ioctx.snap_remove("snapfoo"));
163       EXPECT_EQ(0, ioctx.snap_remove("snapbar"));
>>>     CID 1260395:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
164     }
165     
166     TEST_F(LibRadosSnapshotsSelfManaged, Snap) {
167       std::vector<uint64_t> my_snaps;
168       my_snaps.push_back(-2);
169       ASSERT_EQ(0, rados_ioctx_selfmanaged_snap_create(ioctx, &my_snaps.back()));

________________________________________________________________________________________________________
*** CID 1260396:  Dereference before null check  (REVERSE_INULL)
/librados/RadosClient.cc: 297 in librados::RadosClient::shutdown()()
291         return;
292       }
293       if (state == CONNECTED) {
294         finisher.stop();
295       }
296       bool need_objecter = false;
>>>     CID 1260396:  Dereference before null check  (REVERSE_INULL)
>>>     Null-checking "this->objecter" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
297       if (objecter && objecter->initialized.read()) {
298         need_objecter = true;
299       }
300       state = DISCONNECTED;
301       instance_id = 0;
302       timer.shutdown();   // will drop+retake lock


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

