From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Fri, 11 Apr 2014 21:06:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404112105310.16913@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-449499710-1397275568=:16913"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48145 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaDLEGI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Apr 2014 00:06:08 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2005E800BB
	for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 21:06:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1CFA2800BB
	for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 21:06:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-449499710-1397275568=:16913
Content-Type: TEXT/PLAIN; charset=US-ASCII

Several new defects.  This wasn't running for the last couple of weeks 
because the submodules didn't update on the test checkout.


--557981400-449499710-1397275568=:16913
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1404112105311.16913@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id C1C53803BC
	for <sage@cobra.newdream.net>; Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id BEA70120A67; Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdcbfh.dreamhost.com
	[208.97.132.157])
	by destro.newdream.net (Postfix) with ESMTP id BC353120A53
	for <sage@newdream.net>; Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id B85C617BC7B4
	for <sage@newdream.net>; Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id aDCzjB4XJuHI for <sage@newdream.net>;
	Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id 8F34B1B0059
	for <sage@newdream.net>; Fri, 11 Apr 2014 19:03:21 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Fri, 11 Apr 2014 19:04:18 -0700
Date: Fri, 11 Apr 2014 19:03:21 -0700
From: scan-admin@coverity.com
Message-ID: <53489ee94320_640e7ac86c27621@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2014 02:04:18.0731 (UTC)
	FILETIME=[836B87B0:01CF55F3]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 20 of 41 defect(s)


** CID 1201374:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1097 in MDSMonitor::prepare_command(MMonCommand *)()

** CID 1201375:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 4460 in OSD::do_command(Connection *, unsigned long, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, ceph::buffer::list &)()

** CID 1201376:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 333 in main()

** CID 1201377:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 335 in main()

** CID 1201378:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 330 in main()

** CID 1201379:  Copy-paste error  (COPY_PASTE_ERROR)
/mds/Server.cc: 7119 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()

** CID 1201380:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf.c: 291 in gf_error_check()

** CID 1201381:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf.c: 376 in gf_error_check()
/erasure-code/jerasure/gf-complete/src/gf.c: 377 in gf_error_check()

