From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 16 Sep 2014 14:40:12 -0700
Message-ID: <5418ae3ce3e39_2a5b6c7334536a4@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41862 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934487AbbI1RU1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:27 -0400
Received: from us02secmta2.synopsys.com (us02secmta2.synopsys.com [10.12.235.98])
	by smtprelay.synopsys.com (Postfix) with ESMTP id E3E2710C158D
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from us02secmta2.internal.synopsys.com (us02secmta2.internal.synopsys.com [127.0.0.1])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id D324055F22
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
	by us02secmta2.internal.synopsys.com (Service) with ESMTP id 8E2DD55F20
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id 73615203
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id 60BCC1FE
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>


Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 20 of 38 defect(s)


** CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/Capability.h: 249 in Capability::Capability(CInode *, unsigned long, client_t)()

** CID 1238869:  Value not atomically updated  (ATOMICITY)
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()

** CID 1238870:  Unchecked return value  (CHECKED_RETURN)
/test/test_snap_mapper.cc: 562 in MapperVerifier::remove_oid()()

** CID 1238871:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 6988 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
/mds/Server.cc: 7107 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()

** CID 1238872:  Unchecked return value  (CHECKED_RETURN)
/tools/ceph_objectstore_tool.cc: 1284 in do_import_rados(std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()

** CID 1238873:  Unchecked return value  (CHECKED_RETURN)
/rbd_replay/Replayer.cc: 154 in rbd_replay::Replayer::run(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()

** CID 1238874:  Missing unlock  (LOCK)
/osdc/Objecter.cc: 1855 in Objecter::op_cancel(Objecter::OSDSession *, unsigned long, int)()

** CID 1238875:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7737 in ()

** CID 1238876:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7735 in ()

** CID 1238877:  Missing unlock  (LOCK)
/common/Timer.cc: 240 in RWTimer::shutdown()()

** CID 1238878:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7734 in ()

** CID 1238879:  Thread deadlock  (ORDER_REVERSAL)


** CID 1238880:  Thread deadlock  (ORDER_REVERSAL)



** CID 1238881:  Thread deadlock  (ORDER_REVERSAL)



** CID 1238882:  Thread deadlock  (ORDER_REVERSAL)


** CID 1238883:  Improper use of negative value  (NEGATIVE_RETURNS)
/mds/MDS.cc: 962 in MDS::handle_mds_map(MMDSMap *)()

** CID 1238884:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7733 in ()

** CID 1238885:  Thread deadlock  (ORDER_REVERSAL)


** CID 1238886:  Thread deadlock  (ORDER_REVERSAL)


** CID 1238887:  Thread deadlock  (ORDER_REVERSAL)



________________________________________________________________________________________________________
*** CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/Capability.h: 249 in Capability::Capability(CInode *, unsigned long, client_t)()
243         suppress(0), state(0),
244         client_follows(0), client_xattr_version(0),
245         client_inline_version(0),
246         item_session_caps(this), item_snaprealm_caps(this), item_revoking_caps(this) {
247         g_num_cap++;
248         g_num_capa++;
>>>     CID 717233:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "num_revoke_warnings" is not initialized in this constructor nor in any functions that it calls.
249       }
250       ~Capability() {
251         g_num_cap--;
252         g_num_caps++;
253       }
254     

________________________________________________________________________________________________________
*** CID 1238869:  Value not atomically updated  (ATOMICITY)
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()
3049         if (!rwlock.is_wlocked()) {
3050           rwlock.unlock();
3051           rwlock.get_write();
3052         }
3053         iter = pool_ops.find(tid);
3054         if (iter != pool_ops.end()) {
>>>     CID 1238869:  Value not atomically updated  (ATOMICITY)
>>>     Using an unreliable value of "op" inside the second locked section. If the data that "op" depends on was changed by another thread, this use might be incorrect.
3055           _finish_pool_op(op);
3056         }
3057       } else {
3058         ldout(cct, 10) << "unknown request " << tid << dendl;
3059       }
3060       rwlock.unlock();
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()
3049         if (!rwlock.is_wlocked()) {
3050           rwlock.unlock();
3051           rwlock.get_write();
3052         }
3053         iter = pool_ops.find(tid);
3054         if (iter != pool_ops.end()) {
>>>     CID 1238869:  Value not atomically updated  (ATOMICITY)
>>>     Using an unreliable value of "op" inside the second locked section. If the data that "op" depends on was changed by another thread, this use might be incorrect.
3055           _finish_pool_op(op);
3056         }
3057       } else {
3058         ldout(cct, 10) << "unknown request " << tid << dendl;
3059       }
3060       rwlock.unlock();
/osdc/Objecter.cc: 3055 in Objecter::handle_pool_op_reply(MPoolOpReply *)()
3049         if (!rwlock.is_wlocked()) {
3050           rwlock.unlock();
3051           rwlock.get_write();
3052         }
3053         iter = pool_ops.find(tid);
3054         if (iter != pool_ops.end()) {
>>>     CID 1238869:  Value not atomically updated  (ATOMICITY)
>>>     Using an unreliable value of "op" inside the second locked section. If the data that "op" depends on was changed by another thread, this use might be incorrect.
3055           _finish_pool_op(op);
3056         }
3057       } else {
3058         ldout(cct, 10) << "unknown request " << tid << dendl;
3059       }
3060       rwlock.unlock();

