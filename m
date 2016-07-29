From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: BLueStore Deadlock
Date: Fri, 29 Jul 2016 01:36:26 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C373B9424@SHSMSX101.ccr.corp.intel.com>
References: <6AA21C22F0A5DA478922644AD2EC308C373B92BC@SHSMSX101.ccr.corp.intel.com>
  <BL2PR02MB2115604A7C4767FC465C320EF4000@BL2PR02MB2115.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C373B940C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2990 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcG2Bgg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 21:36:36 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C373B940C@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Roy: my question is why is there STATE_WRITTING?  For read we don't by pass cache, so why need STATE_WRITTING?

Thanks!

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ma, Jianpeng
Sent: Friday, July 29, 2016 9:24 AM
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Subject: RE: BLueStore Deadlock

Hi Roy:
    W/ your patch, there still deadlock.
By the way, if we change the BufferSpace::_add_buffer, if w/ cache flush push it into cache front and if w/o cache flag only put it  at back.
I think use this way we can remove finish_write.
How about it?

Thanks!

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Friday, July 29, 2016 6:22 AM
To: Ma, Jianpeng <jianpeng.ma@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Subject: RE: BLueStore Deadlock

Jianpeng,
I thought through this and it seems there could be one possible deadlock scenario.

tp_osd_tp --> waiting on onode->flush() for previous txc to finish. Holding Wlock(coll) aio_complete_thread --> waiting for RLock(coll) No other thread will be blocked here.

We do add previous txc in the flush_txns list during _txc_write_nodes() and before aio_complete_thread calling _txc_state_proc(). So, if within this time frame if we have IO on the same collection , it will be waiting on unfinished txcs.
The solution to this could be the following..

root@emsnode5:~/ceph-master/src# git diff diff --git a/src/os/bluestore/BlueStore.cc b/src/os/bluestore/BlueStore.cc index e8548b1..575a234 100644
--- a/src/os/bluestore/BlueStore.cc
+++ b/src/os/bluestore/BlueStore.cc
@@ -4606,6 +4606,11 @@ void BlueStore::_txc_state_proc(TransContext *txc)
         (txc->first_collection)->lock.get_read();
       }
       for (auto& o : txc->onodes) {
+        {
+          std::lock_guard<std::mutex> l(o->flush_lock);
+          o->flush_txns.insert(txc);
+        }
+
         for (auto& p : o->blob_map.blob_map) {
            p.bc.finish_write(txc->seq);
        }
@@ -4733,8 +4738,8 @@ void BlueStore::_txc_write_nodes(TransContext *txc, KeyValueDB::Transaction t)
     dout(20) << "  onode " << (*p)->oid << " is " << bl.length() << dendl;
     t->set(PREFIX_OBJ, (*p)->key, bl);

-    std::lock_guard<std::mutex> l((*p)->flush_lock);
-    (*p)->flush_txns.insert(txc);
+    /*std::lock_guard<std::mutex> l((*p)->flush_lock);
+    (*p)->flush_txns.insert(txc);*/
   }


I am not able to reproduce this in my setup , so, if you can do the above changes in your env and see if you are still hitting the issue, would be helpful.

Thanks & Regards
Somnath


-----Original Message-----
From: Somnath Roy
Sent: Thursday, July 28, 2016 8:45 AM
To: 'Ma, Jianpeng'
Cc: ceph-devel
Subject: RE: BLueStore Deadlock

Hi Jianpeng,
Are you trying with latest master and still hitting the issue (seems so but confirming) ?
The following scenario should not be creating deadlock because of the following reason.

Onode->flush() is waiting on flush_lock() and from _txc_finish() it is releasing that before taking osr->qlock(). Am I missing anything ?

I got a deadlock in this path in one of my earlier changes in the following pull request (described in detail there) and it is fixed and merged.

https://github.com/ceph/ceph/pull/10220

If my theory is right , we are hitting deadlock because of some other reason may be. It seems you are doing WAL write , could you please describe the steps to reproduce ?

Thanks & Regards
Somnath

From: Ma, Jianpeng [mailto:jianpeng.ma@intel.com]
Sent: Thursday, July 28, 2016 1:46 AM
To: Somnath Roy
Cc: ceph-devel; Ma, Jianpeng
Subject: BLueStore Deadlock

Hi Roy:
     When do seqwrite w/ rbd+librbd, I met deadlock for bluestore. It can reproduce 100%.(based on 98602ae6c67637dbadddd549bd9a0035e5a2717)
By add message and this found this bug caused by bf70bcb6c54e4d6404533bc91781a5ef77d62033.
Consider this case:

tp_osd_tp                                              aio_complete_thread                                 kv_sync_thread
Rwlock(coll)                                            txc_finish_io                                                     _txc_finish do_write                                                 lock(osr->qlock)                                               lock(osr->qlock) do_read                                                  RLock(coll)                                                                     need osr->qlock to continue
onode->flush()                                            need coll
onode->readlock to continue
   need previous txc complete

But current I don't how to fix this.

Thanks!
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
