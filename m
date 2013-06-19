From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Wed, 19 Jun 2013 12:36:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306191235300.27900@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-329934276-1371670562=:27900"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54307 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566Ab3FSTgC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 15:36:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic@dachary.org
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-329934276-1371670562=:27900
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Loic,

Do you mind looking at the PGLog.cc iterator issue coverity picked up on?

sage
--557981400-329934276-1371670562=:27900
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1306191235310.27900@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 46F12803BB
	for <sage@cobra.newdream.net>; Wed, 19 Jun 2013 12:32:04 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 44DA66C10E; Wed, 19 Jun 2013 12:32:04 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdccah.dreamhost.com
	[208.97.132.207])
	by destro.newdream.net (Postfix) with ESMTP id 417366C0E5
	for <sage@newdream.net>; Wed, 19 Jun 2013 12:32:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id 3B65017BD611
	for <sage@newdream.net>; Wed, 19 Jun 2013 12:32:04 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from connor.dreamhost.com ([208.97.132.177])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id rz+cayuGfEGP for <sage@newdream.net>;
	Wed, 19 Jun 2013 12:32:04 -0700 (PDT)
Received: from build-l3.scan.coverity.com (unknown [208.69.177.216])
	by connor.dreamhost.com (Postfix) with ESMTP id 03E942C98EF8
	for <sage@newdream.net>; Wed, 19 Jun 2013 12:22:36 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=build-l3.scan.coverity.com)
	by build-l3.scan.coverity.com with esmtp (Exim 4.69)
	(envelope-from <scan-admin@coverity.com>)
	id 1UpNxh-0008B9-Nl; Wed, 19 Jun 2013 12:22:33 -0700
From: scan-admin@coverity.com
To: sage@newdream.net
CC: 
Subject: New Defects reported by Coverity Scan for ceph
Message-Id: <E1UpNxh-0008B9-Nl@build-l3.scan.coverity.com>
Date: Wed, 19 Jun 2013 12:22:33 -0700
X-Spambayes-Classification: ham; 0.00



Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan

Defect(s) Reported-by: Coverity Scan

	
** CID 1035577: Resource leak (RESOURCE_LEAK)
/test/libcephfs/multiclient.cc: 67

** CID 1035576: Resource leak (RESOURCE_LEAK)
/test/libcephfs/multiclient.cc: 32

** CID 1035575: Resource leak (RESOURCE_LEAK)
/test/libcephfs/multiclient.cc: 27

** CID 1035574: Using invalid iterator (INVALIDATE_ITERATOR)
/osd/PGLog.cc: 369


________________________________________________________________________
CID 1035577: Resource leak (RESOURCE_LEAK)

