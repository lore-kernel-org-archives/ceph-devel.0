From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 14 Sep 2017 07:19:37 +0000 (UTC)
Message-ID: <59ba2d89bcd9a_53be71733478d2@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:63697 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751085AbdINHY5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Sep 2017 03:24:57 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id n8dueWAEQf--dC_UFXt2EQ
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 07:19:37.869 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
7 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 717382:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_rados.h: 2371 in RGWRados::RGWRados()()


________________________________________________________________________________________________________
*** CID 717382:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_rados.h: 2371 in RGWRados::RGWRados()()
2365                    pools_initialized(false),
2366                    quota_handler(NULL),
2367                    finisher(NULL),
2368                    cr_registry(NULL),
2369                    zone_short_id(0),
2370                    rest_master_conn(NULL),
>>>     CID 717382:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "sync_tracer" is not initialized in this constructor nor in any functions that it calls.
2371                    meta_mgr(NULL), data_log(NULL), reshard(NULL) {}
2372     
2373       uint64_t get_new_req_id() {
2374         return ++max_req_id;
2375       }
2376     

** CID 1417718:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/common/test_mclock_priority_queue.cc: 24 in Request::Request()()


________________________________________________________________________________________________________
*** CID 1417718:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/common/test_mclock_priority_queue.cc: 24 in Request::Request()()
18     #include "gtest/gtest.h"
19     #include "common/mClockPriorityQueue.h"
20     
21     
22     struct Request {
23       int value;
>>>     CID 1417718:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "value" is not initialized in this constructor nor in any functions that it calls.
24       Request() = default;
25       Request(const Request& o) = default;
26       Request(int value) :
27         value(value)
28       {}
29     };

** CID 1417719:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_data_sync.cc: 492 in RGWInitDataSyncStatusCoroutine::RGWInitDataSyncStatusCoroutine(RGWDataSyncEnv *, unsigned int, unsigned long, std::shared_ptr<RGWSyncTraceNode> &, rgw_data_sync_status *)()


________________________________________________________________________________________________________
*** CID 1417719:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_data_sync.cc: 492 in RGWInitDataSyncStatusCoroutine::RGWInitDataSyncStatusCoroutine(RGWDataSyncEnv *, unsigned int, unsigned long, std::shared_ptr<RGWSyncTraceNode> &, rgw_data_sync_status *)()
486         status->sync_info.instance_id = instance_id;
487     
488     #define COOKIE_LEN 16
489         char buf[COOKIE_LEN + 1];
490     
491         gen_rand_alphanumeric(cct, buf, sizeof(buf) - 1);
>>>     CID 1417719:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "buf" to "operator =", which expects a null-terminated string. [Note: The source code implementation of the function has been overridden by a builtin model.]
492         cookie = buf;
493     
494         sync_status_oid = RGWDataSyncStatusManager::sync_status_oid(sync_env->source_zone);
495     
496         tn = sync_env->sync_tracer->add_node(new RGWSyncTraceNode(sync_env->cct,
497                                              sync_env->sync_tracer, 

** CID 1417720:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 738 in Infiniband::MemoryManager::PoolAllocator::malloc(unsigned long)()


________________________________________________________________________________________________________
*** CID 1417720:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 738 in Infiniband::MemoryManager::PoolAllocator::malloc(unsigned long)()
732         ch->bytes  = cct->_conf->ms_async_rdma_buffer_size;
733         ch->offset = 0;
734         ch->buffer = ch->data; // TODO: refactor tx and remove buffer
735         ch = reinterpret_cast<Chunk *>(reinterpret_cast<char *>(ch) + rx_buf_size);
736       }
737     
>>>     CID 1417720:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "m" going out of scope leaks the storage it points to.
738       return reinterpret_cast<char *>(m->chunks);
739     }
740     
741     
742     void Infiniband::MemoryManager::PoolAllocator::free(char * const block)
743     {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gdo0EpVK5EBTrLKxxlyFrMt9L-2FbnXTrO8Epn37V8nfqzm1beyGQbAZnUjAYUpfrttHxhecBB32kV9CtfhE6LSM5d2R7fuIvChaT1A93EqtxJNyuDCDjs-2Bq2d6r6yfB5aaRirPqz51Ct4nY7sT4sfDhkcdU6hUK-2BYJddBcZlOKVVAnHoCfmSKHxZaJpxAQyRZ0-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gdo0EpVK5EBTrLKxxlyFrMt9L-2FbnXTrO8Epn37V8nfq9VJCXndK99SAlU5SBW8qtoBTQTqQxF33f0YcidWZKgNUkLmQY8hvph41xaO3Re6extPBuvGg33hrkonBUpEmMFFpH58JGbvartIc06DvFTsC8kvQCezcBjRs9LF6yergKOHi68HxT7RvI3aWxkVnEI-3D

