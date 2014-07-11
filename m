From: Sage Weil <sweil@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Thu, 10 Jul 2014 20:39:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407102039400.18633@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-50316706-1405049983=:18633"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42356 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbaGKDjo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jul 2014 23:39:44 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AF46A81354
	for <ceph-devel@vger.kernel.org>; Thu, 10 Jul 2014 20:39:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A0A7881354
	for <ceph-devel@vger.kernel.org>; Thu, 10 Jul 2014 20:39:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-50316706-1405049983=:18633
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-50316706-1405049983=:18633
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1407102039401.18633@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 627FB81354
	for <sage@cobra.newdream.net>; Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 4A9BF120A85; Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdcbfh.dreamhost.com
	[208.97.132.157])
	by destro.newdream.net (Postfix) with ESMTP id 49260120A5D
	for <sage@newdream.net>; Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id 3B0B717BD664
	for <sage@newdream.net>; Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id laofewFC5imo for <sage@newdream.net>;
	Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id 163731B006A
	for <sage@newdream.net>; Thu, 10 Jul 2014 20:18:30 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Thu, 10 Jul 2014 20:18:29 -0700
Date: Thu, 10 Jul 2014 20:18:29 -0700
From: scan-admin@coverity.com
Message-ID: <53bf57855235f_634cff331839678@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jul 2014 03:18:29.0570 (UTC)
	FILETIME=[C9812A20:01CF9CB6]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 438 in Monitor::preinit()()

** CID 1225099:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1409 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::
 basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<cha
 r>> &, int &)()

** CID 1225100:  Missing unlock  (LOCK)
/mds/MDLog.cc: 511 in MDLog::trim(int)()
/mds/MDLog.cc: 511 in MDLog::trim(int)()

** CID 1225101:  Missing unlock  (LOCK)
/mds/MDLog.cc: 394 in MDLog::shutdown()()

** CID 1225102:  Dereference before null check  (REVERSE_INULL)
/mon/Monitor.cc: 746 in Monitor::shutdown()()


________________________________________________________________________________________________________
*** CID 1201388:  Missing unlock  (LOCK)
/mon/Monitor.cc: 438 in Monitor::preinit()()
432     
433       dout(1) << "preinit fsid " << monmap->fsid << dendl;
434     
435       int r = sanitize_options();
436       if (r < 0) {
437         derr << "option sanitization failed!" << dendl;
>>>     CID 1201388:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->lock._m".
438         return r;
439       }
440     
441       assert(!logger);
442       {
443         PerfCountersBuilder pcb(g_ceph_context, "mon", l_mon_first, l_mon_last);

________________________________________________________________________________________________________
*** CID 1225099:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1409 in MDSMonitor::filesystem_command(MMonCommand *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>, std::less<std::
 basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detai
 l::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_, boost::detail::variant::void_>>>> &, std::basic_stringstream<char, std::char_traits<char>, std::allocator<cha
 r>> &, int &)()
1403           r = -EINVAL;
1404           poolid = -1;
1405           ss << "cannot remove default data pool";
1406         }
1407     
1408         if (poolid >= 0) {
>>>     CID 1225099:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "cmd_getval" without checking return value (as is done elsewhere 22 out of 25 times).
1409           cmd_getval(g_ceph_context, cmdmap, "poolid", poolid);
1410           r = pending_mdsmap.remove_data_pool(poolid);
1411           if (r == -ENOENT)
1412     	r = 0;
1413           if (r == 0)
1414     	ss << "removed data pool " << poolid << " from mdsmap";

________________________________________________________________________________________________________
*** CID 1225100:  Missing unlock  (LOCK)
/mds/MDLog.cc: 511 in MDLog::trim(int)()
505           p = segments.lower_bound(last_seq + 1);
506         }
507       }
508     
509       // discard expired segments and unlock submit_mutex
510       _trim_expired_segments();
>>>     CID 1225100:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
511     }
512     
513     
514     void MDLog::try_expire(LogSegment *ls, int op_prio)
515     {
516       C_GatherBuilder gather_bld(g_ceph_context);
/mds/MDLog.cc: 511 in MDLog::trim(int)()
505           p = segments.lower_bound(last_seq + 1);
506         }
507       }
508     
509       // discard expired segments and unlock submit_mutex
510       _trim_expired_segments();
>>>     CID 1225100:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
511     }
512     
513     
514     void MDLog::try_expire(LogSegment *ls, int op_prio)
515     {
516       C_GatherBuilder gather_bld(g_ceph_context);

________________________________________________________________________________________________________
*** CID 1225101:  Missing unlock  (LOCK)
/mds/MDLog.cc: 394 in MDLog::shutdown()()
388       submit_mutex.Lock();
389       stopping = true;
390       submit_cond.Signal();
391       submit_mutex.Unlock();
392     
393       mds->mds_lock.Lock();
>>>     CID 1225101:  Missing unlock  (LOCK)
>>>     Returning without unlocking "this->mds->mds_lock._m".
394     }
395     
396     
397     // -----------------------------
398     // segments
399     

________________________________________________________________________________________________________
*** CID 1225102:  Dereference before null check  (REVERSE_INULL)
/mon/Monitor.cc: 746 in Monitor::shutdown()()
740       finish_contexts(g_ceph_context, maybe_wait_for_quorum, -ECANCELED);
741     
742       timer.shutdown();
743     
744       remove_all_sessions();
745     
>>>     CID 1225102:  Dereference before null check  (REVERSE_INULL)
>>>     Null-checking "this->logger" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
746       if (logger) {
747         cct->get_perfcounters_collection()->remove(logger);
748         delete logger;
749         logger = NULL;
750       }
751       if (cluster_logger) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-50316706-1405049983=:18633--
