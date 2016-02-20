From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 20 Feb 2016 10:26:46 -0800
Message-ID: <56c8afe63994c_40051159338344c5@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38386 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcBTS0b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 13:26:31 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id D46BE24E109D
	for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 10:26:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

51 new defect(s) introduced to ceph found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 51 defect(s)


** CID 1353391:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1353391:  Memory - corruptions  (OVERRUN)
/rgw/rgw_data_sync.h: 81 in rgw_data_sync_marker::encode(ceph::buffer::list &) const()
75       uint64_t pos;
76       utime_t timestamp;
77     
78       rgw_data_sync_marker() : state(FullSync), total_entries(0), pos(0) {}
79     
80       void encode(bufferlist& bl) const {
>>>     CID 1353391:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
81         ENCODE_START(1, 1, bl);
82         ::encode(state, bl);
83         ::encode(marker, bl);
84         ::encode(next_step_marker, bl);
85         ::encode(total_entries, bl);
86         ::encode(pos, bl);

** CID 1353390:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1353390:  Memory - corruptions  (OVERRUN)
/rgw/rgw_data_sync.h: 29 in rgw_data_sync_info::encode(ceph::buffer::list &) const()
23       };
24     
25       uint16_t state;
26       uint32_t num_shards;
27     
28       void encode(bufferlist& bl) const {
>>>     CID 1353390:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
29         ENCODE_START(1, 1, bl);
30         ::encode(state, bl);
31         ::encode(num_shards, bl);
32         ENCODE_FINISH(bl);
33       }
34     

** CID 1353389:  Control flow issues  (MISMATCHED_ITERATOR)
/rgw/rgw_common.cc: 783 in RGWHTTPArgs::sys_get(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool *)()


