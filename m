From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 27 Feb 2016 10:07:16 -0800
Message-ID: <56d1e5d48e29d_6f0aabd330944fd@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42703 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992461AbcB0SHB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Feb 2016 13:07:01 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 238DC24E121D
	for <ceph-devel@vger.kernel.org>; Sat, 27 Feb 2016 10:07:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

52 new defect(s) introduced to ceph found with Coverity Scan.
39 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 52 defect(s)


** CID 716871:  Error handling issues  (CHECKED_RETURN)
/test/multi_stress_watch.cc: 157 in main()


________________________________________________________________________________________________________
*** CID 716871:  Error handling issues  (CHECKED_RETURN)
/test/multi_stress_watch.cc: 157 in main()
151       }
152       ret = cluster.conf_parse_env(NULL);
153       if (ret) {
154         std::cerr << "Error " << ret << " in cluster.conf_read_env" << std::endl;
155         return ret;
156       }
>>>     CID 716871:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 20 out of 25 times).
157       cluster.connect();
158     
159       if (type == "rep")
160         test_replicated(cluster, pool_name, obj_name);
161       else if (type == "ec")
162         test_erasure(cluster, pool_name, obj_name);
163     
164       sem_destroy(&sem);
165       return 0;

** CID 1219460:  Error handling issues  (CHECKED_RETURN)
/tools/cephfs/JournalTool.cc: 112 in JournalTool::main(std::vector<const char *, std::allocator<const char *>> &)()


________________________________________________________________________________________________________
*** CID 1219460:  Error handling issues  (CHECKED_RETURN)
/tools/cephfs/JournalTool.cc: 112 in JournalTool::main(std::vector<const char *, std::allocator<const char *>> &)()
106       if (r < 0) {
107         derr << "RADOS unavailable, cannot scan filesystem journal" << dendl;
108         return r;
109       }
110     
111       dout(4) << "JournalTool: connecting to RADOS..." << dendl;
>>>     CID 1219460:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 20 out of 25 times).
112       rados.connect();
113      
114       int const pool_id = mdsmap->get_metadata_pool();
115       dout(4) << "JournalTool: resolving pool " << pool_id << dendl;
116       std::string pool_name;
117       r = rados.pool_reverse_lookup(pool_id, &pool_name);

** CID 1354430:  Error handling issues  (CHECKED_RETURN)
/tools/cephfs/TableTool.cc: 318 in TableTool::main(std::vector<const char *, std::allocator<const char *>> &)()


________________________________________________________________________________________________________
*** CID 1354430:  Error handling issues  (CHECKED_RETURN)
/tools/cephfs/TableTool.cc: 318 in TableTool::main(std::vector<const char *, std::allocator<const char *>> &)()
312       if (r < 0) {
313         derr << "RADOS unavailable, cannot scan filesystem journal" << dendl;
314         return r;
315       }
316     
317       dout(4) << "connecting to RADOS..." << dendl;
>>>     CID 1354430:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 20 out of 25 times).
318       rados.connect();
319      
320       int const pool_id = mdsmap->get_metadata_pool();
321       dout(4) << "resolving pool " << pool_id << dendl;
322       std::string pool_name;
323       r = rados.pool_reverse_lookup(pool_id, &pool_name);

