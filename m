From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 05 Feb 2017 02:08:17 -0800
Message-ID: <5896f9918a123_3aabc3f3343035f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:52654 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751774AbdBEKIT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Feb 2017 05:08:19 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id XTvw19yqTZCsz6G8ORdQSg
        for <ceph-devel@vger.kernel.org>; Sun, 05 Feb 2017 10:08:17.602 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

32 new defect(s) introduced to ceph found with Coverity Scan.
33 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 32 defect(s)


** CID 1400089:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.cc: 8735 in OSD::handle_op(boost::intrusive_ptr<OpRequest> &, std::shared_ptr<const OSDMap> &)()


________________________________________________________________________________________________________
*** CID 1400089:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/OSD.cc: 8735 in OSD::handle_op(boost::intrusive_ptr<OpRequest> &, std::shared_ptr<const OSDMap> &)()
8729       if (client_session) {
8730         client_session->put();
8731       }
8732     
8733       if (cct->_conf->osd_debug_drop_op_probability > 0 &&
8734           !m->get_source().is_mds()) {
>>>     CID 1400089:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
8735         if ((double)rand() / (double)RAND_MAX < cct->_conf->osd_debug_drop_op_probability) {
8736           dout(0) << "handle_op DEBUG artificially dropping op " << *m << dendl;
8737           return;
8738         }
8739       }
8740     

** CID 1400090:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/mon/LogMonitor.cc: 378 in LogMonitor::preprocess_command(boost::intrusive_ptr<MonOpRequest>)()


________________________________________________________________________________________________________
*** CID 1400090:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/mon/LogMonitor.cc: 378 in LogMonitor::preprocess_command(boost::intrusive_ptr<MonOpRequest>)()
372       op->mark_logmon_event("preprocess_command");
373       int r = -1;
374       bufferlist rdata;
375       stringstream ss;
376     
377       if (r != -1) {
>>>     CID 1400090:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "rs.basic_string();".
378         string rs;
379         getline(ss, rs);
380         mon->reply_command(op, r, rs, rdata, get_last_committed());
381         return true;
382       } else
383         return false;

** CID 1400091:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1157 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1162 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1156 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1166 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1344 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1349 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1343 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1353 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()


