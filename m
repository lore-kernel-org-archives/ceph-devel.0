From: Sage Weil <sage@redhat.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Fri, 20 Jun 2014 07:46:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406200746170.14202@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1381297046-1403275581=:14202"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46928 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbaFTOqV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 10:46:21 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 341BB80060
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 07:46:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 049DB80060
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 07:46:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1381297046-1403275581=:14202
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-1381297046-1403275581=:14202
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1406200746171.14202@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id B32DA80060
	for <sage@cobra.newdream.net>; Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id B0E1E12097A; Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (caiajhbdcbae.dreamhost.com
	[208.97.132.104])
	by destro.newdream.net (Postfix) with ESMTP id AFF72120979
	for <sage@newdream.net>; Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	A9D391616280
	for <sage@newdream.net>; Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from connor.dreamhost.com ([208.97.132.17])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id UpNBQZKeatze for <sage@newdream.net>;
	Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id 790E12CA803B
	for <sage@newdream.net>; Fri, 20 Jun 2014 07:40:50 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Fri, 20 Jun 2014 07:40:49 -0700
Date: Fri, 20 Jun 2014 07:40:48 -0700
From: scan-admin@coverity.com
Message-ID: <53a447f0c9bf4_726b7ed3307621f@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2014 14:40:49.0021 (UTC)
	FILETIME=[A0A4E2D0:01CF8C95]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 1223276:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/tools/rados/rados.cc: 1368 in rados_tool_common(const std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &, std::vector<const char *, std::allocator<const char *>> &)()


________________________________________________________________________________________________________
*** CID 1223276:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/tools/rados/rados.cc: 1368 in rados_tool_common(const std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>>>> &, std::vector<const char *, std::allocator<const char *>> &)()
1362       }
1363     
1364       // align op_size
1365       if (io_ctx.pool_requires_alignment()) {
1366         const uint64_t align = io_ctx.pool_required_alignment();
1367         const bool wrn = (op_size != (1<<22));
>>>     CID 1223276:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "(op_size + align - 1UL) / align", division by expression "align" which may be zero has undefined behavior.
1368         op_size = uint64_t((op_size + align - 1) / align) * align;
1369         if (wrn)
1370           cerr << "INFO: op_size has been rounded to " << op_size << std::endl;
1371       }
1372     
1373       // snapname?


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1381297046-1403275581=:14202--