** CID 1201382:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 6073 in Server::_rename_prepare(std::tr1::shared_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()

** CID 1201383:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7112 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()

** CID 1201384:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7154 in Server::_rename_rollback_finish(std::tr1::shared_ptr<MutationImpl> &, std::tr1::shared_ptr<MDRequestImpl> &, CDentry *, unsigned long, CDentry *, CDentry *, bool)()

** CID 1201385:  Using invalid iterator  (INVALIDATE_ITERATOR)
/mds/Locker.cc: 416 in Locker::acquire_locks(std::tr1::shared_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
/mds/Locker.cc: 416 in Locker::acquire_locks(std::tr1::shared_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()

** CID 1201386:  Using invalid iterator  (INVALIDATE_ITERATOR)
/test/librados/lock.cc: 371 in LibRadosLockECPP_BreakLockPP_Test::TestBody()()

** CID 1201387:  Using invalid iterator  (INVALIDATE_ITERATOR)
/test/librados/lock.cc: 330 in LibRadosLockECPP_ListLockersPP_Test::TestBody()()

** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 462 in Monitor::preinit()()

** CID 1201389:  Out-of-bounds access  (OVERRUN)
/test/librbd/test_librbd.cc: 1825 in LibRBD_ZeroLengthDiscard_Test::TestBody()()

** CID 1201390:  Out-of-bounds access  (OVERRUN_DYNAMIC)
/test/librbd/test_librbd.cc: 1825 in LibRBD_ZeroLengthDiscard_Test::TestBody()()

** CID 1201391:  Out-of-bounds write  (OVERRUN_STATIC)
/erasure-code/jerasure/gf-complete/src/gf_w8.c: 1267 in gf_w8_table_init()

** CID 1201392:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 134 in RadosTestEC::cleanup_default_namespace(void *)()
/test/librados/TestCase.cc: 139 in RadosTestEC::cleanup_default_namespace(void *)()
/test/librados/TestCase.cc: 141 in RadosTestEC::cleanup_default_namespace(void *)()

** CID 1201393:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 1881 in LibRadosAioEC_RoundTripAppend_Test::TestBody()()
/test/librados/aio.cc: 1883 in LibRadosAioEC_RoundTripAppend_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1201374:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1097 in MDSMonitor::prepare_command(MMonCommand *)()
1091           r = -EINVAL;
1092           poolid = -1;
1093           ss << "cannot remove default data pool";
1094         }
1095     
1096         if (poolid >= 0) {
>>>     CID 1201374:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "cmd_getval(g_ceph_context, cmdmap, std::string("poolid", std::allocator<char>()), poolid)".
1097           cmd_getval(g_ceph_context, cmdmap, "poolid", poolid);
1098           r = pending_mdsmap.remove_data_pool(poolid);
1099           if (r == -ENOENT)
1100     	r = 0;
1101           if (r == 0)
1102     	ss << "removed data pool " << poolid << " from mdsmap";

________________________________________________________________________________________________________
*** CID 1201375:  Unchecked return value  (CHECKED_RETURN)
/osd/OSD.cc: 4460 in OSD::do_command(Connection *, unsigned long, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, ceph::buffer::list &)()
4454         }
4455     
4456         fout.close();
4457       }
4458       else if (prefix == "debug kick_recovery_wq") {
4459         int64_t delay;
>>>     CID 1201375:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "cmd_getval(this->cct, cmdmap, std::string("delay", std::allocator<char>()), delay)".
4460         cmd_getval(cct, cmdmap, "delay", delay);
4461         ostringstream oss;
4462         oss << delay;
4463         r = cct->_conf->set_val("osd_recovery_delay_start", oss.str().c_str());
4464         if (r != 0) {
4465           ss << "kick_recovery_wq: error setting "

________________________________________________________________________________________________________
*** CID 1201376:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 333 in main()
327       }
328     
329       rados_t cl;
330       rados_create(&cl, NULL);
331       rados_conf_parse_argv(cl, argc, argv);
332       rados_conf_parse_argv(cl, argc, argv);
>>>     CID 1201376:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "rados_conf_read_file(cl, NULL)".
333       rados_conf_read_file(cl, NULL);
334       rados_conf_parse_env(cl, NULL);
335       rados_connect(cl);
336       rados_pool_delete(cl, pool.c_str());
337     
338       printf("******* SUCCESS **********\n"); 
339       return EXIT_SUCCESS;

________________________________________________________________________________________________________
*** CID 1201377:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 335 in main()
329       rados_t cl;
330       rados_create(&cl, NULL);
331       rados_conf_parse_argv(cl, argc, argv);
332       rados_conf_parse_argv(cl, argc, argv);
333       rados_conf_read_file(cl, NULL);
334       rados_conf_parse_env(cl, NULL);
>>>     CID 1201377:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "rados_connect(cl)".
335       rados_connect(cl);
336       rados_pool_delete(cl, pool.c_str());
337     
338       printf("******* SUCCESS **********\n"); 
339       return EXIT_SUCCESS;

________________________________________________________________________________________________________
*** CID 1201378:  Unchecked return value  (CHECKED_RETURN)
/test/system/rados_list_parallel.cc: 330 in main()
324           printf("got error: %s\n", error.c_str());
325           return EXIT_FAILURE;
326         }
327       }
328     
329       rados_t cl;
>>>     CID 1201378:  Unchecked return value  (CHECKED_RETURN)
>>>     No check of the return value of "rados_create(&cl, NULL)".
330       rados_create(&cl, NULL);
331       rados_conf_parse_argv(cl, argc, argv);
332       rados_conf_parse_argv(cl, argc, argv);
333       rados_conf_read_file(cl, NULL);
334       rados_conf_parse_env(cl, NULL);
335       rados_connect(cl);