** CID 1354431:  Error handling issues  (CHECKED_RETURN)
/test/rbd_mirror/test_PoolWatcher.cc: 157 in TestPoolWatcher::clone_image(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()


________________________________________________________________________________________________________
*** CID 1354431:  Error handling issues  (CHECKED_RETURN)
/test/rbd_mirror/test_PoolWatcher.cc: 157 in TestPoolWatcher::clone_image(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
151         ASSERT_EQ(0, m_cluster->ioctx_create(clone_pool_name.c_str(), cioctx));
152     
153         string snap_name = "snap" + stringify(++m_snap_number);
154         {
155           librbd::ImageCtx *ictx = new librbd::ImageCtx(parent_image_name.c_str(),
156     						    "", "", pioctx, false);
>>>     CID 1354431:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "open" without checking return value (as is done elsewhere 8 out of 9 times).
157           ictx->state->open();
158           EXPECT_EQ(0, ictx->operations->snap_create(snap_name.c_str()));
159           EXPECT_EQ(0, ictx->operations->snap_protect(snap_name.c_str()));
160           ictx->state->close();
161         }
162     

** CID 1354432:  Error handling issues  (CHECKED_RETURN)
/tools/rados/RadosImport.cc: 45 in RadosImport::import(std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool)()


________________________________________________________________________________________________________
*** CID 1354432:  Error handling issues  (CHECKED_RETURN)
/tools/rados/RadosImport.cc: 45 in RadosImport::import(std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool)()
39       }
40       ret = cluster.conf_parse_env(NULL);
41       if (ret) {
42         cerr << "Error " << ret << " in cluster.conf_read_env" << std::endl;
43         return ret;
44       }
>>>     CID 1354432:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 20 out of 25 times).
45       cluster.connect();
46     
47       ret = cluster.ioctx_create(pool.c_str(), ioctx);
48       if (ret < 0) {
49         cerr << "ioctx_create " << pool << " failed with " << ret << std::endl;
50         return ret;

** CID 1354433:  Security best practices violations  (DC.WEAK_CRYPTO)
/osd/PGBackend.cc: 671 in PGBackend::be_compare_scrubmaps(const std::map<pg_shard_t, ScrubMap *, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, ScrubMap *>>> &, bool, bool, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::list<pg_shard_t, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pai
 r<const hobject_t, std::list<pg_shard_t, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::pair<unsigned int, unsigned int>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobj
 ect_t, std::pair<unsigned int, unsigned int>>>>&, int &, int &, Scrub::Store *, const spg_t &, const std::vector<int, std::allocator<int>> &, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1354433:  Security best practices violations  (DC.WEAK_CRYPTO)
/osd/PGBackend.cc: 671 in PGBackend::be_compare_scrubmaps(const std::map<pg_shard_t, ScrubMap *, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, ScrubMap *>>> &, bool, bool, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::list<pg_shard_t, std::allocator<pg_shard_t>>, hobject_t::BitwiseComparator, std::allocator<std::pai
 r<const hobject_t, std::list<pg_shard_t, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::pair<unsigned int, unsigned int>, hobject_t::BitwiseComparator, std::allocator<std::pair<const hobj
 ect_t, std::pair<unsigned int, unsigned int>>>>&, int &, int &, Scrub::Store *, const spg_t &, const std::vector<int, std::allocator<int>> &, std::basic_ostream<char, std::char_traits<char>>&)()
665     	  (!auth_oi.is_data_digest() || !auth_oi.is_omap_digest())) {
666     	dout(20) << __func__ << " missing digest on " << *k << dendl;
667     	update = MAYBE;
668           }
669           if (auth_object.digest_present && auth_object.omap_digest_present &&
670     	  g_conf->osd_debug_scrub_chance_rewrite_digest &&
>>>     CID 1354433:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
671     	  (((unsigned)rand() % 100) >
672     	   g_conf->osd_debug_scrub_chance_rewrite_digest)) {
673     	dout(20) << __func__ << " randomly updating digest on " << *k << dendl;
674     	update = MAYBE;
675           }
676     

** CID 1354434:  Security best practices violations  (DC.WEAK_CRYPTO)
/msg/async/AsyncConnection.cc: 354 in AsyncConnection::_try_send(bool, bool)()


________________________________________________________________________________________________________
*** CID 1354434:  Security best practices violations  (DC.WEAK_CRYPTO)
/msg/async/AsyncConnection.cc: 354 in AsyncConnection::_try_send(bool, bool)()
348     ssize_t AsyncConnection::_try_send(bool send, bool more)
349     {
350       if (!send)
351         return 0;
352     
353       if (async_msgr->cct->_conf->ms_inject_socket_failures && sd >= 0) {
>>>     CID 1354434:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
354         if (rand() % async_msgr->cct->_conf->ms_inject_socket_failures == 0) {
355           ldout(async_msgr->cct, 0) << __func__ << " injecting socket failure" << dendl;
356           ::shutdown(sd, SHUT_RDWR);
357         }
358       }
359     

** CID 1354435:    (DC.WEAK_CRYPTO)
/common/WeightedPriorityQueue.h: 175 in WeightedPriorityQueue<std::pair<boost::intrusive_ptr<PG>, PGQueueable>, entity_inst_t>::Queue::pop(bool)()
/common/WeightedPriorityQueue.h: 190 in WeightedPriorityQueue<std::pair<boost::intrusive_ptr<PG>, PGQueueable>, entity_inst_t>::Queue::pop(bool)()


________________________________________________________________________________________________________
*** CID 1354435:    (DC.WEAK_CRYPTO)
/common/WeightedPriorityQueue.h: 175 in WeightedPriorityQueue<std::pair<boost::intrusive_ptr<PG>, PGQueueable>, entity_inst_t>::Queue::pop(bool)()
169     	    }
170     	    return ret;
171     	  }
172     	  if (queues.size() > 1) {
173     	    while (true) {
174     	      // Pick a new priority out of the total priority.
>>>     CID 1354435:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
175     	      unsigned prio = rand() % total_prio + 1;
176     	      unsigned tp = total_prio - i->key;
177     	      // Find the priority coresponding to the picked number.
178     	      // Subtract high priorities to low priorities until the picked number
179     	      // is more than the total and try to dequeue that priority.
180     	      // Reverse the direction from previous implementation because there is a higher
/common/WeightedPriorityQueue.h: 190 in WeightedPriorityQueue<std::pair<boost::intrusive_ptr<PG>, PGQueueable>, entity_inst_t>::Queue::pop(bool)()
184     		tp -= i->key;
185     	      }
186     	      // Flip a coin to see if this priority gets to run based on cost.
187     	      // The next op's cost is multiplied by .9 and subtracted from the
188     	      // max cost seen. Ops with lower costs will have a larger value
189     	      // and allow them to be selected easier than ops with high costs.
>>>     CID 1354435:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
190     	      if (max_cost == 0 || rand() % max_cost <=
191     		  (max_cost - ((i->get_cost() * 9) / 10))) {
192     		break;
193     	      }
194     	      i = --queues.end();
195     	    }

