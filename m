From: Dan Mick <dan.mick@dreamhost.com>
Subject: Problem with google-pprof
Date: Fri, 27 Apr 2012 10:10:22 -0700
Message-ID: <4F9AD2FE.7080508@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34021 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759978Ab2D0RKX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Apr 2012 13:10:23 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 54F0C244BD
	for <ceph-devel@vger.kernel.org>; Fri, 27 Apr 2012 10:14:02 -0700 (PDT)
Received: from [192.168.107.140] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 4AE9F242E5
	for <ceph-devel@vger.kernel.org>; Fri, 27 Apr 2012 10:14:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I spent some time looking into why google-pprof was broken with 
debug-stripped binaries.  It relates to an issue with addr2line that I'm 
still looking into, but the easy workaround is to add /usr/lib/debug to 
the path of the binary you're interested in running analysis on.  That 
is, instead of

google-pprof <display options> /usr/bin/ceph-osd <profile>

you say

google-pprof <display options> /usr/lib/debug/usr/bin/ceph-osd <profile>