________________________________________________________________________________________________________
*** CID 1201379:  Copy-paste error  (COPY_PASTE_ERROR)
/mds/Server.cc: 7119 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
7113         dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
7114         le->commit.renamed_dirino = in->ino();
7115       }
7116       
7117       if (target && target->is_dir()) {
7118         assert(destdn);
>>>     CID 1201379:  Copy-paste error  (COPY_PASTE_ERROR)
>>>     "in" in "this->mdcache->project_subtree_rename(in, straydir, destdir)" looks like a copy-paste error.  Should it say "target" instead?
7119         mdcache->project_subtree_rename(in, straydir, destdir);
7120       }
7121     
7122       if (in && in->is_dir()) {
7123         assert(srcdn);
7124         mdcache->project_subtree_rename(in, destdir, srcdir);

________________________________________________________________________________________________________
*** CID 1201380:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf.c: 291 in gf_error_check()
285         if (!pclmul)                                   { _gf_errno = GF_E_PCLMULX; return 0; }
286         return 1;
287       }
288     
289       if (mult_type == GF_MULT_BYTWO_p || mult_type == GF_MULT_BYTWO_b) {
290         if (raltmap)                    { _gf_errno = GF_E_ALT_BY2; return 0; }
>>>     CID 1201380:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "_gf_errno = 27;".
291         if (rsse && !sse2)              { _gf_errno = GF_E_BY2_SSE; return 0; }
292         return 1;
293       }
294     
295       if (mult_type == GF_MULT_LOG_TABLE || mult_type == GF_MULT_LOG_ZERO
296                                          || mult_type == GF_MULT_LOG_ZERO_EXT ) {

________________________________________________________________________________________________________
*** CID 1201381:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf.c: 376 in gf_error_check()
370           } else                                    { _gf_errno = GF_E_SP_64AR; return 0; }
371         } else if (w == 128) {
372           if (arg1 == 8 && arg2 == 128) {
373             if (rsse || rnosse)                     { _gf_errno = GF_E_SP128_S; return 0; }
374             if (raltmap)                            { _gf_errno = GF_E_SP128_A; return 0; }
375           } else if (arg1 == 4 && arg2 == 128) {
>>>     CID 1201381:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "_gf_errno = 63;".
376             if (rsse && !sse3)                      { _gf_errno = GF_E_SP_SSE3; return 0; }
377             if (raltmap && !sse3)                   { _gf_errno = GF_E_SP128AS; return 0; }
378             if (raltmap && rnosse)                  { _gf_errno = GF_E_SP128AS; return 0; }
379           } else                                    { _gf_errno = GF_E_SP128AR; return 0; }
380         } else                                      { _gf_errno = GF_E_SPLIT_W; return 0; }
381         return 1;
/erasure-code/jerasure/gf-complete/src/gf.c: 377 in gf_error_check()
371         } else if (w == 128) {
372           if (arg1 == 8 && arg2 == 128) {
373             if (rsse || rnosse)                     { _gf_errno = GF_E_SP128_S; return 0; }
374             if (raltmap)                            { _gf_errno = GF_E_SP128_A; return 0; }
375           } else if (arg1 == 4 && arg2 == 128) {
376             if (rsse && !sse3)                      { _gf_errno = GF_E_SP_SSE3; return 0; }
>>>     CID 1201381:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "_gf_errno = 46;".
377             if (raltmap && !sse3)                   { _gf_errno = GF_E_SP128AS; return 0; }
378             if (raltmap && rnosse)                  { _gf_errno = GF_E_SP128AS; return 0; }
379           } else                                    { _gf_errno = GF_E_SP128AR; return 0; }
380         } else                                      { _gf_errno = GF_E_SPLIT_W; return 0; }
381         return 1;
382       }

________________________________________________________________________________________________________
*** CID 1201382:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 6073 in Server::_rename_prepare(std::tr1::shared_ptr<MDRequestImpl> &, EMetaBlob *, ceph::buffer::list *, CDentry *, CDentry *, CDentry *)()
6067           force_journal_dest = true;
6068         } else
6069           force_journal_dest = _need_force_journal(srci, false);
6070       }
6071     
6072       bool force_journal_stray = false;
>>>     CID 1201382:  Dereference after null check  (FORWARD_NULL)
>>>     Comparing "straydn" to null implies that "straydn" might be null.
6073       if (oldin && oldin->is_dir() && straydn && !straydn->is_auth())
6074         force_journal_stray = _need_force_journal(oldin, true);
6075     
6076       if (linkmerge)
6077         dout(10) << " merging remote and primary links to the same inode" << dendl;
6078       if (silent)

