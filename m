From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 19 Mar 2016 10:58:32 -0700
Message-ID: <56ed9348a7401_398f4db31862592@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53382 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcCSR6e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Mar 2016 13:58:34 -0400
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id B744410C119C
	for <ceph-devel@vger.kernel.org>; Sat, 19 Mar 2016 10:58:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

7 new defect(s) introduced to ceph found with Coverity Scan.
17 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 7 of 7 defect(s)


** CID 1356901:  Error handling issues  (CHECKED_RETURN)
/tools/scratchtoolpp.cc: 68 in main()


________________________________________________________________________________________________________
*** CID 1356901:  Error handling issues  (CHECKED_RETURN)
/tools/scratchtoolpp.cc: 68 in main()
62       }
63     
64       if (rados.conf_read_file(NULL)) {
65          cerr << "couldn't read configuration file." << std::endl;
66          exit(1);
67       }
>>>     CID 1356901:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "conf_parse_argv" without checking return value (as is done elsewhere 4 out of 5 times).
68       rados.conf_parse_argv(argc, argv);
69     
70       if (!rados.conf_set("config option that doesn't exist",
71                          "some random value")) {
72         printf("error: succeeded in setting nonexistent config option\n");
73         exit(1);

** CID 1356903:  Program hangs  (INFINITE_LOOP)
/librados/IoCtxImpl.cc: 688 in librados::IoCtxImpl::operate(const object_t &, ObjectOperation *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, int)()


________________________________________________________________________________________________________
*** CID 1356903:  Program hangs  (INFINITE_LOOP)
/librados/IoCtxImpl.cc: 688 in librados::IoCtxImpl::operate(const object_t &, ObjectOperation *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, int)()
682       Objecter::Op *objecter_op = objecter->prepare_mutate_op(oid, oloc,
683     							  *o, snapc, ut, flags,
684     							  NULL, oncommit, &ver);
685       objecter->op_submit(objecter_op);
686     
687       mylock.Lock();
>>>     CID 1356903:  Program hangs  (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
688       while (!done)
689         cond.Wait(mylock);
690       mylock.Unlock();
691       ldout(client->cct, 10) << "Objecter returned from "
692     	<< ceph_osd_op_name(op) << " r=" << r << dendl;
693     

** CID 1356904:    (NULL_RETURNS)
/osd/OSD.cc: 3567 in OSD::handle_pg_peering_evt(spg_t, const pg_history_t &, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, pg_interval_t>>> &, unsigned int, bool, std::shared_ptr<PG::CephPeeringEvt>)()
/osd/OSD.cc: 3575 in OSD::handle_pg_peering_evt(spg_t, const pg_history_t &, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, pg_interval_t>>> &, unsigned int, bool, std::shared_ptr<PG::CephPeeringEvt>)()


________________________________________________________________________________________________________
*** CID 1356904:    (NULL_RETURNS)
/osd/OSD.cc: 3567 in OSD::handle_pg_peering_evt(spg_t, const pg_history_t &, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, pg_interval_t>>> &, unsigned int, bool, std::shared_ptr<PG::CephPeeringEvt>)()
3561           return;
3562         }
3563         }
3564       } else {
3565         // already had it.  did the mapping change?
3566         PG *pg = _lookup_lock_pg(pgid);
>>>     CID 1356904:    (NULL_RETURNS)
>>>     Dereferencing a null pointer "pg".
3567         if (same_primary && epoch < pg->info.history.same_primary_since) {
3568           dout(10) << "get_or_create_pg " << pgid << " primary changed in "
3569     	       << pg->info.history.same_primary_since
3570     	       << " (msg from " << epoch << ")"
3571     	       << dendl;
3572           pg->unlock();
/osd/OSD.cc: 3575 in OSD::handle_pg_peering_evt(spg_t, const pg_history_t &, std::map<unsigned int, pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, pg_interval_t>>> &, unsigned int, bool, std::shared_ptr<PG::CephPeeringEvt>)()
3569     	       << pg->info.history.same_primary_since
3570     	       << " (msg from " << epoch << ")"
3571     	       << dendl;
3572           pg->unlock();
3573           return;
3574         }
>>>     CID 1356904:    (NULL_RETURNS)
>>>     Dereferencing a null pointer "pg".
3575         if (!same_primary && epoch < pg->info.history.same_interval_since) {
3576           dout(10) << *pg << " get_or_create_pg acting changed in "
3577     	       << pg->info.history.same_interval_since
3578     	       << " (msg from " << epoch << ")" << dendl;
3579           pg->unlock();
3580           return;

** CID 1356905:  Resource leaks  (RESOURCE_LEAK)
/rgw/rgw_rados.cc: 6566 in RGWRados::fetch_remote_obj(RGWObjectCtx &, const rgw_user &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, req_info *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, rgw_obj &, rgw_obj &, RGWBucketInfo &, RGWBucketInfo &, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, const std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *,
  const std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, bool, const char *, const char *, RGWRados::AttrsMod, bo
 ol, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &, RGWObjCategory, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, rgw_err *, void (*)(long, void *), void *)()


________________________________________________________________________________________________________
*** CID 1356905:  Resource leaks  (RESOURCE_LEAK)
/rgw/rgw_rados.cc: 6566 in RGWRados::fetch_remote_obj(RGWObjectCtx &, const rgw_user &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, req_info *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, rgw_obj &, rgw_obj &, RGWBucketInfo &, RGWBucketInfo &, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, const std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *,
  const std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, bool, const char *, const char *, RGWRados::AttrsMod, bo
 ol, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &, RGWObjCategory, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*, rgw_err *, void (*)(long, void *), void *)()
6560         ret = 0;
6561       }
6562       int r = opstate.set_state(state);
6563       if (r < 0) {
6564         ldout(cct, 0) << "ERROR: failed to set opstate r=" << ret << dendl;
6565       }
>>>     CID 1356905:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "in_stream_req" going out of scope leaks the storage it points to.
6566       return ret;
6567     }
6568     
6569     
6570     int RGWRados::copy_obj_to_remote_dest(RGWObjState *astate,
6571                                           map<string, bufferlist>& src_attrs,

** CID 1356906:  Uninitialized members  (UNINIT_CTOR)
/tools/rbd_mirror/image_sync/ObjectCopyRequest.cc: 38 in rbd::mirror::image_sync::ObjectCopyRequest<librbd::ImageCtx>::ObjectCopyRequest(librbd::ImageCtx *, librbd::ImageCtx *, const std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long>>, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::vector<unsigned long, std::allocator<unsigned long>>>>> *, unsigned long, Context *)()


________________________________________________________________________________________________________
*** CID 1356906:  Uninitialized members  (UNINIT_CTOR)
/tools/rbd_mirror/image_sync/ObjectCopyRequest.cc: 38 in rbd::mirror::image_sync::ObjectCopyRequest<librbd::ImageCtx>::ObjectCopyRequest(librbd::ImageCtx *, librbd::ImageCtx *, const std::map<unsigned long, std::vector<unsigned long, std::allocator<unsigned long>>, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, std::vector<unsigned long, std::allocator<unsigned long>>>>> *, unsigned long, Context *)()
32     
33       m_local_io_ctx.dup(m_local_image_ctx->data_ctx);
34       m_local_oid = m_local_image_ctx->get_object_name(object_number);
35     
36       m_remote_io_ctx.dup(m_remote_image_ctx->data_ctx);
37       m_remote_oid = m_remote_image_ctx->get_object_name(object_number);
>>>     CID 1356906:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_snap_ret" is not initialized in this constructor nor in any functions that it calls.
38     }
39     
40     template <typename I>
41     void ObjectCopyRequest<I>::send() {
42       send_list_snaps();
43     }