________________________________________________________________________________________________________
*** CID 1400091:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1157 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1151     
1152     	  hobject_t candidate;
1153     	  if (mcand == lcand) {
1154     	    candidate = mcand;
1155     	    if (!mcand.is_max()) {
1156     	      ++ls_iter;
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1157     	      ++missing_iter;
1158     	    }
1159     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1160     	    candidate = mcand;
1161     	    assert(!mcand.is_max());
1162     	    ++missing_iter;
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1162 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1156     	      ++ls_iter;
1157     	      ++missing_iter;
1158     	    }
1159     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1160     	    candidate = mcand;
1161     	    assert(!mcand.is_max());
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1162     	    ++missing_iter;
1163     	  } else {
1164     	    candidate = lcand;
1165     	    assert(!lcand.is_max());
1166     	    ++ls_iter;
1167     	  }
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1156 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1150     	    *ls_iter;
1151     
1152     	  hobject_t candidate;
1153     	  if (mcand == lcand) {
1154     	    candidate = mcand;
1155     	    if (!mcand.is_max()) {
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1156     	      ++ls_iter;
1157     	      ++missing_iter;
1158     	    }
1159     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1160     	    candidate = mcand;
1161     	    assert(!mcand.is_max());
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1166 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1160     	    candidate = mcand;
1161     	    assert(!mcand.is_max());
1162     	    ++missing_iter;
1163     	  } else {
1164     	    candidate = lcand;
1165     	    assert(!lcand.is_max());
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1166     	    ++ls_iter;
1167     	  }
1168     
1169               dout(10) << " pgnls candidate 0x" << std::hex << candidate.get_hash()
1170                 << " vs lower bound 0x" << lower_bound.get_hash() << dendl;
1171     
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1344 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1338     
1339     	  hobject_t candidate;
1340     	  if (mcand == lcand) {
1341     	    candidate = mcand;
1342     	    if (!mcand.is_max()) {
1343     	      ++ls_iter;
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1344     	      ++missing_iter;
1345     	    }
1346     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1347     	    candidate = mcand;
1348     	    assert(!mcand.is_max());
1349     	    ++missing_iter;
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1349 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1343     	      ++ls_iter;
1344     	      ++missing_iter;
1345     	    }
1346     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1347     	    candidate = mcand;
1348     	    assert(!mcand.is_max());
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1349     	    ++missing_iter;
1350     	  } else {
1351     	    candidate = lcand;
1352     	    assert(!lcand.is_max());
1353     	    ++ls_iter;
1354     	  }
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1343 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1337     	    *ls_iter;
1338     
1339     	  hobject_t candidate;
1340     	  if (mcand == lcand) {
1341     	    candidate = mcand;
1342     	    if (!mcand.is_max()) {
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1343     	      ++ls_iter;
1344     	      ++missing_iter;
1345     	    }
1346     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1347     	    candidate = mcand;
1348     	    assert(!mcand.is_max());
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1353 in PrimaryLogPG::do_pg_op(boost::intrusive_ptr<OpRequest>)()
1347     	    candidate = mcand;
1348     	    assert(!mcand.is_max());
1349     	    ++missing_iter;
1350     	  } else {
1351     	    candidate = lcand;
1352     	    assert(!lcand.is_max());
>>>     CID 1400091:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1353     	    ++ls_iter;
1354     	  }
1355     
1356     	  if (cmp(candidate, next, get_sort_bitwise()) >= 0) {
1357     	    break;
1358     	  }

** CID 1400092:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/mds/Locker.cc: 474 in Locker::acquire_locks(boost::intrusive_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
/home/brad/working/src/ceph/src/mds/Locker.cc: 474 in Locker::acquire_locks(boost::intrusive_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()


________________________________________________________________________________________________________
*** CID 1400092:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/mds/Locker.cc: 474 in Locker::acquire_locks(boost::intrusive_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
468     	dout(10) << " already rdlocked " << *have << " " << *have->get_parent() << dendl;
469     	continue;
470           }
471         }
472         
473         // hose any stray locks
>>>     CID 1400092:    (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "existing" though it is already past the end of its container.
474         if (*existing == *p) {
475           assert(need_wrlock || need_remote_wrlock);
476           SimpleLock *lock = *existing;
477           if (mdr->wrlocks.count(lock)) {
478     	if (!need_wrlock)
479     	  dout(10) << " unlocking extra " << *lock << " " << *lock->get_parent() << dendl;
/home/brad/working/src/ceph/src/mds/Locker.cc: 474 in Locker::acquire_locks(boost::intrusive_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
468     	dout(10) << " already rdlocked " << *have << " " << *have->get_parent() << dendl;
469     	continue;
470           }
471         }
472         
473         // hose any stray locks
>>>     CID 1400092:    (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "existing" though it is already past the end of its container.
474         if (*existing == *p) {
475           assert(need_wrlock || need_remote_wrlock);
476           SimpleLock *lock = *existing;
477           if (mdr->wrlocks.count(lock)) {
478     	if (!need_wrlock)
479     	  dout(10) << " unlocking extra " << *lock << " " << *lock->get_parent() << dendl;

** CID 1400093:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21967 in __pyx_pw_3rbd_5Image_99lock_break()


________________________________________________________________________________________________________
*** CID 1400093:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 21967 in __pyx_pw_3rbd_5Image_99lock_break()
21961           }
21962           kw_args = PyDict_Size(__pyx_kwds);
21963           switch (pos_args) {
21964             case  0:
21965             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_mode)) != 0)) kw_args--;
21966             else goto __pyx_L5_argtuple_error;
>>>     CID 1400093:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
21967             case  1:
21968             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_lock_owner)) != 0)) kw_args--;
21969             else {
21970               __Pyx_RaiseArgtupleInvalid("lock_break", 1, 2, 2, 1); __PYX_ERR(0, 2118, __pyx_L3_error)
21971             }
21972           }