________________________________________________________________________________________________________
*** CID 1201383:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7112 in Server::do_rename_rollback(ceph::buffer::list &, int, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
7106         le->commit.add_primary_dentry(target->get_projected_parent_dn(), target, true);
7107       }
7108     
7109       if (force_journal_dest) {
7110         dout(10) << " noting rename target ino " << target->ino() << " in metablob" << dendl;
7111         le->commit.renamed_dirino = target->ino();
>>>     CID 1201383:  Dereference after null check  (FORWARD_NULL)
>>>     Comparing "in" to null implies that "in" might be null.
7112       } else if (force_journal_src || (in && in->is_dir() && srcdn->authority().first == whoami)) {
7113         dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
7114         le->commit.renamed_dirino = in->ino();
7115       }
7116       
7117       if (target && target->is_dir()) {

________________________________________________________________________________________________________
*** CID 1201384:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7154 in Server::_rename_rollback_finish(std::tr1::shared_ptr<MutationImpl> &, std::tr1::shared_ptr<MDRequestImpl> &, CDentry *, unsigned long, CDentry *, CDentry *, bool)()
7148         if (srcdn->authority().first == mds->get_nodeid())
7149           srcdn->mark_dirty(srcdnpv, mut->ls);
7150       }
7151     
7152       mut->apply();
7153     
>>>     CID 1201384:  Dereference after null check  (FORWARD_NULL)
>>>     Comparing "srcdn" to null implies that "srcdn" might be null.
7154       if (srcdn) {
7155         CInode *in = srcdn->get_linkage()->get_inode();
7156         // update subtree map?
7157         if (in && in->is_dir()) {
7158           assert(destdn);
7159           mdcache->adjust_subtree_after_rename(in, destdn->get_dir(), true);

________________________________________________________________________________________________________
*** CID 1201385:  Using invalid iterator  (INVALIDATE_ITERATOR)
/mds/Locker.cc: 416 in Locker::acquire_locks(std::tr1::shared_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
410     	dout(10) << " already rdlocked " << *have << " " << *have->get_parent() << dendl;
411     	continue;
412           }
413         }
414         
415         // hose any stray locks
>>>     CID 1201385:  Using invalid iterator  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "existing" though it is already past the end of its container.
416         if (*existing == *p) {
417           assert(need_wrlock || need_remote_wrlock);
418           SimpleLock *lock = *existing;
419           if (mdr->wrlocks.count(lock)) {
420     	if (!need_wrlock)
421     	  dout(10) << " unlocking extra " << *lock << " " << *lock->get_parent() << dendl;
/mds/Locker.cc: 416 in Locker::acquire_locks(std::tr1::shared_ptr<MDRequestImpl> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::set<SimpleLock *, std::less<SimpleLock *>, std::allocator<SimpleLock *>> &, std::map<SimpleLock *, int, std::less<SimpleLock *>, std::allocator<std::pair<SimpleLock *const , int>>> *, CInode *, bool)()
410     	dout(10) << " already rdlocked " << *have << " " << *have->get_parent() << dendl;
411     	continue;
412           }
413         }
414         
415         // hose any stray locks
>>>     CID 1201385:  Using invalid iterator  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "existing" though it is already past the end of its container.
416         if (*existing == *p) {
417           assert(need_wrlock || need_remote_wrlock);
418           SimpleLock *lock = *existing;
419           if (mdr->wrlocks.count(lock)) {
420     	if (!need_wrlock)
421     	  dout(10) << " unlocking extra " << *lock << " " << *lock->get_parent() << dendl;

________________________________________________________________________________________________________
*** CID 1201386:  Using invalid iterator  (INVALIDATE_ITERATOR)
/test/librados/lock.cc: 371 in LibRadosLockECPP_BreakLockPP_Test::TestBody()()
365       sstm << "client." << cluster.get_instance_id();
366       std::string me = sstm.str();
367       ASSERT_EQ(0, ioctx.lock_exclusive("foo", "TestLock", "Cookie",  "", NULL, 0));
368       ASSERT_EQ(1, ioctx.list_lockers("foo", "TestLock", &exclusive, &tag, &lockers));
369       std::list<librados::locker_t>::iterator it = lockers.begin();
370       ASSERT_FALSE(lockers.end() == it);
>>>     CID 1201386:  Using invalid iterator  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "it" though it is already past the end of its container.
371       ASSERT_EQ(me, it->client);
372       ASSERT_EQ("Cookie", it->cookie);
373       ASSERT_EQ(0, ioctx.break_lock("foo", "TestLock", it->client, "Cookie"));

________________________________________________________________________________________________________
*** CID 1201387:  Using invalid iterator  (INVALIDATE_ITERATOR)
/test/librados/lock.cc: 330 in LibRadosLockECPP_ListLockersPP_Test::TestBody()()
324         int exclusive;
325         std::string tag;
326         std::list<librados::locker_t> lockers;
327         ASSERT_EQ(1, ioctx.list_lockers("foo", "TestLock", &exclusive, &tag, &lockers));
328         std::list<librados::locker_t>::iterator it = lockers.begin();
329         ASSERT_FALSE(lockers.end() == it);
>>>     CID 1201387:  Using invalid iterator  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "it" though it is already past the end of its container.
330         ASSERT_EQ(me, it->client);
331         ASSERT_EQ("Cookie", it->cookie);
332       }
333     }
334     
335     TEST_F(LibRadosLockEC, BreakLock) {

________________________________________________________________________________________________________
*** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 462 in Monitor::preinit()()
456              << "must have been removed" << dendl;
457         if (g_conf->mon_force_quorum_join) {
458           dout(0) << "we should have died but "
459                   << "'mon_force_quorum_join' is set -- allowing boot" << dendl;
460         } else {
461           derr << "commit suicide!" << dendl;
>>>     CID 1201388:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->lock._m".
462           return -ENOENT;
463         }
464       }
465     
466       {
467         // We have a potentially inconsistent store state in hands. Get rid of it

________________________________________________________________________________________________________
*** CID 1201389:  Out-of-bounds access  (OVERRUN)
/test/librbd/test_librbd.cc: 1825 in LibRBD_ZeroLengthDiscard_Test::TestBody()()
1819       uint64_t size = 2 << 20;
1820     
1821       ASSERT_EQ(0, create_image(ioctx, name, size, &order));
1822       ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
1823     
1824       const char *data = "blah";
>>>     CID 1201389:  Out-of-bounds access  (OVERRUN)
>>>     Allocating insufficient memory for the terminating null of the string.
1825       char read_data[strlen(data)];
1826       ASSERT_EQ((int)strlen(data), rbd_write(image, 0, strlen(data), data));
1827       ASSERT_EQ(0, rbd_discard(image, 0, 0));
1828       ASSERT_EQ((int)strlen(data), rbd_read(image, 0, strlen(data), read_data));
1829       ASSERT_EQ(0, memcmp(data, read_data, strlen(data)));
1830     

________________________________________________________________________________________________________
*** CID 1201390:  Out-of-bounds access  (OVERRUN_DYNAMIC)
/test/librbd/test_librbd.cc: 1825 in LibRBD_ZeroLengthDiscard_Test::TestBody()()
1819       uint64_t size = 2 << 20;
1820     
1821       ASSERT_EQ(0, create_image(ioctx, name, size, &order));
1822       ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
1823     
1824       const char *data = "blah";
>>>     CID 1201390:  Out-of-bounds access  (OVERRUN_DYNAMIC)
>>>     Allocating insufficient memory for the terminating null of the string.
1825       char read_data[strlen(data)];
1826       ASSERT_EQ((int)strlen(data), rbd_write(image, 0, strlen(data), data));
1827       ASSERT_EQ(0, rbd_discard(image, 0, 0));
1828       ASSERT_EQ((int)strlen(data), rbd_read(image, 0, strlen(data), read_data));
1829       ASSERT_EQ(0, memcmp(data, read_data, strlen(data)));
1830     

________________________________________________________________________________________________________
*** CID 1201391:  Out-of-bounds write  (OVERRUN_STATIC)
/erasure-code/jerasure/gf-complete/src/gf_w8.c: 1267 in gf_w8_table_init()
1261               ltd->div[prod][b] = a;
1262               ltd->smult[a][b] = prod;
1263               break;
1264             case 3:
1265               dd->multtable[a][b] = prod;
1266               dd->divtable[prod][b] = a;
>>>     CID 1201391:  Out-of-bounds write  (OVERRUN_STATIC)
>>>     Overrunning static array "dd->low[a]", with 16 elements, at position 255 with index variable "b".
1267               if ((b & 0xf) == b) { dd->low[a][b] = prod; }
1268               if ((b & 0xf0) == b) { dd->high[a][b>>4] = prod; }
1269               break;
1270           }
1271         }
1272       }

