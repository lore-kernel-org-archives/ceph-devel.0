From: Sage Weil <sweil@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Wed, 8 Oct 2014 07:59:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410080759250.742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2098900025-1412780373=:742"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46670 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbaJHO7e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 10:59:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: joao.luis@inktank.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2098900025-1412780373=:742
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-2098900025-1412780373=:742
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1410080759251.742@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 43FED80068
	for <sage@cobra.newdream.net>; Wed,  8 Oct 2014 06:21:48 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 30D22120C85; Wed,  8 Oct 2014 06:21:48 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id 2DC11120C7B
	for <sage@newdream.net>; Wed,  8 Oct 2014 06:21:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id 2941FFD802D
	for <sage@newdream.net>; Wed,  8 Oct 2014 06:21:48 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id R6XTzsEcjqQv for <sage@newdream.net>;
	Wed,  8 Oct 2014 06:21:48 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id 003EB1B0092
	for <sage@newdream.net>; Wed,  8 Oct 2014 06:21:47 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Wed, 8 Oct 2014 06:22:02 -0700
Date: Wed, 08 Oct 2014 06:21:47 -0700
From: scan-admin@coverity.com
To: sage@newdream.net
Message-ID: <54353a6b94a4d_233fcf3334855f2@scan.coverity.com.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2014 13:22:02.0252 (UTC)
	FILETIME=[D8B5ACC0:01CFE2FA]
X-Spambayes-Classification: ham; 0.00



Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

6 new defect(s) introduced to ceph found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 6 of 6 defect(s)


** CID 1244195:  Dereference after null check  (FORWARD_NULL)
/mon/Monitor.cc: 3110 in Monitor::_ms_dispatch(Message *)()

** CID 1244196:  Data race condition  (MISSING_LOCK)
/test/mon/test-mon-msg.cc: 229 in MonMsgTest::SetUp()()

** CID 1244197:  Dereference before null check  (REVERSE_INULL)
/mon/Monitor.cc: 3366 in Monitor::dispatch(MonSession *, Message *, bool)()

** CID 1244198:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/mon/test-mon-msg.cc: 322 in main()
/test/mon/test-mon-msg.cc: 322 in main()
/test/mon/test-mon-msg.cc: 322 in main()

** CID 1244200:  Uninitialized pointer field  (UNINIT_CTOR)
/test/mon/test-mon-msg.cc: 67 in MonClientHelper::MonClientHelper(CephContext *)()

** CID 1244199:  Uninitialized pointer field  (UNINIT_CTOR)
/test/mon/test-mon-msg.cc: 225 in MonMsgTest::MonMsgTest()()


________________________________________________________________________________________________________
*** CID 1244195:  Dereference after null check  (FORWARD_NULL)
/mon/Monitor.cc: 3110 in Monitor::_ms_dispatch(Message *)()
3104       if (s && s->closed) {
3105         caps = s->caps;
3106         reuse_caps = true;
3107         s->put();
3108         s = NULL;
3109       }
>>>     CID 1244195:  Dereference after null check  (FORWARD_NULL)
>>>     Comparing "s" to null implies that "s" might be null.
3110       if (!s) {
3111         // if the sender is not a monitor, make sure their first message for a
3112         // session is an MAuth.  If it is not, assume it's a stray message,
3113         // and considering that we are creating a new session it is safe to
3114         // assume that the sender hasn't authenticated yet, so we have no way
3115         // of assessing whether we should handle it or not.

________________________________________________________________________________________________________
*** CID 1244196:  Data race condition  (MISSING_LOCK)
/test/mon/test-mon-msg.cc: 229 in MonMsgTest::SetUp()()
223       MonMsgTest() :
224         MonClientHelper(g_ceph_context),
225         lock("lock") { }
226     
227     public:
228       virtual void SetUp() {
>>>     CID 1244196:  Data race condition  (MISSING_LOCK)
>>>     Accessing "this->reply_type" without holding lock "Mutex._m". Elsewhere, "MonMsgTest.reply_type" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
229         reply_type = -1;
230         if (reply_msg) {
231           reply_msg->put();
232           reply_msg = NULL;
233         }
234         ASSERT_EQ(init(), 0);

________________________________________________________________________________________________________
*** CID 1244197:  Dereference before null check  (REVERSE_INULL)
/mon/Monitor.cc: 3366 in Monitor::dispatch(MonSession *, Message *, bool)()
3360           }
3361           break;
3362     
3363         // elector messages
3364         case MSG_MON_ELECTION:
3365           //check privileges here for simplicity
>>>     CID 1244197:  Dereference before null check  (REVERSE_INULL)
>>>     Null-checking "s" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
3366           if (s &&
3367               !s->is_capable("mon", MON_CAP_X)) {
3368             dout(0) << "MMonElection received from entity without enough caps!"
3369               << s->caps << dendl;
3370             m->put();
3371             break;

________________________________________________________________________________________________________
*** CID 1244198:  Uncaught exception  (UNCAUGHT_EXCEPT)
/test/mon/test-mon-msg.cc: 322 in main()
316     
317       int r = monc.get_monmap();
318       ASSERT_EQ(r, 0);
319       ASSERT_FALSE(monc.monmap.contains("client"));
320     }
321     
>>>     CID 1244198:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
322     int main(int argc, char *argv[])
323     {
324       vector<const char*> def_args;
325       vector<const char*> args;
326       argv_to_vec(argc, (const char **)argv, args);
327     
/test/mon/test-mon-msg.cc: 322 in main()
316     
317       int r = monc.get_monmap();
318       ASSERT_EQ(r, 0);
319       ASSERT_FALSE(monc.monmap.contains("client"));
320     }
321     
>>>     CID 1244198:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
322     int main(int argc, char *argv[])
323     {
324       vector<const char*> def_args;
325       vector<const char*> args;
326       argv_to_vec(argc, (const char **)argv, args);
327     
/test/mon/test-mon-msg.cc: 322 in main()
316     
317       int r = monc.get_monmap();
318       ASSERT_EQ(r, 0);
319       ASSERT_FALSE(monc.monmap.contains("client"));
320     }
321     
>>>     CID 1244198:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::FailedAssertion" is thrown and never caught.
322     int main(int argc, char *argv[])
323     {
324       vector<const char*> def_args;
325       vector<const char*> args;
326       argv_to_vec(argc, (const char **)argv, args);
327     

________________________________________________________________________________________________________
*** CID 1244200:  Uninitialized pointer field  (UNINIT_CTOR)
/test/mon/test-mon-msg.cc: 67 in MonClientHelper::MonClientHelper(CephContext *)()
61     
62       MonClientHelper(CephContext *cct_)
63         : Dispatcher(cct_),
64           cct(cct_),
65           monc(cct_),
66           lock("mon-msg-test::lock")
>>>     CID 1244200:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "msg" is not initialized in this constructor nor in any functions that it calls.
67       { }
68     
69     
70       int post_init() {
71         dout(1) << __func__ << dendl;
72         if (!msg)

________________________________________________________________________________________________________
*** CID 1244199:  Uninitialized pointer field  (UNINIT_CTOR)
/test/mon/test-mon-msg.cc: 225 in MonMsgTest::MonMsgTest()()
219       Message *reply_msg;
220       Mutex lock;
221       Cond cond;
222     
223       MonMsgTest() :
224         MonClientHelper(g_ceph_context),
>>>     CID 1244199:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "reply_msg" is not initialized in this constructor nor in any functions that it calls.
225         lock("lock") { }
226     
227     public:
228       virtual void SetUp() {
229         reply_type = -1;
230         if (reply_msg) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-2098900025-1412780373=:742--
