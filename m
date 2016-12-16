From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 16 Dec 2016 00:54:45 -0800
Message-ID: <5853abd51227f_1a4cde333479531@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:55203 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932284AbcLPIzV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Dec 2016 03:55:21 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id waCPmVFzS8Catx1cA8pubA
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 08:54:45.111 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

13 new defect(s) introduced to ceph found with Coverity Scan.
10 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 13 of 13 defect(s)


** CID 1397254:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 11969 in PrimaryLogPG::agent_setup()()


________________________________________________________________________________________________________
*** CID 1397254:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 11969 in PrimaryLogPG::agent_setup()()
11963     
11964         // choose random starting position
11965         agent_state->position = hobject_t();
11966         agent_state->position.pool = info.pgid.pool();
11967         agent_state->position.set_hash(pool.info.get_random_pg_position(
11968           info.pgid.pgid,
>>>     CID 1397254:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
11969           rand()));
11970         agent_state->start = agent_state->position;
11971     
11972         dout(10) << __func__ << " allocated new state, position "
11973     	     << agent_state->position << dendl;
11974       } else {

** CID 1397255:  Incorrect expression  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/osd/OSDMap.cc: 2995 in OSDMap::summarize_mapping_stats(OSDMap*, const std::set<long, std::less<long>, std::allocator<long>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *) const()


________________________________________________________________________________________________________
*** CID 1397255:  Incorrect expression  (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/osd/OSDMap.cc: 2995 in OSDMap::summarize_mapping_stats(OSDMap*, const std::set<long, std::less<long>, std::allocator<long>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, ceph::Formatter *) const()
2989         f->open_object_section("utilization");
2990       if (newmap) {
2991         if (f) {
2992           f->dump_unsigned("moved_pgs", moved_pg);
2993           f->dump_unsigned("total_pgs", total_pg);
2994         } else {
>>>     CID 1397255:  Incorrect expression  (DIVIDE_BY_ZERO)
>>>     In expression "(float)moved_pg * 100. / (float)total_pg", division by expression "total_pg" which may be zero has undefined behavior.
2995           ss << "moved " << moved_pg << " / " << total_pg
2996     	 << " (" << ((float)moved_pg * 100.0 / (float)total_pg) << "%)\n";
2997         }
2998       }
2999       if (f) {
3000         f->dump_float("avg_pgs", avg_pg);

** CID 1397256:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1153 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1158 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1152 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1162 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1340 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1345 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1339 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1349 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()


________________________________________________________________________________________________________
*** CID 1397256:    (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1153 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1147     
1148     	  hobject_t candidate;
1149     	  if (mcand == lcand) {
1150     	    candidate = mcand;
1151     	    if (!mcand.is_max()) {
1152     	      ++ls_iter;
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1153     	      ++missing_iter;
1154     	    }
1155     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1156     	    candidate = mcand;
1157     	    assert(!mcand.is_max());
1158     	    ++missing_iter;
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1158 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1152     	      ++ls_iter;
1153     	      ++missing_iter;
1154     	    }
1155     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1156     	    candidate = mcand;
1157     	    assert(!mcand.is_max());
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1158     	    ++missing_iter;
1159     	  } else {
1160     	    candidate = lcand;
1161     	    assert(!lcand.is_max());
1162     	    ++ls_iter;
1163     	  }
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1152 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1146     	    *ls_iter;
1147     
1148     	  hobject_t candidate;
1149     	  if (mcand == lcand) {
1150     	    candidate = mcand;
1151     	    if (!mcand.is_max()) {
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1152     	      ++ls_iter;
1153     	      ++missing_iter;
1154     	    }
1155     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1156     	    candidate = mcand;
1157     	    assert(!mcand.is_max());
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1162 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1156     	    candidate = mcand;
1157     	    assert(!mcand.is_max());
1158     	    ++missing_iter;
1159     	  } else {
1160     	    candidate = lcand;
1161     	    assert(!lcand.is_max());
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1162     	    ++ls_iter;
1163     	  }
1164     
1165               dout(10) << " pgnls candidate 0x" << std::hex << candidate.get_hash()
1166                 << " vs lower bound 0x" << lower_bound.get_hash() << dendl;
1167     
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1340 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1334     
1335     	  hobject_t candidate;
1336     	  if (mcand == lcand) {
1337     	    candidate = mcand;
1338     	    if (!mcand.is_max()) {
1339     	      ++ls_iter;
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1340     	      ++missing_iter;
1341     	    }
1342     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1343     	    candidate = mcand;
1344     	    assert(!mcand.is_max());
1345     	    ++missing_iter;
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1345 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1339     	      ++ls_iter;
1340     	      ++missing_iter;
1341     	    }
1342     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1343     	    candidate = mcand;
1344     	    assert(!mcand.is_max());
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "missing_iter" though it is already past the end of its container.
1345     	    ++missing_iter;
1346     	  } else {
1347     	    candidate = lcand;
1348     	    assert(!lcand.is_max());
1349     	    ++ls_iter;
1350     	  }
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1339 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1333     	    *ls_iter;
1334     
1335     	  hobject_t candidate;
1336     	  if (mcand == lcand) {
1337     	    candidate = mcand;
1338     	    if (!mcand.is_max()) {
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1339     	      ++ls_iter;
1340     	      ++missing_iter;
1341     	    }
1342     	  } else if (cmp(mcand, lcand, get_sort_bitwise()) < 0) {
1343     	    candidate = mcand;
1344     	    assert(!mcand.is_max());
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.cc: 1349 in PrimaryLogPG::do_pg_op(std::shared_ptr<OpRequest>)()
1343     	    candidate = mcand;
1344     	    assert(!mcand.is_max());
1345     	    ++missing_iter;
1346     	  } else {
1347     	    candidate = lcand;
1348     	    assert(!lcand.is_max());
>>>     CID 1397256:    (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "ls_iter" though it is already past the end of its container.
1349     	    ++ls_iter;
1350     	  }
1351     
1352     	  if (cmp(candidate, next, get_sort_bitwise()) >= 0) {
1353     	    break;
1354     	  }

** CID 1397257:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 13276 in __pyx_pw_6cephfs_9LibCephFS_77readlink()


________________________________________________________________________________________________________
*** CID 1397257:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 13276 in __pyx_pw_6cephfs_9LibCephFS_77readlink()
13270           }
13271           kw_args = PyDict_Size(__pyx_kwds);
13272           switch (pos_args) {
13273             case  0:
13274             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_path)) != 0)) kw_args--;
13275             else goto __pyx_L5_argtuple_error;
>>>     CID 1397257:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13276             case  1:
13277             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_size)) != 0)) kw_args--;
13278             else {
13279               __Pyx_RaiseArgtupleInvalid("readlink", 1, 2, 2, 1); __PYX_ERR(0, 868, __pyx_L3_error)
13280             }
13281           }

