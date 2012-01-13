From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/4] ceph: properly protect session cap_gen and cap_ttl
Date: Fri, 13 Jan 2012 11:49:57 -0800
Message-ID: <1326484197.3334.27.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38991 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab2AMTt6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 14:49:58 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 091CCC066
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:06 -0800 (PST)
Received: from [192.168.107.250] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E894EC062
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series addresses a few issues with the use of the
ceph_mds_session s_cap_gen and s_cap_ttl fields.

These two fields are used for handling session timeouts, etc.  At
times they need to be updated or sampled together, and until now
this has been done under the protection of the session's s_cap_lock.
However this results in a possible circular locking dependency. 
This is fixed by introducing a new "inner" lock specifically for
protecting this case.

In addition, since these fields are used for synchronization (and
especially since one is 64 bits), convert them use atomic types.

					-Alex