** CID 1400094:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25768 in __pyx_pw_3rbd_5Image_127aio_discard()


________________________________________________________________________________________________________
*** CID 1400094:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25768 in __pyx_pw_3rbd_5Image_127aio_discard()
25762           }
25763           kw_args = PyDict_Size(__pyx_kwds);
25764           switch (pos_args) {
25765             case  0:
25766             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
25767             else goto __pyx_L5_argtuple_error;
>>>     CID 1400094:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25768             case  1:
25769             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
25770             else {
25771               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 1); __PYX_ERR(0, 2417, __pyx_L3_error)
25772             }
25773             case  2:

** CID 1400095:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22873 in __pyx_pw_3rbd_5Image_107break_lock()


________________________________________________________________________________________________________
*** CID 1400095:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 22873 in __pyx_pw_3rbd_5Image_107break_lock()
22867           }
22868           kw_args = PyDict_Size(__pyx_kwds);
22869           switch (pos_args) {
22870             case  0:
22871             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_client)) != 0)) kw_args--;
22872             else goto __pyx_L5_argtuple_error;
>>>     CID 1400095:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
22873             case  1:
22874             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_cookie)) != 0)) kw_args--;
22875             else {
22876               __Pyx_RaiseArgtupleInvalid("break_lock", 1, 2, 2, 1); __PYX_ERR(0, 2177, __pyx_L3_error)
22877             }
22878           }

** CID 1400096:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18714 in __pyx_pw_3rbd_5Image_71diff_iterate()


________________________________________________________________________________________________________
*** CID 1400096:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18714 in __pyx_pw_3rbd_5Image_71diff_iterate()
18708           }
18709           kw_args = PyDict_Size(__pyx_kwds);
18710           switch (pos_args) {
18711             case  0:
18712             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
18713             else goto __pyx_L5_argtuple_error;
>>>     CID 1400096:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18714             case  1:
18715             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
18716             else {
18717               __Pyx_RaiseArgtupleInvalid("diff_iterate", 0, 4, 6, 1); __PYX_ERR(0, 1837, __pyx_L3_error)
18718             }
18719             case  2:

** CID 1400097:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19480 in __pyx_pw_3rbd_5Image_75discard()


________________________________________________________________________________________________________
*** CID 1400097:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19480 in __pyx_pw_3rbd_5Image_75discard()
19474           }
19475           kw_args = PyDict_Size(__pyx_kwds);
19476           switch (pos_args) {
19477             case  0:
19478             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
19479             else goto __pyx_L5_argtuple_error;
>>>     CID 1400097:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
19480             case  1:
19481             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
19482             else {
19483               __Pyx_RaiseArgtupleInvalid("discard", 1, 2, 2, 1); __PYX_ERR(0, 1930, __pyx_L3_error)
19484             }
19485           }

** CID 1400098:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19036 in __pyx_pw_3rbd_5Image_73write()


________________________________________________________________________________________________________
*** CID 1400098:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19036 in __pyx_pw_3rbd_5Image_73write()
19030           }
19031           kw_args = PyDict_Size(__pyx_kwds);
19032           switch (pos_args) {
19033             case  0:
19034             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
19035             else goto __pyx_L5_argtuple_error;
>>>     CID 1400098:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
19036             case  1:
19037             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
19038             else {
19039               __Pyx_RaiseArgtupleInvalid("write", 0, 2, 3, 1); __PYX_ERR(0, 1895, __pyx_L3_error)
19040             }
19041             case  2:

** CID 1400099:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24657 in __pyx_pw_3rbd_5Image_123aio_read()


________________________________________________________________________________________________________
*** CID 1400099:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24657 in __pyx_pw_3rbd_5Image_123aio_read()
24651             }
24652             case  2:
24653             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
24654             else {
24655               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 2); __PYX_ERR(0, 2316, __pyx_L3_error)
24656             }
>>>     CID 1400099:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24657             case  3:
24658             if (kw_args > 0) {
24659               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
24660               if (value) { values[3] = value; kw_args--; }
24661             }
24662           }