** CID 1397258:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 14157 in __pyx_pw_6cephfs_9LibCephFS_83mds_command()


________________________________________________________________________________________________________
*** CID 1397258:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 14157 in __pyx_pw_6cephfs_9LibCephFS_83mds_command()
14151           }
14152           kw_args = PyDict_Size(__pyx_kwds);
14153           switch (pos_args) {
14154             case  0:
14155             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_mds_spec)) != 0)) kw_args--;
14156             else goto __pyx_L5_argtuple_error;
>>>     CID 1397258:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
14157             case  1:
14158             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_args)) != 0)) kw_args--;
14159             else {
14160               __Pyx_RaiseArgtupleInvalid("mds_command", 1, 3, 3, 1); __PYX_ERR(0, 911, __pyx_L3_error)
14161             }
14162             case  2:

** CID 1397259:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 13844 in __pyx_pw_6cephfs_9LibCephFS_81rename()


________________________________________________________________________________________________________
*** CID 1397259:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 13844 in __pyx_pw_6cephfs_9LibCephFS_81rename()
13838           }
13839           kw_args = PyDict_Size(__pyx_kwds);
13840           switch (pos_args) {
13841             case  0:
13842             if (likely((values[0] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_src)) != 0)) kw_args--;
13843             else goto __pyx_L5_argtuple_error;
>>>     CID 1397259:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
13844             case  1:
13845             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_dst)) != 0)) kw_args--;
13846             else {
13847               __Pyx_RaiseArgtupleInvalid("rename", 1, 2, 2, 1); __PYX_ERR(0, 896, __pyx_L3_error)
13848             }
13849           }

