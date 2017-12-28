From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 28 Dec 2017 01:57:26 +0000 (UTC)
Message-ID: <5a444f8636125_7dc973330566d0@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:50221 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752670AbdL1B51 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 27 Dec 2017 20:57:27 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0008p1sjc2.sendgrid.net (SG) with ESMTP id YiWt8QCDR0Ggizquz3czMw
        for <ceph-devel@vger.kernel.org>; Thu, 28 Dec 2017 01:57:26.267 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

3 new defect(s) introduced to ceph found with Coverity Scan.
5 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1426995:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1426995:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/librbd/trash_watcher/Types.cc: 72 in librbd::trash_watcher::NotifyMessage::encode(ceph::buffer::list &) const()
66     }
67     
68     void UnknownPayload::dump(Formatter *f) const {
69     }
70     
71     void NotifyMessage::encode(bufferlist& bl) const {
>>>     CID 1426995:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
72       ENCODE_START(1, 1, bl);
73       boost::apply_visitor(watcher::util::EncodePayloadVisitor(bl), payload);
74       ENCODE_FINISH(bl);
75     }
76     
77     void NotifyMessage::decode(bufferlist::iterator& iter) {

** CID 1426996:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/librbd/internal.cc: 994 in librbd::rename(librados::IoCtx &, const char *, const char *)::boost_se_guard_t_994::~boost_se_guard_t_994()()


________________________________________________________________________________________________________
*** CID 1426996:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/librbd/internal.cc: 994 in librbd::rename(librados::IoCtx &, const char *, const char *)::boost_se_guard_t_994::~boost_se_guard_t_994()()
988         ImageCtx *ictx = new ImageCtx(srcname, "", "", io_ctx, false);
989         int r = ictx->state->open(false);
990         if (r < 0) {
991           lderr(cct) << "error opening source image: " << cpp_strerror(r) << dendl;
992           return r;
993         }
>>>     CID 1426996:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     An exception of type "ceph::buffer::end_of_buffer" is thrown but the throw list "throw()" doesn't allow it to be thrown. This will cause a call to unexpected() which usually calls terminate().
994         BOOST_SCOPE_EXIT((ictx)) {
995           ictx->state->close();
996         } BOOST_SCOPE_EXIT_END
997     
998         return ictx->operations->rename(dstname);
999       }

** CID 1426997:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/PoolReplayer.cc: 187 in rbd::mirror::<unnamed>::PoolReplayerAdminSocketHook::~PoolReplayerAdminSocketHook()()


________________________________________________________________________________________________________
*** CID 1426997:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/rbd_mirror/PoolReplayer.cc: 187 in rbd::mirror::<unnamed>::PoolReplayerAdminSocketHook::~PoolReplayerAdminSocketHook()()
181                                            "release rbd mirror leader " + name);
182         if (r == 0) {
183           commands[command] = new LeaderReleaseCommand(pool_replayer);
184         }
185       }
186     
>>>     CID 1426997:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     An exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown but the throw list "throw()" doesn't allow it to be thrown. This will cause a call to unexpected() which usually calls terminate().
187       ~PoolReplayerAdminSocketHook() override {
188         for (Commands::const_iterator i = commands.begin(); i != commands.end();
189     	 ++i) {
190           (void)admin_socket->unregister_command(i->first);
191           delete i->second;
192         }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GMWy0YeE5eJH0rPzK6A-2BTFQSvV2yEgiPICHbqweeYATl-2FI-2BaZcSqixT7Y5Tx5dSFWyhe5blkK8i6NAFaL5qRqoHtDgYlzD-2BIQmuBRVGIiy0KeDk-2FP0xngE3vJfz00ghRHd-2BFWinQWCK2Iq1bKjeWN54gOs0R8TkrfRDVNksqKRg88ovleS6D6KHfK2bcepN4E-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GMWy0YeE5eJH0rPzK6A-2BTFQSvV2yEgiPICHbqweeYATknZ8oYX4VBVrwSHvtIAlxsc7okjveriAFolv-2Bh5XswQjjrv5SCc3cHvB9LPXYbLNds5AxAGi-2BQEGaxZy-2Bw-2FC-2BKfD1TS8B237lxhjeseHwWun8HAwGOyq4f293YKtLFdtXbAbTdAhSlNPTPvhsfBYP4-3D