________________________________________________________________________________________________________
*** CID 1201392:  Resource leak  (RESOURCE_LEAK)
/test/librados/TestCase.cc: 134 in RadosTestEC::cleanup_default_namespace(void *)()
128     void RadosTestEC::cleanup_default_namespace(rados_ioctx_t ioctx)
129     {
130       // remove all objects from the default namespace to avoid polluting
131       // other tests
132       rados_ioctx_set_namespace(ioctx, "");
133       rados_list_ctx_t list_ctx;
>>>     CID 1201392:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
134       ASSERT_EQ(0, rados_objects_list_open(ioctx, &list_ctx));
135       int r;
136       const char *entry = NULL;
137       const char *key = NULL;
138       while ((r = rados_objects_list_next(list_ctx, &entry, &key)) != -ENOENT) {
139         ASSERT_EQ(0, r);
/test/librados/TestCase.cc: 139 in RadosTestEC::cleanup_default_namespace(void *)()
133       rados_list_ctx_t list_ctx;
134       ASSERT_EQ(0, rados_objects_list_open(ioctx, &list_ctx));
135       int r;
136       const char *entry = NULL;
137       const char *key = NULL;
138       while ((r = rados_objects_list_next(list_ctx, &entry, &key)) != -ENOENT) {
>>>     CID 1201392:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
139         ASSERT_EQ(0, r);
140         rados_ioctx_locator_set_key(ioctx, key);
141         ASSERT_EQ(0, rados_remove(ioctx, entry));
142       }
143       rados_objects_list_close(list_ctx);
144     }
/test/librados/TestCase.cc: 141 in RadosTestEC::cleanup_default_namespace(void *)()
135       int r;
136       const char *entry = NULL;
137       const char *key = NULL;
138       while ((r = rados_objects_list_next(list_ctx, &entry, &key)) != -ENOENT) {
139         ASSERT_EQ(0, r);
140         rados_ioctx_locator_set_key(ioctx, key);
>>>     CID 1201392:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "list_ctx" going out of scope leaks the storage it points to.
141         ASSERT_EQ(0, rados_remove(ioctx, entry));
142       }
143       rados_objects_list_close(list_ctx);
144     }
145     
146     std::string RadosTestECPP::pool_name;