** CID 1397260:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 14162 in __pyx_pw_6cephfs_9LibCephFS_83mds_command()


________________________________________________________________________________________________________
*** CID 1397260:  Control flow issues  (MISSING_BREAK)
/src/pybind/cephfs/cephfs.c: 14162 in __pyx_pw_6cephfs_9LibCephFS_83mds_command()
14156             else goto __pyx_L5_argtuple_error;
14157             case  1:
14158             if (likely((values[1] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_args)) != 0)) kw_args--;
14159             else {
14160               __Pyx_RaiseArgtupleInvalid("mds_command", 1, 3, 3, 1); __PYX_ERR(0, 911, __pyx_L3_error)
14161             }
>>>     CID 1397260:  Control flow issues  (MISSING_BREAK)
>>>     The above case falls through to this one.
14162             case  2:
14163             if (likely((values[2] = PyDict_GetItem(__pyx_kwds, __pyx_n_s_input_data)) != 0)) kw_args--;
14164             else {
14165               __Pyx_RaiseArgtupleInvalid("mds_command", 1, 3, 3, 2); __PYX_ERR(0, 911, __pyx_L3_error)
14166             }
14167           }

** CID 1397261:  Integer handling issues  (NEGATIVE_RETURNS)
/src/pybind/cephfs/cephfs.c: 13408 in __pyx_pf_6cephfs_9LibCephFS_76readlink()


