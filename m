From: Alex Elder <elder@dreamhost.com>
Subject: Dependencies
Date: Mon, 05 Mar 2012 09:46:33 -0600
Message-ID: <4F54DFD9.1010209@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53339 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2CEPqd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 10:46:33 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1BDF124373
	for <ceph-devel@vger.kernel.org>; Mon,  5 Mar 2012 07:46:38 -0800 (PST)
Received: from [172.22.22.79] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E2E1C24303
	for <ceph-devel@vger.kernel.org>; Mon,  5 Mar 2012 07:46:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I occasionally bump into newly-required packages when I'm trying
to build ceph.  I don't remember what they have been, but today I
hit this when I tried "make clean":

     configure: error: --with-radosgw was given but libcurl (libcurl-dev 
on debian) not found

That was resolved by installing libcurl4-gnutls-dev (at least I
think that's what made it go away).

After that I hit this:

     configure: error: --with-gtk2 was given, but test for gtkmm failed

That took a number of trials, but eventually I think the package
that I installed which made this problem go away was libgtkmm-2.4-dev.

Is there any way that we can do any or all of these?
- we can identify when a new dependency like that has been added
- we can do this automatically
- we can mention something (like in a release announcement) when
   new dependencies have been added since last time
- we can do a nicer job of telling the user that a particular
   package is missing--better than the "test for gtmm failed" kind
   of message that the configure script provides

					-Alex