________________________________________________________________________________________________________
*** CID 1353389:  Control flow issues  (MISMATCHED_ITERATOR)
/rgw/rgw_common.cc: 783 in RGWHTTPArgs::sys_get(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool *)()
777       }
778     }
779     
780     string RGWHTTPArgs::sys_get(const string& name, bool * const exists)
781     {
782       const auto iter = sys_val_map.find(name);
>>>     CID 1353389:  Control flow issues  (MISMATCHED_ITERATOR)
>>>     Comparing "iter" from "this->sys_val_map" to "this->val_map.end()" from "this->val_map".
783       const bool e = (iter != val_map.end());
784     
785       if (exists) {
786         *exists = e;
787       }
788     

** CID 1353388:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_rest_conn.cc: 190 in RGWRESTConn::get_resource(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char
 >>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *, ceph::buffer::list &, RGWHTTPManager *)()


________________________________________________________________________________________________________
*** CID 1353388:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_rest_conn.cc: 190 in RGWRESTConn::get_resource(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char
 >>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> *, ceph::buffer::list &, RGWHTTPManager *)()
184       int ret = get_url(url);
185       if (ret < 0)
186         return ret;
187     
188       param_list_t params;
189     
>>>     CID 1353388:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "extra_params" to null implies that "extra_params" might be null.
190       if (extra_params) {
191         params.insert(params.end(), extra_params->begin(), extra_params->end());
192       }
193     
194       params.push_back(param_pair_t(RGW_SYS_PARAM_PREFIX "zonegroup", self_zone_group));
195     

** CID 1353387:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_sync.cc: 1337 in RGWMetaSyncShardCR::incremental_sync()()


________________________________________________________________________________________________________
*** CID 1353387:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_sync.cc: 1337 in RGWMetaSyncShardCR::incremental_sync()()
1331     
1332       int incremental_sync() {
1333         reenter(&incremental_cr) {
1334           set_status("incremental_sync");
1335           can_adjust_marker = true;
1336           /* grab lock */
>>>     CID 1353387:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "this->lease_cr" to null implies that "this->lease_cr" might be null.
1337           if (!lease_cr) { /* could have had  a lease_cr lock from previous state */
1338             yield {
1339               uint32_t lock_duration = cct->_conf->rgw_sync_lease_period;
1340               string lock_name = "sync_lock";
1341               RGWRados *store = sync_env->store;
1342               lease_cr = new RGWContinuousLeaseCR(sync_env->async_rados, store, pool,

** CID 1353386:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_http_client.cc: 94 in RGWHTTPClient::process(const char *, const char *)()


________________________________________________________________________________________________________
*** CID 1353386:  Null pointer dereferences  (FORWARD_NULL)
/rgw/rgw_http_client.cc: 94 in RGWHTTPClient::process(const char *, const char *)()
88     
89       last_method = (method ? method : "");
90       last_url = (url ? url : "");
91     
92       curl_handle = curl_easy_init();
93     
>>>     CID 1353386:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "url" to "operator <<", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
94       dout(20) << "sending request to " << url << dendl;
95     
96       curl_slist *h = headers_to_slist(headers);
97     
98       curl_easy_setopt(curl_handle, CURLOPT_CUSTOMREQUEST, method);
99       curl_easy_setopt(curl_handle, CURLOPT_URL, url);

** CID 1353385:  Security best practices violations  (DC.WEAK_CRYPTO)
/rgw/rgw_rados.cc: 1432 in fix_zone_pool_name(std::set<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1353385:  Security best practices violations  (DC.WEAK_CRYPTO)
/rgw/rgw_rados.cc: 1432 in fix_zone_pool_name(std::set<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
1426       string name = prefix + suffix;
1427       
1428       if (pool_names.find(name) == pool_names.end()) {
1429         return name;
1430       } else {
1431         while(true) {
>>>     CID 1353385:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1432           name =  prefix + "_" + std::to_string(std::rand()) + suffix;
1433           if (pool_names.find(name) == pool_names.end()) {
1434     	return name;
1435           }
1436         }
1437       }  

** CID 1353384:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_op.cc: 2642 in RGWPutMetadataAccount::execute()()


________________________________________________________________________________________________________
*** CID 1353384:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_op.cc: 2642 in RGWPutMetadataAccount::execute()()
2636       if (op_ret < 0) {
2637         return;
2638       }
2639     
2640       rgw_get_request_metadata(s->cct, s->info, attrs, false);
2641       RGWUserInfo orig_uinfo;
>>>     CID 1353384:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "rgw_get_user_info_by_uid" without checking return value (as is done elsewhere 23 out of 24 times).
2642       rgw_get_user_info_by_uid(store, s->user->user_id, orig_uinfo, &acct_op_tracker);
2643       populate_with_generic_attrs(s, attrs);
2644     
2645       /* Handle the TempURL-related stuff. */
2646       map<int, string> temp_url_keys;
2647       filter_out_temp_url(attrs, rmattr_names, temp_url_keys);

** CID 1353383:    (ATOMICITY)
/rgw/rgw_coroutine.cc: 485 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()
/rgw/rgw_coroutine.cc: 485 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()


________________________________________________________________________________________________________
*** CID 1353383:    (ATOMICITY)
/rgw/rgw_coroutine.cc: 485 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()
479     	}
480           }
481           if (stack->parent && stack->parent->waiting_for_child()) {
482             stack->parent->set_wait_for_child(false);
483             stack->parent->schedule();
484           }
>>>     CID 1353383:    (ATOMICITY)
>>>     Using an unreliable value of "context_stacks" inside the second locked section. If the data that "context_stacks" depends on was changed by another thread, this use might be incorrect.
485           context_stacks.erase(stack);
486           stack->put();
487           stack = NULL;
488         } else {
489           op_not_blocked = true;
490           stack->run_count++;
/rgw/rgw_coroutine.cc: 485 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()
479     	}
480           }
481           if (stack->parent && stack->parent->waiting_for_child()) {
482             stack->parent->set_wait_for_child(false);
483             stack->parent->schedule();
484           }
>>>     CID 1353383:    (ATOMICITY)
>>>     Using an unreliable value of "context_stacks" inside the second locked section. If the data that "context_stacks" depends on was changed by another thread, this use might be incorrect.
485           context_stacks.erase(stack);
486           stack->put();
487           stack = NULL;
488         } else {
489           op_not_blocked = true;
490           stack->run_count++;

** CID 1353433:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/rgw/rgw_data_sync.cc: 2310 in RGWBucketSyncStatusManager::init()()


________________________________________________________________________________________________________
*** CID 1353433:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/rgw/rgw_data_sync.cc: 2310 in RGWBucketSyncStatusManager::init()()
2304         return ret;
2305       }
2306     
2307     
2308       string key = bucket_name + ":" + bucket_id;
2309     
>>>     CID 1353433:  Memory - illegal accesses  (WRAPPER_ESCAPE)
>>>     The internal representation of local "key" escapes into "pairs[pairs@dim0].val", but is destroyed when it exits scope.
2310       rgw_http_param_pair pairs[] = { { "key", key.c_str() },
2311                                       { NULL, NULL } };
2312     
2313       string path = string("/admin/metadata/bucket.instance");
2314     
2315       bucket_instance_meta_info result;

** CID 1353432:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_op.cc: 359 in rgw_build_bucket_policies(RGWRados *, req_state *)()


________________________________________________________________________________________________________
*** CID 1353432:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_op.cc: 359 in rgw_build_bucket_policies(RGWRados *, req_state *)()
353     
354         if (s->bucket_exists) {
355           rgw_obj_key no_obj;
356           ret = read_policy(store, s, s->bucket_info, s->bucket_attrs, s->bucket_acl, s->bucket, no_obj);
357         } else {
358           s->bucket_acl->create_default(s->user->user_id, s->user->display_name);
>>>     CID 1353432:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value "-2002" to "ret" here, but that stored value is overwritten before it can be used.
359           ret = -ERR_NO_SUCH_BUCKET;
360         }
361     
362         s->bucket_owner = s->bucket_acl->get_owner();
363     
364         RGWZoneGroup zonegroup;

** CID 1353431:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_op.cc: 356 in rgw_build_bucket_policies(RGWRados *, req_state *)()


________________________________________________________________________________________________________
*** CID 1353431:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_op.cc: 356 in rgw_build_bucket_policies(RGWRados *, req_state *)()
350           s->bucket_exists = false;
351         }
352         s->bucket = s->bucket_info.bucket;
353     
354         if (s->bucket_exists) {
355           rgw_obj_key no_obj;
>>>     CID 1353431:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "read_policy(store, s, s->bucket_info, s->bucket_attrs, s->bucket_acl, s->bucket, no_obj)" to "ret" here, but that stored value is overwritten before it can be used.
356           ret = read_policy(store, s, s->bucket_info, s->bucket_attrs, s->bucket_acl, s->bucket, no_obj);
357         } else {
358           s->bucket_acl->create_default(s->user->user_id, s->user->display_name);
359           ret = -ERR_NO_SUCH_BUCKET;
360         }
361     

** CID 1353430:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_coroutine.cc: 529 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()


________________________________________________________________________________________________________
*** CID 1353430:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_coroutine.cc: 529 in RGWCoroutinesManager::run(std::list<RGWCoroutinesStack *, std::allocator<RGWCoroutinesStack *>> &)()
523           ret = completion_mgr.get_next((void **)&blocked_stack);
524           if (ret < 0) {
525     	ldout(cct, 0) << "ERROR: failed to clone shard, completion_mgr.get_next() returned ret=" << ret << dendl;
526           }
527           if (going_down.read() > 0) {
528     	ldout(cct, 5) << __func__ << "(): was stopped, exiting" << dendl;
>>>     CID 1353430:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value "-125" to "ret" here, but that stored value is overwritten before it can be used.
529     	ret = -ECANCELED;
530             break;
531           }
532           handle_unblocked_stack(context_stacks, scheduled_stacks, blocked_stack, &blocked_count);
533           iter = scheduled_stacks.begin();
534         }

** CID 1353429:  Control flow issues  (UNREACHABLE)
/build/rados.c: 18788 in __pyx_pf_5rados_12SnapIterator_4__next__()


________________________________________________________________________________________________________
*** CID 1353429:  Control flow issues  (UNREACHABLE)
/build/rados.c: 18788 in __pyx_pf_5rados_12SnapIterator_4__next__()
18782      *             return snap
18783      *         finally:
18784      *             free(name)             # <<<<<<<<<<<<<<
18785      * 
18786      * 
18787      */
>>>     CID 1353429:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L5_error:
 ...".
18788       /*finally:*/ {
18789         /*exception exit:*/{
18790           __pyx_L5_error:;
18791           __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0;
18792           __Pyx_XDECREF(__pyx_t_6); __pyx_t_6 = 0;
18793           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;

** CID 1353428:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 2078 in RGWRados::SystemObject::Read::ReadParams::ReadParams()()


________________________________________________________________________________________________________
*** CID 1353428:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 2078 in RGWRados::SystemObject::Read::ReadParams::ReadParams()()
2072           } stat_params;
2073     
2074           struct ReadParams {
2075             rgw_cache_entry_info *cache_info;
2076             map<string, bufferlist> *attrs;
2077     
>>>     CID 1353428:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "cache_info" is not initialized in this constructor nor in any functions that it calls.
2078             ReadParams() : attrs(NULL) {}
2079           } read_params;
2080     
2081           explicit Read(RGWRados::SystemObject *_source) : source(_source) {}
2082     
2083           int stat(RGWObjVersionTracker *objv_tracker);

** CID 1353427:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 751 in RGWSystemMetaObj::RGWSystemMetaObj()()


________________________________________________________________________________________________________
*** CID 1353427:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 751 in RGWSystemMetaObj::RGWSystemMetaObj()()
745       int read_default(RGWDefaultSystemMetaObjInfo& default_info,
746     		   const string& oid);
747       /* read and use default id */
748       int use_default(bool old_format = false);
749     
750     public:
>>>     CID 1353427:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "store" is not initialized in this constructor nor in any functions that it calls.
751       RGWSystemMetaObj() {}
752       RGWSystemMetaObj(const string& _name): name(_name)  {}
753       RGWSystemMetaObj(const string& _id, const string& _name) : id(_id), name(_name) {}
754       RGWSystemMetaObj(CephContext *_cct, RGWRados *_store): cct(_cct), store(_store){}
755       RGWSystemMetaObj(const string& _name, CephContext *_cct, RGWRados *_store): name(_name), cct(_cct), store(_store){}
756       const string& get_name() const { return name; }

** CID 1353426:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1394 in RGWPeriod::RGWPeriod()()


________________________________________________________________________________________________________
*** CID 1353426:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1394 in RGWPeriod::RGWPeriod()()
1388       const string get_period_oid_prefix();
1389     
1390       // gather the metadata sync status for each shard; only for use on master zone
1391       int update_sync_status();
1392     
1393     public:
>>>     CID 1353426:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "store" is not initialized in this constructor nor in any functions that it calls.
1394       RGWPeriod() : epoch(0) {}
1395     
1396       RGWPeriod(const string& period_id, epoch_t _epoch = 0)
1397         : id(period_id), epoch(_epoch) {}
1398     
1399       const string& get_id() const { return id; }

** CID 1353425:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1088 in RGWZoneGroup::RGWZoneGroup(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1353425:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1088 in RGWZoneGroup::RGWZoneGroup(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
1082       map<string, list<string> > api_endpoints_map;
1083     
1084       string realm_id;
1085     
1086       RGWZoneGroup(): is_master(false){}
1087       RGWZoneGroup(const std::string &id, const std::string &name):RGWSystemMetaObj(id, name) {}
>>>     CID 1353425:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "is_master" is not initialized in this constructor nor in any functions that it calls.
1088       RGWZoneGroup(const std::string &_name):RGWSystemMetaObj(_name) {}
1089       RGWZoneGroup(const std::string &_name, bool _is_master, CephContext *cct, RGWRados* store,
1090     	       const string& _realm_id, const list<string>& _endpoints)
1091         : RGWSystemMetaObj(_name, cct , store), endpoints(_endpoints), is_master(_is_master),
1092           realm_id(_realm_id) {}
1093     

** CID 1353424:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_realm_watcher.cc: 21 in RGWRealmWatcher::RGWRealmWatcher(CephContext *, RGWRealm &)()


________________________________________________________________________________________________________
*** CID 1353424:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_realm_watcher.cc: 21 in RGWRealmWatcher::RGWRealmWatcher(CephContext *, RGWRealm &)()
15     RGWRealmWatcher::RGWRealmWatcher(CephContext* cct, RGWRealm& realm)
16       : cct(cct)
17     {
18       // no default realm, nothing to watch
19       if (realm.get_id().empty()) {
20         ldout(cct, 4) << "No realm, disabling dynamic reconfiguration." << dendl;
>>>     CID 1353424:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "watch_handle" is not initialized in this constructor nor in any functions that it calls.
21         return;
22       }
23     
24       // establish the watch on RGWRealm
25       int r = watch_start(realm);
26       if (r < 0) {

** CID 1353423:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1087 in RGWZoneGroup::RGWZoneGroup(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1353423:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_rados.h: 1087 in RGWZoneGroup::RGWZoneGroup(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
1081       map<string, list<string> > api_hostname_map;
1082       map<string, list<string> > api_endpoints_map;
1083     
1084       string realm_id;
1085     
1086       RGWZoneGroup(): is_master(false){}
>>>     CID 1353423:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "is_master" is not initialized in this constructor nor in any functions that it calls.
1087       RGWZoneGroup(const std::string &id, const std::string &name):RGWSystemMetaObj(id, name) {}
1088       RGWZoneGroup(const std::string &_name):RGWSystemMetaObj(_name) {}
1089       RGWZoneGroup(const std::string &_name, bool _is_master, CephContext *cct, RGWRados* store,
1090     	       const string& _realm_id, const list<string>& _endpoints)
1091         : RGWSystemMetaObj(_name, cct , store), endpoints(_endpoints), is_master(_is_master),
1092           realm_id(_realm_id) {}


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