________________________________________________________________________________________________________
*** CID 1397261:  Integer handling issues  (NEGATIVE_RETURNS)
/src/pybind/cephfs/cephfs.c: 13408 in __pyx_pf_6cephfs_9LibCephFS_76readlink()
13402      *             char* _path = path
13403      *             int64_t _size = size             # <<<<<<<<<<<<<<
13404      *             char *buf = NULL
13405      * 
13406      */
13407       __pyx_t_7 = __Pyx_PyInt_As_int64_t(__pyx_v_size); if (unlikely((__pyx_t_7 == (int64_t)-1) && PyErr_Occurred())) __PYX_ERR(0, 874, __pyx_L1_error)
>>>     CID 1397261:  Integer handling issues  (NEGATIVE_RETURNS)
>>>     Assigning: signed variable "__pyx_v__size" = "__pyx_t_7".
13408       __pyx_v__size = __pyx_t_7;
13409     
13410       /* "cephfs.pyx":875
13411      *             char* _path = path
13412      *             int64_t _size = size
13413      *             char *buf = NULL             # <<<<<<<<<<<<<<

** CID 1397262:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/cephfs/cephfs.c: 14709 in __pyx_pf_6cephfs_9LibCephFS_82mds_command()


________________________________________________________________________________________________________
*** CID 1397262:  Resource leaks  (RESOURCE_LEAK)
/src/pybind/cephfs/cephfs.c: 14709 in __pyx_pf_6cephfs_9LibCephFS_82mds_command()
14703       __Pyx_XDECREF(__pyx_v_my_outbuf);
14704       __Pyx_XDECREF(__pyx_v_mds_spec);
14705       __Pyx_XDECREF(__pyx_v_args);
14706       __Pyx_XDECREF(__pyx_v_input_data);
14707       __Pyx_XGIVEREF(__pyx_r);
14708       __Pyx_RefNannyFinishContext();
>>>     CID 1397262:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v__cmd" going out of scope leaks the storage it points to.
14709       return __pyx_r;
14710     }
14711     
14712     /* "cephfs.pyx":318
14713      *     """libcephfs python wrapper"""
14714      * 

** CID 1397263:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_main.cc: 194 in main()


________________________________________________________________________________________________________
*** CID 1397263:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/rgw/rgw_main.cc: 194 in main()
188     }
189     
190     
191     /*
192      * start up the RADOS connection and then handle HTTP messages as they come in
193      */
>>>     CID 1397263:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "std::length_error" is thrown and never caught.
194     int main(int argc, const char **argv)
195     {
196       // dout() messages will be sent to stderr, but FCGX wants messages on stdout
197       // Redirect stderr to stdout.
198       TEMP_FAILURE_RETRY(close(STDERR_FILENO));
199       if (TEMP_FAILURE_RETRY(dup2(STDOUT_FILENO, STDERR_FILENO) < 0)) {

** CID 1397264:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.h: 607 in PrimaryLogPG::OpContext::OpContext(std::shared_ptr<OpRequest>, osd_reqid_t, std::vector<OSDOp, std::allocator<OSDOp>> &, PrimaryLogPG*)()


________________________________________________________________________________________________________
*** CID 1397264:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PrimaryLogPG.h: 607 in PrimaryLogPG::OpContext::OpContext(std::shared_ptr<OpRequest>, osd_reqid_t, std::vector<OSDOp, std::allocator<OSDOp>> &, PrimaryLogPG*)()
601           data_off(0), reply(NULL), pg(_pg),
602           num_read(0),
603           num_write(0),
604           copy_cb(NULL),
605           async_read_result(0),
606           inflightreads(0),
>>>     CID 1397264:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "sent_disk" is not initialized in this constructor nor in any functions that it calls.
607           lock_type(ObjectContext::RWState::RWNONE) {}
608         void reset_obs(ObjectContextRef obc) {
609           new_obs = ObjectState(obc->obs.oi, obc->obs.exists);
610           if (obc->ssc) {
611     	new_snapset = obc->ssc->snapset;
612     	snapset = &obc->ssc->snapset;

** CID 1397265:  Control flow issues  (UNREACHABLE)
/src/pybind/cephfs/cephfs.c: 13537 in __pyx_pf_6cephfs_9LibCephFS_76readlink()


________________________________________________________________________________________________________
*** CID 1397265:  Control flow issues  (UNREACHABLE)
/src/pybind/cephfs/cephfs.c: 13537 in __pyx_pf_6cephfs_9LibCephFS_76readlink()
13531      *             return buf
13532      *         finally:
13533      *             free(buf)             # <<<<<<<<<<<<<<
13534      * 
13535      *     def unlink(self, path):
13536      */
>>>     CID 1397265:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
13537       /*finally:*/ {
13538         /*exception exit:*/{
13539           __Pyx_PyThreadState_declare
13540           __pyx_L4_error:;
13541           __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0;
13542           __Pyx_PyThreadState_assign

** CID 1397266:  Control flow issues  (UNREACHABLE)
/src/pybind/cephfs/cephfs.c: 14636 in __pyx_pf_6cephfs_9LibCephFS_82mds_command()


________________________________________________________________________________________________________
*** CID 1397266:  Control flow issues  (UNREACHABLE)
/src/pybind/cephfs/cephfs.c: 14636 in __pyx_pf_6cephfs_9LibCephFS_82mds_command()
14630     
14631       /* "cephfs.pyx":950
14632      *                 return (ret, b"", "")
14633      *         finally:
14634      *             free(_cmd)             # <<<<<<<<<<<<<<
14635      */
>>>     CID 1397266:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    PyThreadState *__...".
14636       /*finally:*/ {
14637         /*exception exit:*/{
14638           __Pyx_PyThreadState_declare
14639           __pyx_L4_error:;
14640           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
14641           __Pyx_PyThreadState_assign


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EV4BzaJIlzRXqRxG3hN3Fxx-2FvUji7A24kBoNYghIuggPgSu6Km0-2FLuYD2BMcdWsPcqIFkzDferUw0a6cf0mAg0kF8PWAMsux2sv64NiMXcyyBwGkwGeFT7uxKwdpoW81Pk4BsBydBMY9QrFy5bBBNxPCMFFJ5wePNN5wN4T5xSws4PdxVCrXn5ITdCr6STldk-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8EV4BzaJIlzRXqRxG3hN3Fxx-2FvUji7A24kBoNYghIuggCmCxC-2B57BvUu9wAxEmfWblEJ1K-2BJrbewJW10hK11l4T0Jgd9TNNTEiO2f-2FfGzFg5ZKc13LuMQ-2Bn9FG5wLgaffgOisReLi9Y-2FBS4Q8hroRU7SccRqnpT7H9PwFyHrSPvVAZ7dX-2Fljt2MLA3-2FywlY-2FCY-3D