________________________________________________________________________________________________________
*** CID 1238870:  Unchecked return value  (CHECKED_RETURN)
/test/test_snap_mapper.cc: 562 in MapperVerifier::remove_oid()()
556     	snap_to_hobject.find(*i);
557           assert(j->second.count(obj->first));
558           j->second.erase(obj->first);
559         }
560         {
561           PausyAsyncMap::Transaction t;
>>>     CID 1238870:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "remove_oid" without checking return value (as is done elsewhere 8 out of 10 times).
562           mapper->remove_oid(
563     	obj->first,
564     	&t);
565           driver->submit(&t);
566         }
567         hobject_to_snap.erase(obj);

________________________________________________________________________________________________________
*** CID 1238871:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 6988 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
6982       // slave
6983       assert(!destdn || destdn->authority().first != whoami);
6984       assert(!straydn || straydn->authority().first != whoami);
6985     
6986       bool force_journal_src = false;
6987       bool force_journal_dest = false;
>>>     CID 1238871:  Dereference after null check  (FORWARD_NULL)
>>>     Passing null pointer "srcdn" to "authority", which dereferences it. (The dereference happens because this is a virtual function call.)
6988       if (in && in->is_dir() && srcdn->authority().first != whoami)
6989         force_journal_src = _need_force_journal(in, false);
6990       if (in && target && target->is_dir())
6991         force_journal_dest = _need_force_journal(in, true);
6992       
6993       version_t srcdnpv = 0;
/mds/Server.cc: 7107 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
7101         le->commit.add_primary_dentry(target->get_projected_parent_dn(), target, true);
7102       }
7103     
7104       if (force_journal_dest) {
7105         dout(10) << " noting rename target ino " << target->ino() << " in metablob" << dendl;
7106         le->commit.renamed_dirino = target->ino();
>>>     CID 1238871:  Dereference after null check  (FORWARD_NULL)
>>>     Passing null pointer "srcdn" to "authority", which dereferences it. (The dereference happens because this is a virtual function call.)
7107       } else if (force_journal_src || (in && in->is_dir() && srcdn->authority().first == whoami)) {
7108         dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
7109         le->commit.renamed_dirino = in->ino();
7110       }
7111       
7112       if (target && target->is_dir()) {

________________________________________________________________________________________________________
*** CID 1238872:  Unchecked return value  (CHECKED_RETURN)
/tools/ceph_objectstore_tool.cc: 1284 in do_import_rados(std::basic_string<char, std::char_traits<char>, std::allocator<char>>)()
1278       }
1279       ret = cluster.conf_parse_env(NULL);
1280       if (ret) {
1281         cerr << "Error " << ret << " in cluster.conf_read_env" << std::endl;
1282         return ret;
1283       }
>>>     CID 1238872:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 14 out of 17 times).
1284       cluster.connect();
1285     
1286       ret = cluster.ioctx_create(pool.c_str(), ioctx);
1287       if (ret < 0) {
1288         cerr << "ioctx_create " << pool << " failed with " << ret << std::endl;
1289         return ret;

________________________________________________________________________________________________________
*** CID 1238873:  Unchecked return value  (CHECKED_RETURN)
/rbd_replay/Replayer.cc: 154 in rbd_replay::Replayer::run(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
148       return m_action_trackers[id % m_num_action_trackers];
149     }
150     
151     void Replayer::run(const std::string& replay_file) {
152       {
153         librados::Rados rados;
>>>     CID 1238873:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "init" without checking return value (as is done elsewhere 11 out of 12 times).
154         rados.init(NULL);
155         int r = rados.init_with_context(g_ceph_context);
156         if (r) {
157           cerr << "Unable to read conf file: " << r << std::endl;
158           goto out;
159         }

________________________________________________________________________________________________________
*** CID 1238874:  Missing unlock  (LOCK)
/osdc/Objecter.cc: 1855 in Objecter::op_cancel(Objecter::OSDSession *, unsigned long, int)()
1849     
1850       s->lock.get_write();
1851     
1852       map<ceph_tid_t, Op*>::iterator p = s->ops.find(tid);
1853       if (p == s->ops.end()) {
1854         ldout(cct, 10) << __func__ << " tid " << tid << " dne" << dendl;
>>>     CID 1238874:  Missing unlock  (LOCK)
>>>     Returning without unlocking "s->lock.L".
1855         return -ENOENT;
1856       }
1857     
1858       if (s->con) {
1859         ldout(cct, 20) << " revoking rx buffer for " << tid
1860     		   << " on " << s->con << dendl;

________________________________________________________________________________________________________
*** CID 1238875:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7737 in ()
7731     const Client::VXattr Client::_dir_vxattrs[] = {
7732       {
7733         name: "ceph.dir.layout",
7734         getxattr_cb: &Client::_vxattrcb_layout,
7735         readonly: false,
7736         hidden: true,
>>>     CID 1238875:  Unrecoverable parse warning  (PARSE_ERROR)
>>>     designator may not specify a non-POD subobject
7737         exists_cb: &Client::_vxattrcb_layout_exists,
7738       },
7739       XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),
7740       XATTR_LAYOUT_FIELD(dir, layout, stripe_count),
7741       XATTR_LAYOUT_FIELD(dir, layout, object_size),
7742       XATTR_LAYOUT_FIELD(dir, layout, pool),

________________________________________________________________________________________________________
*** CID 1238876:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7735 in ()
7729     }
7730     
7731     const Client::VXattr Client::_dir_vxattrs[] = {
7732       {
7733         name: "ceph.dir.layout",
7734         getxattr_cb: &Client::_vxattrcb_layout,
>>>     CID 1238876:  Unrecoverable parse warning  (PARSE_ERROR)
>>>     designator may not specify a non-POD subobject
7735         readonly: false,
7736         hidden: true,
7737         exists_cb: &Client::_vxattrcb_layout_exists,
7738       },
7739       XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),
7740       XATTR_LAYOUT_FIELD(dir, layout, stripe_count),

________________________________________________________________________________________________________
*** CID 1238877:  Missing unlock  (LOCK)
/common/Timer.cc: 240 in RWTimer::shutdown()()
234         rwlock.unlock();
235         thread->join();
236         rwlock.get_write();
237         delete thread;
238         thread = NULL;
239       }
>>>     CID 1238877:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->rwlock->L".
240     }
241     
242     void RWTimer::timer_thread()
243     {
244       rwlock.get_write();
245       ldout(cct,10) << "timer_thread starting" << dendl;

________________________________________________________________________________________________________
*** CID 1238878:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7734 in ()
7728       exists_cb: &Client::_vxattrcb_layout_exists,			\
7729     }
7730     
7731     const Client::VXattr Client::_dir_vxattrs[] = {
7732       {
7733         name: "ceph.dir.layout",
>>>     CID 1238878:  Unrecoverable parse warning  (PARSE_ERROR)
>>>     designator may not specify a non-POD subobject
7734         getxattr_cb: &Client::_vxattrcb_layout,
7735         readonly: false,
7736         hidden: true,
7737         exists_cb: &Client::_vxattrcb_layout_exists,
7738       },
7739       XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),

________________________________________________________________________________________________________
*** CID 1238879:  Thread deadlock  (ORDER_REVERSAL)
/librados/IoCtxImpl.cc: 1122 in librados::IoCtxImpl::notify(const object_t &, unsigned long, ceph::buffer::list &)()
1116       prepare_assert_ops(&rd);
1117       rd.notify(cookie, ver, inbl);
1118     
1119       // Issue RADOS op
1120       C_SaferCond onack;
1121       version_t objver;
>>>     CID 1238879:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "linger_read" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
1122       wc->linger_id = objecter->linger_read(oid, oloc, rd, snap_seq, inbl, NULL, 0,
1123     					&onack, &objver);
1124       lock->Unlock();
1125     
1126       ldout(client->cct, 10) << __func__ << " issued linger op " << wc->linger_id << dendl;
1127       int r_issue = onack.wait();

________________________________________________________________________________________________________
*** CID 1238880:  Thread deadlock  (ORDER_REVERSAL)
/test/osd/RadosModel.h: 728 in WriteOp::_begin()()
722         if (do_append) {
723           ObjectDesc old_value;
724           bool found = context->find_object(oid, &old_value);
725           uint64_t prev_length = found && old_value.has_contents() ?
726     	old_value.most_recent_gen()->get_length(old_value.most_recent()) :
727     	0;
>>>     CID 1238880:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "pool_required_alignment" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
728           cont_gen = new AppendGenerator(
729     	prev_length,
730     	(context->io_ctx.pool_requires_alignment() ?
731     	 context->io_ctx.pool_required_alignment() : 0),
732     	context->min_stride_size,
733     	context->max_stride_size,
/test/osd/RadosModel.h: 728 in WriteOp::_begin()()
722         if (do_append) {
723           ObjectDesc old_value;
724           bool found = context->find_object(oid, &old_value);
725           uint64_t prev_length = found && old_value.has_contents() ?
726     	old_value.most_recent_gen()->get_length(old_value.most_recent()) :
727     	0;
>>>     CID 1238880:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "pool_requires_alignment" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
728           cont_gen = new AppendGenerator(
729     	prev_length,
730     	(context->io_ctx.pool_requires_alignment() ?
731     	 context->io_ctx.pool_required_alignment() : 0),
732     	context->min_stride_size,
733     	context->max_stride_size,

________________________________________________________________________________________________________
*** CID 1238881:  Thread deadlock  (ORDER_REVERSAL)
/test/osd/RadosModel.h: 1251 in SnapRemoveOp::_begin()()
1245         uint64_t snap = context->snaps[to_remove];
1246         context->remove_snap(to_remove);
1247     
1248         if (context->pool_snaps) {
1249           string snapname;
1250     
>>>     CID 1238881:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "snap_get_name" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
1251           assert(!context->io_ctx.snap_get_name(snap, &snapname));
1252           assert(!context->io_ctx.snap_remove(snapname.c_str()));
1253          } else {
1254           assert(!context->io_ctx.selfmanaged_snap_remove(snap));
1255     
1256           vector<uint64_t> snapset(context->snaps.size());
/test/osd/RadosModel.h: 1252 in SnapRemoveOp::_begin()()
1246         context->remove_snap(to_remove);
1247     
1248         if (context->pool_snaps) {
1249           string snapname;
1250     
1251           assert(!context->io_ctx.snap_get_name(snap, &snapname));
>>>     CID 1238881:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "snap_remove" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
1252           assert(!context->io_ctx.snap_remove(snapname.c_str()));
1253          } else {
1254           assert(!context->io_ctx.selfmanaged_snap_remove(snap));
1255     
1256           vector<uint64_t> snapset(context->snaps.size());
1257           int j = 0;

________________________________________________________________________________________________________
*** CID 1238882:  Thread deadlock  (ORDER_REVERSAL)
/librados/RadosClient.cc: 786 in librados::RadosClient::osd_command(int, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, const ceph::buffer::list &, ceph::buffer::list *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
780     
781       if (osd < 0)
782         return -EINVAL;
783     
784       lock.Lock();
785       // XXX do anything with tid?
>>>     CID 1238882:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "osd_command" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
786       int r = objecter->osd_command(osd, cmd, inbl, &tid, poutbl, prs,
787     			 new C_SafeCond(&mylock, &cond, &done, &ret));
788       lock.Unlock();
789       if (r != 0)
790         return r;
791       mylock.Lock();

________________________________________________________________________________________________________
*** CID 1238883:  Improper use of negative value  (NEGATIVE_RETURNS)
/mds/MDS.cc: 962 in MDS::handle_mds_map(MMDSMap *)()
956       }
957     
958       // see who i am
959       addr = messenger->get_myaddr();
960       whoami = mdsmap->get_rank_gid(monc->get_global_id());
961       state = mdsmap->get_state_gid(monc->get_global_id());
>>>     CID 1238883:  Improper use of negative value  (NEGATIVE_RETURNS)
>>>     Assigning: signed variable "this->incarnation" = "get_inc_gid".
962       incarnation = mdsmap->get_inc_gid(monc->get_global_id());
963       dout(10) << "map says i am " << addr << " mds." << whoami << "." << incarnation
964     	   << " state " << ceph_mds_state_name(state) << dendl;
965     
966       // mark down any failed peers
967       for (map<uint64_t,MDSMap::mds_info_t>::const_iterator p = oldmap->get_mds_info().begin();

________________________________________________________________________________________________________
*** CID 1238884:  Unrecoverable parse warning  (PARSE_ERROR)
/client/Client.cc: 7733 in ()
7727       hidden: true,							\
7728       exists_cb: &Client::_vxattrcb_layout_exists,			\
7729     }
7730     
7731     const Client::VXattr Client::_dir_vxattrs[] = {
7732       {
>>>     CID 1238884:  Unrecoverable parse warning  (PARSE_ERROR)
>>>     designator may not specify a non-POD subobject
7733         name: "ceph.dir.layout",
7734         getxattr_cb: &Client::_vxattrcb_layout,
7735         readonly: false,
7736         hidden: true,
7737         exists_cb: &Client::_vxattrcb_layout_exists,
7738       },

________________________________________________________________________________________________________
*** CID 1238885:  Thread deadlock  (ORDER_REVERSAL)
/librados/RadosClient.cc: 702 in librados::RadosClient::do_watch_notify(MWatchNotify *)()
696           // trigger the callback
697           lock.Unlock();
698           wc->watch_ctx->notify(m->opcode, m->ver, m->bl);
699           lock.Lock();
700     
701           // send ACK back to the OSD
>>>     CID 1238885:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "_notify_ack" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
702           wc->io_ctx_impl->_notify_ack(wc->oid, m->notify_id, m->ver, m->cookie);
703     
704           ldout(cct,10) << __func__ << " notify done" << dendl;
705           wc->put();
706         }
707       } else {

________________________________________________________________________________________________________
*** CID 1238886:  Thread deadlock  (ORDER_REVERSAL)
/client/SyntheticClient.cc: 2391 in SyntheticClient::object_rw(int, int, int, int, double, double)()
2385           m.ops.push_back(op);
2386           if (do_sync) {
2387             OSDOp op;
2388             op.op.op = CEPH_OSD_OP_STARTSYNC;
2389     	m.ops.push_back(op);
2390           }
>>>     CID 1238886:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "mutate" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
2391           client->objecter->mutate(oid, oloc, m, snapc, ceph_clock_now(client->cct), 0,
2392     			       NULL, new C_Ref(lock, cond, &unack));
2393           /*client->objecter->write(oid, layout, 0, osize, snapc, bl, 0,
2394     			      new C_Ref(lock, cond, &unack),
2395     			      new C_Ref(lock, cond, &unsafe));*/
2396         } else {

________________________________________________________________________________________________________
*** CID 1238887:  Thread deadlock  (ORDER_REVERSAL)
/librados/RadosClient.cc: 808 in librados::RadosClient::pg_command(pg_t, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, const ceph::buffer::list &, ceph::buffer::list *, std::basic_string<char, std::char_traits<char>, std::allocator<char>>*)()
802       Mutex mylock("RadosClient::pg_command::mylock");
803       Cond cond;
804       bool done;
805       int ret;
806       ceph_tid_t tid;
807       lock.Lock();
>>>     CID 1238887:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "pg_command" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 14 / 29).
808       int r = objecter->pg_command(pgid, cmd, inbl, &tid, poutbl, prs,
809     		        new C_SafeCond(&mylock, &cond, &done, &ret));
810       lock.Unlock();
811       if (r != 0)
812         return r;
813       mylock.Lock();


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