** CID 1400100:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25334 in __pyx_pw_3rbd_5Image_125aio_write()


________________________________________________________________________________________________________
*** CID 1400100:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25334 in __pyx_pw_3rbd_5Image_125aio_write()
25328           }
25329           kw_args = PyDict_Size(__pyx_kwds);
25330           switch (pos_args) {
25331             case  0:
25332             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_data)) != 0)) kw_args--;
25333             else goto __pyx_L5_argtuple_error;
>>>     CID 1400100:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25334             case  1:
25335             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
25336             else {
25337               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 1); __PYX_ERR(0, 2371, __pyx_L3_error)
25338             }
25339             case  2:

** CID 1400101:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25773 in __pyx_pw_3rbd_5Image_127aio_discard()


________________________________________________________________________________________________________
*** CID 1400101:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25773 in __pyx_pw_3rbd_5Image_127aio_discard()
25767             else goto __pyx_L5_argtuple_error;
25768             case  1:
25769             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
25770             else {
25771               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 1); __PYX_ERR(0, 2417, __pyx_L3_error)
25772             }
>>>     CID 1400101:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25773             case  2:
25774             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
25775             else {
25776               __Pyx_RaiseArgtupleInvalid("aio_discard", 1, 3, 3, 2); __PYX_ERR(0, 2417, __pyx_L3_error)
25777             }
25778           }

** CID 1400102:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18734 in __pyx_pw_3rbd_5Image_71diff_iterate()


________________________________________________________________________________________________________
*** CID 1400102:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18734 in __pyx_pw_3rbd_5Image_71diff_iterate()
18728             }
18729             case  4:
18730             if (kw_args > 0) {
18731               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_include_parent);
18732               if (value) { values[4] = value; kw_args--; }
18733             }
>>>     CID 1400102:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18734             case  5:
18735             if (kw_args > 0) {
18736               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_whole_object);
18737               if (value) { values[5] = value; kw_args--; }
18738             }
18739           }

** CID 1400103:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19041 in __pyx_pw_3rbd_5Image_73write()


________________________________________________________________________________________________________
*** CID 1400103:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 19041 in __pyx_pw_3rbd_5Image_73write()
19035             else goto __pyx_L5_argtuple_error;
19036             case  1:
19037             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
19038             else {
19039               __Pyx_RaiseArgtupleInvalid("write", 0, 2, 3, 1); __PYX_ERR(0, 1895, __pyx_L3_error)
19040             }
>>>     CID 1400103:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
19041             case  2:
19042             if (kw_args > 0) {
19043               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
19044               if (value) { values[2] = value; kw_args--; }
19045             }
19046           }

** CID 1400104:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18729 in __pyx_pw_3rbd_5Image_71diff_iterate()


________________________________________________________________________________________________________
*** CID 1400104:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18729 in __pyx_pw_3rbd_5Image_71diff_iterate()
18723             }
18724             case  3:
18725             if (likely((values[3] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_iterate_cb)) != 0)) kw_args--;
18726             else {
18727               __Pyx_RaiseArgtupleInvalid("diff_iterate", 0, 4, 6, 3); __PYX_ERR(0, 1837, __pyx_L3_error)
18728             }
>>>     CID 1400104:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18729             case  4:
18730             if (kw_args > 0) {
18731               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_include_parent);
18732               if (value) { values[4] = value; kw_args--; }
18733             }
18734             case  5:

** CID 1400105:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24647 in __pyx_pw_3rbd_5Image_123aio_read()