** CID 1356907:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 2285 in RGWRados::Object::Stat::Result::Result()()


________________________________________________________________________________________________________
*** CID 1356907:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 2285 in RGWRados::Object::Stat::Result::Result()()
2279             RGWObjManifest manifest;
2280             bool has_manifest;
2281             uint64_t size;
2282     	struct timespec mtime;
2283             map<string, bufferlist> attrs;
2284     
>>>     CID 1356907:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "mtime.tv_nsec" is not initialized in this constructor nor in any functions that it calls.
2285             Result() : has_manifest(false), size(0) {}
2286           } result;
2287     
2288           struct State {
2289             librados::IoCtx io_ctx;
2290             librados::AioCompletion *completion;

** CID 1356908:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_cr_rados.h: 25 in RGWAsyncRadosRequest::RGWAsyncRadosRequest(RGWCoroutine *, RGWAioCompletionNotifier *)()


________________________________________________________________________________________________________
*** CID 1356908:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_cr_rados.h: 25 in RGWAsyncRadosRequest::RGWAsyncRadosRequest(RGWCoroutine *, RGWAioCompletionNotifier *)()
19     protected:
20       virtual int _send_request() = 0;
21     public:
22       RGWAsyncRadosRequest(RGWCoroutine *_caller, RGWAioCompletionNotifier *_cn) : caller(_caller), notifier(_cn),
23                                                                                    done(false), lock("RGWAsyncRadosRequest::lock") {
24         caller->get();
>>>     CID 1356908:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "retcode" is not initialized in this constructor nor in any functions that it calls.
25       }
26       virtual ~RGWAsyncRadosRequest() {
27         caller->put();
28       }
29     
30       void send_request() {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