** CID 1354436:  Compiler dependency  (DELETE_ARRAY)
/log/Log.cc: 318 in ceph::log::Log::_flush(ceph::log::EntryQueue *, ceph::log::EntryQueue *, bool)()


________________________________________________________________________________________________________
*** CID 1354436:  Compiler dependency  (DELETE_ARRAY)
/log/Log.cc: 318 in ceph::log::Log::_flush(ceph::log::EntryQueue *, ceph::log::EntryQueue *, bool)()
312             buf[buflen] = '\n';
313             int r = safe_write(m_fd, buf, buflen+1);
314             if (r < 0)
315               cerr << "problem writing to " << m_log_file << ": " << cpp_strerror(r) << std::endl;
316           }
317           if(need_dynamic)
>>>     CID 1354436:  Compiler dependency  (DELETE_ARRAY)
>>>     Deleting array variable "buf" with non-array delete in "delete buf".
318             delete buf;
319         }
320         if (do_graylog2 && m_graylog) {
321           m_graylog->log_entry(e);
322         }
323     

** CID 1354437:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13185 in __pyx_pw_5rados_5Rados_51mon_command()


________________________________________________________________________________________________________
*** CID 1354437:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13185 in __pyx_pw_5rados_5Rados_51mon_command()
13179           }
13180           kw_args = PyDict_Size(__pyx_kwds);
13181           switch (pos_args) {
13182             case  0:
13183             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
13184             else goto __pyx_L5_argtuple_error;
>>>     CID 1354437:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13185             case  1:
13186             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
13187             else {
13188               __Pyx_RaiseArgtupleInvalid("mon_command", 0, 2, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1110; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13189             }
13190             case  2:

** CID 1354438:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13190 in __pyx_pw_5rados_5Rados_51mon_command()


________________________________________________________________________________________________________
*** CID 1354438:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13190 in __pyx_pw_5rados_5Rados_51mon_command()
13184             else goto __pyx_L5_argtuple_error;
13185             case  1:
13186             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
13187             else {
13188               __Pyx_RaiseArgtupleInvalid("mon_command", 0, 2, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1110; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13189             }
>>>     CID 1354438:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13190             case  2:
13191             if (kw_args > 0) {
13192               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_timeout);
13193               if (value) { values[2] = value; kw_args--; }
13194             }
13195             case  3:

** CID 1354439:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13195 in __pyx_pw_5rados_5Rados_51mon_command()


________________________________________________________________________________________________________
*** CID 1354439:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13195 in __pyx_pw_5rados_5Rados_51mon_command()
13189             }
13190             case  2:
13191             if (kw_args > 0) {
13192               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_timeout);
13193               if (value) { values[2] = value; kw_args--; }
13194             }
>>>     CID 1354439:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13195             case  3:
13196             if (kw_args > 0) {
13197               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_target);
13198               if (value) { values[3] = value; kw_args--; }
13199             }
13200           }

** CID 1354440:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13828 in __pyx_pw_5rados_5Rados_53osd_command()