________________________________________________________________________________________________________
*** CID 1201393:  Resource leak  (RESOURCE_LEAK)
/test/librados/aio.cc: 1881 in LibRadosAioEC_RoundTripAppend_Test::TestBody()()
1875     }
1876     
1877     TEST(LibRadosAioEC, RoundTripAppend) {
1878       AioTestDataEC test_data;
1879       rados_completion_t my_completion, my_completion2, my_completion3, my_completion4;
1880       ASSERT_EQ("", test_data.init());
>>>     CID 1201393:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
1881       ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
1882     	      set_completion_completeEC, set_completion_safeEC, &my_completion));
1883       ASSERT_TRUE(rados_ioctx_pool_requires_alignment(test_data.m_ioctx));
1884       uint64_t alignment = rados_ioctx_pool_required_alignment(test_data.m_ioctx);
1885       ASSERT_NE((unsigned)0, alignment);
1886     
/test/librados/aio.cc: 1883 in LibRadosAioEC_RoundTripAppend_Test::TestBody()()
1877     TEST(LibRadosAioEC, RoundTripAppend) {
1878       AioTestDataEC test_data;
1879       rados_completion_t my_completion, my_completion2, my_completion3, my_completion4;
1880       ASSERT_EQ("", test_data.init());
1881       ASSERT_EQ(0, rados_aio_create_completion((void*)&test_data,
1882     	      set_completion_completeEC, set_completion_safeEC, &my_completion));
>>>     CID 1201393:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "my_completion" going out of scope leaks the storage it points to.
1883       ASSERT_TRUE(rados_ioctx_pool_requires_alignment(test_data.m_ioctx));
1884       uint64_t alignment = rados_ioctx_pool_required_alignment(test_data.m_ioctx);
1885       ASSERT_NE((unsigned)0, alignment);
1886     
1887       int bsize = alignment;
1888       char *buf = (char *)new char[bsize];


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=Overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-449499710-1397275568=:16913--