/test/libcephfs/multiclient.cc: 67 ( alloc_arg)
   64    
   65    TEST(LibCephFS, MulticlientHoleEOF) {
   66      struct ceph_mount_info *ca, *cb;
>>> "ceph_create(ceph_mount_info **, char const *)" allocates memory that is stored into "ca".
   67      ASSERT_EQ(ceph_create(&ca, NULL), 0);
   68      ASSERT_EQ(0, ceph_conf_parse_env(ca, NULL));
   69      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   70      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   71    
  

/test/libcephfs/multiclient.cc: 67 ( leaked_storage)
   64    
   65    TEST(LibCephFS, MulticlientHoleEOF) {
   66      struct ceph_mount_info *ca, *cb;
>>> CID 1035577: Resource leak (RESOURCE_LEAK)
>>> Variable "ca" going out of scope leaks the storage it points to.
   67      ASSERT_EQ(ceph_create(&ca, NULL), 0);
   68      ASSERT_EQ(0, ceph_conf_parse_env(ca, NULL));
   69      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   70      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   71    
  
________________________________________________________________________
CID 1035576: Resource leak (RESOURCE_LEAK)

/test/libcephfs/multiclient.cc: 32 ( alloc_arg)
   29      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   30      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   31    
>>> "ceph_create(ceph_mount_info **, char const *)" allocates memory that is stored into "cb".
   32      ASSERT_EQ(ceph_create(&cb, NULL), 0);
   33      ASSERT_EQ(0, ceph_conf_parse_env(cb, NULL));
   34      ASSERT_EQ(ceph_conf_read_file(cb, NULL), 0);
   35      ASSERT_EQ(ceph_mount(cb, NULL), 0);
   36    
  

/test/libcephfs/multiclient.cc: 32 ( leaked_storage)
   29      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   30      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   31    
>>> CID 1035576: Resource leak (RESOURCE_LEAK)
>>> Variable "cb" going out of scope leaks the storage it points to.
   32      ASSERT_EQ(ceph_create(&cb, NULL), 0);
   33      ASSERT_EQ(0, ceph_conf_parse_env(cb, NULL));
   34      ASSERT_EQ(ceph_conf_read_file(cb, NULL), 0);
   35      ASSERT_EQ(ceph_mount(cb, NULL), 0);
   36    
  
________________________________________________________________________
CID 1035575: Resource leak (RESOURCE_LEAK)

/test/libcephfs/multiclient.cc: 27 ( alloc_arg)
   24    
   25    TEST(LibCephFS, MulticlientSimple) {
   26      struct ceph_mount_info *ca, *cb;
>>> "ceph_create(ceph_mount_info **, char const *)" allocates memory that is stored into "ca".
   27      ASSERT_EQ(ceph_create(&ca, NULL), 0);
   28      ASSERT_EQ(0, ceph_conf_parse_env(ca, NULL));
   29      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   30      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   31    
  

/test/libcephfs/multiclient.cc: 27 ( leaked_storage)
   24    
   25    TEST(LibCephFS, MulticlientSimple) {
   26      struct ceph_mount_info *ca, *cb;
>>> CID 1035575: Resource leak (RESOURCE_LEAK)
>>> Variable "ca" going out of scope leaks the storage it points to.
   27      ASSERT_EQ(ceph_create(&ca, NULL), 0);
   28      ASSERT_EQ(0, ceph_conf_parse_env(ca, NULL));
   29      ASSERT_EQ(ceph_conf_read_file(ca, NULL), 0);
   30      ASSERT_EQ(ceph_mount(ca, NULL), 0);
   31    
  
________________________________________________________________________
CID 1035574: Using invalid iterator (INVALIDATE_ITERATOR)

/osd/PGLog.cc: 361 ( past_the_end)
   358      dout(10) << "rewind_divergent_log truncate divergent future " << newhead << dendl;
   359      assert(newhead > log.tail);
   360    
>>> Function "end" creates an iterator.
   361      list<pg_log_entry_t>::iterator p = log.log.end();
   362      list<pg_log_entry_t> divergent;
   363      while (true) {
   364        if (p == log.log.begin()) {
   365          // yikes, the whole thing is divergent!
  

/osd/PGLog.cc: 361 ( assign_var)
   358      dout(10) << "rewind_divergent_log truncate divergent future " << newhead << dendl;
   359      assert(newhead > log.tail);
   360    
>>> Assigning: "p" = "this->log.log.end()".
   361      list<pg_log_entry_t>::iterator p = log.log.end();
   362      list<pg_log_entry_t> divergent;
   363      while (true) {
   364        if (p == log.log.begin()) {
   365          // yikes, the whole thing is divergent!
  

/osd/PGLog.cc: 369 ( deref_iterator)
   366          divergent.swap(log.log);
   367          break;
   368        }
>>> CID 1035574: Using invalid iterator (INVALIDATE_ITERATOR)
>>> Dereferencing iterator "p" though it is already past the end of its container.
   369        mark_dirty_from(p->version);
   370        --p;
   371        if (p->version == newhead) {
   372          ++p;
   373          divergent.splice(divergent.begin(), log.log, p, log.log.end());
  
________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py


--557981400-329934276-1371670562=:27900--