________________________________________________________________________________________________________
*** CID 1354440:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13828 in __pyx_pw_5rados_5Rados_53osd_command()
13822           }
13823           kw_args = PyDict_Size(__pyx_kwds);
13824           switch (pos_args) {
13825             case  0:
13826             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_osdid)) != 0)) kw_args--;
13827             else goto __pyx_L5_argtuple_error;
>>>     CID 1354440:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13828             case  1:
13829             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
13830             else {
13831               __Pyx_RaiseArgtupleInvalid("osd_command", 0, 3, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1167; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13832             }
13833             case  2:

** CID 1354441:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13833 in __pyx_pw_5rados_5Rados_53osd_command()


________________________________________________________________________________________________________
*** CID 1354441:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13833 in __pyx_pw_5rados_5Rados_53osd_command()
13827             else goto __pyx_L5_argtuple_error;
13828             case  1:
13829             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
13830             else {
13831               __Pyx_RaiseArgtupleInvalid("osd_command", 0, 3, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1167; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13832             }
>>>     CID 1354441:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13833             case  2:
13834             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
13835             else {
13836               __Pyx_RaiseArgtupleInvalid("osd_command", 0, 3, 4, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1167; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13837             }
13838             case  3:

** CID 1354442:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13838 in __pyx_pw_5rados_5Rados_53osd_command()


________________________________________________________________________________________________________
*** CID 1354442:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 13838 in __pyx_pw_5rados_5Rados_53osd_command()
13832             }
13833             case  2:
13834             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
13835             else {
13836               __Pyx_RaiseArgtupleInvalid("osd_command", 0, 3, 4, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1167; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
13837             }
>>>     CID 1354442:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13838             case  3:
13839             if (kw_args > 0) {
13840               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_timeout);
13841               if (value) { values[3] = value; kw_args--; }
13842             }
13843           }

** CID 1354443:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14351 in __pyx_pw_5rados_5Rados_55pg_command()


________________________________________________________________________________________________________
*** CID 1354443:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14351 in __pyx_pw_5rados_5Rados_55pg_command()
14345           }
14346           kw_args = PyDict_Size(__pyx_kwds);
14347           switch (pos_args) {
14348             case  0:
14349             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_pgid)) != 0)) kw_args--;
14350             else goto __pyx_L5_argtuple_error;
>>>     CID 1354443:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
14351             case  1:
14352             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
14353             else {
14354               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1210; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
14355             }
14356             case  2:

** CID 1354444:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14356 in __pyx_pw_5rados_5Rados_55pg_command()


________________________________________________________________________________________________________
*** CID 1354444:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14356 in __pyx_pw_5rados_5Rados_55pg_command()
14350             else goto __pyx_L5_argtuple_error;
14351             case  1:
14352             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cmd)) != 0)) kw_args--;
14353             else {
14354               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1210; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
14355             }
>>>     CID 1354444:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
14356             case  2:
14357             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
14358             else {
14359               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1210; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
14360             }
14361             case  3:

** CID 1354445:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14361 in __pyx_pw_5rados_5Rados_55pg_command()


________________________________________________________________________________________________________
*** CID 1354445:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 14361 in __pyx_pw_5rados_5Rados_55pg_command()
14355             }
14356             case  2:
14357             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_inbuf)) != 0)) kw_args--;
14358             else {
14359               __Pyx_RaiseArgtupleInvalid("pg_command", 0, 3, 4, 2); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1210; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
14360             }
>>>     CID 1354445:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
14361             case  3:
14362             if (kw_args > 0) {
14363               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_timeout);
14364               if (value) { values[3] = value; kw_args--; }
14365             }
14366           }

** CID 1354446:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 15034 in __pyx_pw_5rados_5Rados_59blacklist_add()


________________________________________________________________________________________________________
*** CID 1354446:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 15034 in __pyx_pw_5rados_5Rados_59blacklist_add()
15028           }
15029           kw_args = PyDict_Size(__pyx_kwds);
15030           switch (pos_args) {
15031             case  0:
15032             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client_address)) != 0)) kw_args--;
15033             else goto __pyx_L5_argtuple_error;
>>>     CID 1354446:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
15034             case  1:
15035             if (kw_args > 0) {
15036               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_expire_seconds);
15037               if (value) { values[1] = value; kw_args--; }
15038             }
15039           }

** CID 1354447:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 15298 in __pyx_pw_5rados_5Rados_61monitor_log()


________________________________________________________________________________________________________
*** CID 1354447:  Control flow issues  (MISSING_BREAK)
/build/rados.c: 15298 in __pyx_pw_5rados_5Rados_61monitor_log()
15292           }
15293           kw_args = PyDict_Size(__pyx_kwds);
15294           switch (pos_args) {
15295             case  0:
15296             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_level)) != 0)) kw_args--;
15297             else goto __pyx_L5_argtuple_error;
>>>     CID 1354447:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
15298             case  1:
15299             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_callback)) != 0)) kw_args--;
15300             else {
15301               __Pyx_RaiseArgtupleInvalid("monitor_log", 1, 3, 3, 1); {__pyx_filename = __pyx_f[0]; __pyx_lineno = 1282; __pyx_clineno = __LINE__; goto __pyx_L3_error;}
15302             }
15303             case  2:


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