________________________________________________________________________________________________________
*** CID 1400105:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24647 in __pyx_pw_3rbd_5Image_123aio_read()
24641           }
24642           kw_args = PyDict_Size(__pyx_kwds);
24643           switch (pos_args) {
24644             case  0:
24645             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_offset)) != 0)) kw_args--;
24646             else goto __pyx_L5_argtuple_error;
>>>     CID 1400105:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24647             case  1:
24648             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
24649             else {
24650               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2316, __pyx_L3_error)
24651             }
24652             case  2:

** CID 1400106:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18318 in __pyx_pw_3rbd_5Image_69read()


________________________________________________________________________________________________________
*** CID 1400106:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 18318 in __pyx_pw_3rbd_5Image_69read()
18312             else goto __pyx_L5_argtuple_error;
18313             case  1:
18314             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
18315             else {
18316               __Pyx_RaiseArgtupleInvalid("read", 0, 2, 3, 1); __PYX_ERR(0, 1792, __pyx_L3_error)
18317             }
>>>     CID 1400106:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
18318             case  2:
18319             if (kw_args > 0) {
18320               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
18321               if (value) { values[2] = value; kw_args--; }
18322             }
18323           }

** CID 1400107:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24652 in __pyx_pw_3rbd_5Image_123aio_read()


________________________________________________________________________________________________________
*** CID 1400107:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 24652 in __pyx_pw_3rbd_5Image_123aio_read()
24646             else goto __pyx_L5_argtuple_error;
24647             case  1:
24648             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_length)) != 0)) kw_args--;
24649             else {
24650               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 1); __PYX_ERR(0, 2316, __pyx_L3_error)
24651             }
>>>     CID 1400107:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
24652             case  2:
24653             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
24654             else {
24655               __Pyx_RaiseArgtupleInvalid("aio_read", 0, 3, 4, 2); __PYX_ERR(0, 2316, __pyx_L3_error)
24656             }
24657             case  3:

** CID 1400108:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25344 in __pyx_pw_3rbd_5Image_125aio_write()


________________________________________________________________________________________________________
*** CID 1400108:  Control flow issues  (MISSING_BREAK)
/src/pybind/rbd/rbd.c: 25344 in __pyx_pw_3rbd_5Image_125aio_write()
25338             }
25339             case  2:
25340             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_oncomplete)) != 0)) kw_args--;
25341             else {
25342               __Pyx_RaiseArgtupleInvalid("aio_write", 0, 3, 4, 2); __PYX_ERR(0, 2371, __pyx_L3_error)
25343             }
>>>     CID 1400108:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
25344             case  3:
25345             if (kw_args > 0) {
25346               PyObject* value = PyDict_GetItem(__pyx_kwds, __pyx_n_s_fadvise_flags);
25347               if (value) { values[3] = value; kw_args--; }
25348             }
25349           }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G4SfPGNSD3RvuUtY7CjQxWAKKd4QPmcbrq2J59s0UdIDHqWajxEGzhGhsaMdSuD-2FVjfkcDDG8SEmjXlcbu8v85WFGgN5Z7AjKrr7OB-2FQBZH7WNTcLiDxZJdCMr-2FUhyOt-2FWIbOSmmYJBc31VbudKj9OR65I-2BXPWr6IkBtbGdU6ntJv3j68DFXHlW-2Fb3GTb-2B484-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8G4SfPGNSD3RvuUtY7CjQxWAKKd4QPmcbrq2J59s0UdIGa4K-2Bq51d-2BhzkdCcM3W0q744vfLK5cnnjh4CJ8DDEdRUDbZrBxlxHtAJ0zThSDmi2v0i2c7-2FcE2y0g8vs-2BVLuM1Lnqr2CuWU-2BTzou7CSEZQZk3xdiycCHA-2BD6armhqWP9CNPR-2FNi1uSk1sfm2k8jww-3D

